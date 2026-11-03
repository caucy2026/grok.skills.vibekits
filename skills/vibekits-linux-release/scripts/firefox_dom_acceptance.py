"""Official Firefox driver, isolated synthetic page, loopback-only and cleanup."""
import argparse,hashlib,json,os,re,subprocess,sys,time
from pathlib import Path
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--task-root',type=Path,required=True)
parser.add_argument('--driver-dir',type=Path,required=True)
parser.add_argument('--run-id',required=True)
parser.add_argument('--display',default=os.environ.get('DISPLAY'))
parser.add_argument('--xauthority',default=os.environ.get('XAUTHORITY'))
assets=Path(__file__).resolve().parents[1]/'assets'
parser.add_argument('--fixture',type=Path,default=assets/'firefox-dom-acceptance.html')
parser.add_argument('--upload',type=Path,default=assets/'browser-upload-fixture.txt')
args=parser.parse_args()
assert os.geteuid()!=0 and re.fullmatch(r'[a-z0-9-]{1,48}',args.run_id)
task=args.task_root.resolve();assert task.is_dir() and task.stat().st_uid==os.getuid()
assert args.display and args.xauthority and Path(args.xauthority).is_file()
fixture=args.fixture.resolve();upload=args.upload.resolve()
assert upload.stat().st_size==46 and hashlib.sha256(upload.read_bytes()).hexdigest()=='105817d9d7f373a25d6888935466dc7d1aaee72e03e79aeb8df3a28fbfa7cf44'
assert fixture.is_file() and hashlib.sha256(fixture.read_bytes()).hexdigest()=='532853341611271039f47b8446b933bab21cb6a0f32621d276236e4ffb85b22c'
driver=args.driver_dir.resolve();assert driver.is_dir() and driver.stat().st_uid==os.getuid()
sys.path.insert(0,str(driver))
from importlib.metadata import version
assert version('marionette-driver')=='3.7.1'
r=task/('browser-dom-'+args.run_id);assert not r.exists();r.mkdir(mode=0o700)
receipt=r/'result.json';profile=r/'profile'
from marionette_driver.marionette import Marionette
from marionette_driver.by import By
profile.mkdir(mode=0o700)
(profile/'user.js').write_text('user_pref("marionette.port", 0);\nuser_pref("browser.shell.checkDefaultBrowser", false);\n')
env=os.environ.copy();env.update(DISPLAY=args.display,XAUTHORITY=args.xauthority)
runtime=Path(env.get('XDG_RUNTIME_DIR') or ('/run/user/'+str(os.getuid())))
assert runtime.is_dir() and runtime.stat().st_uid==os.getuid()
env['XDG_RUNTIME_DIR']=str(runtime)
if (runtime/'bus').exists():env.setdefault('DBUS_SESSION_BUS_ADDRESS','unix:path='+str(runtime/'bus'))
log=(r/'firefox.log').open('x')
browser=subprocess.Popen(['/usr/bin/firefox','--no-remote','--marionette','--profile',str(profile),fixture.as_uri()],env=env,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
result={'state':'starting','driverPid':os.getpid(),'browserPid':browser.pid,'driverVersion':'3.7.1','firefoxVersion':None,'rows':[],'onlySyntheticLocalPage':True,'noUserProfileAccess':True}
receipt.write_text(json.dumps(result))
client=None;stage='verify-loopback';port=None
def listeners(pid):
    inodes=set()
    for fd in Path('/proc',str(pid),'fd').iterdir():
        try:
            target=os.readlink(fd)
            if target.startswith('socket:['):inodes.add(target[8:-1])
        except OSError:pass
    rows=[]
    for name in ('tcp','tcp6'):
        for line in (Path('/proc/net')/name).read_text().splitlines()[1:]:
            f=line.split()
            if f[3]!='0A' or f[9] not in inodes:continue
            address,p=f[1].split(':')
            assert address in ('0100007F','00000000000000000000000001000000'),'Listener is not loopback'
            rows.append(('127.0.0.1' if name=='tcp' else '::1',int(p,16)))
    return rows
try:
    deadline=time.monotonic()+30;bound=[]
    while time.monotonic()<deadline:
        assert browser.poll() is None,'Owned browser exited during startup'
        bound=listeners(browser.pid)
        if len({p for _,p in bound})==1:break
        time.sleep(.1)
    assert bound and len({p for _,p in bound})==1,'No unique owned loopback listener'
    host,port=next((h,p) for h,p in bound if h=='127.0.0.1') if any(h=='127.0.0.1' for h,p in bound) else bound[0]
    result.update(loopbackOnly=True,port=port)
    stage='session'
    client=Marionette(host=host,port=port,socket_timeout=10,startup_timeout=20)
    client.start_session(capabilities={'acceptInsecureCerts':False,'strictFileInteractability':True})
    caps=client.session_capabilities
    result['firefoxVersion']=caps.get('browserVersion')
    assert caps.get('moz:processID')==browser.pid,'Browser process identity changed'
    assert caps.get('acceptInsecureCerts') is False
    client.set_context('content');client.timeout.page_load=10
    stage='navigate';client.navigate(fixture.as_uri())
    assert client.execute_script('return location.href')==fixture.as_uri()
    stage='submit-counter-negative-control'
    client.find_element(By.ID,'submit-negative').click()
    assert client.execute_script('return Number(document.getElementById("fixture").dataset.submits)')==1
    result['realSubmitNegativeDetected']=True
    client.navigate(fixture.as_uri())
    for i in range(3):
        stage='unicode-input-round-'+str(i+1)
        single='  VibeKits-中文 😀-R'+str(i+1)+'  '
        multi='  第一行 😀\nSecond Line '+str(i+1)+'\n'
        one=client.find_element(By.ID,'single');one.clear();one.send_keys(single)
        many=client.find_element(By.ID,'multi');many.clear();many.send_keys(multi)
        actual=client.execute_script('return arguments[0].value',script_args=[one])
        assert actual==single,'Single synthetic input mismatch: '+repr(actual)
        actual=client.execute_script('return arguments[0].value',script_args=[many])
        assert actual==multi,'Multiline synthetic input mismatch: '+repr(actual)
        submits=client.execute_script('return Number(document.getElementById("fixture").dataset.submits)')
        assert submits==0,'Synthetic submit counter mismatch: '+repr(submits)
        client.find_element(By.ID,'verify').click()
        got=client.execute_script('return document.getElementById("result").textContent')
        assert json.loads(got)=={'single':single,'multi':multi,'submits':0},'Synthetic DOM click mismatch: '+got
        result['rows'].append({'round':i+1,'unicodeAndCaseExact':True,'multilineExact':True,'noUnexpectedSubmit':True,'domClickVerified':True})
        receipt.write_text(json.dumps(result))
    stage='file-selection'
    client.find_element(By.ID,'upload').send_keys(str(upload))
    got=client.execute_script('const f=document.getElementById("upload").files;return {count:f.length,name:f[0]?.name,size:f[0]?.size}')
    assert got=={'count':1,'name':upload.name,'size':46}
    result.update(state='passed',browserFileSelectionPassed=True)
except Exception as e:
    result.update(state='failed',failedStage=stage,errorClass=type(e).__name__,error=str(e)[:1000])
finally:
    if client is not None:
        try:client.delete_session()
        except Exception:pass
    if browser.poll() is None:
        browser.terminate()
        try:browser.wait(timeout=15)
        except subprocess.TimeoutExpired:browser.kill();browser.wait(timeout=5)
    result['ownedBrowserExited']=browser.poll() is not None
    listening=False
    if port is not None:
        for table in ('tcp','tcp6'):
            for line in (Path('/proc/net')/table).read_text().splitlines()[1:]:
                f=line.split()
                if f[3]=='0A' and int(f[1].split(':')[1],16)==port:listening=True
    result['temporaryListenerClosed']=not listening and not Path('/proc',str(browser.pid)).exists()
    receipt.write_text(json.dumps(result,indent=2));print(json.dumps(result))
raise SystemExit(0 if result['state']=='passed' and result['ownedBrowserExited'] and result['temporaryListenerClosed'] else 1)
