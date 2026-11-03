#!/usr/bin/env python3
"""Read-only DEB control/Flutter resource version gate; no installation/extraction."""
import argparse
import json
import subprocess
import tarfile

def validate(control, resource, version, build, arch):
    expected={'Package':'com.caucy.vibekits','Architecture':arch,
              'Version':version.replace('-dev.','~dev.')+'+'+str(build),
              'X-Kemi-Version-Code':str(build)}
    for key,value in expected.items():
        if control.get(key)!=value:
            raise ValueError('DEB '+key+' mismatch')
    if resource.get('version')!=version or str(resource.get('build_number'))!=str(build):
        raise ValueError('Flutter version.json mismatch')

def member(package, archive, wanted):
    p=subprocess.Popen(['ar','p',package,archive],stdout=subprocess.PIPE,stderr=subprocess.DEVNULL)
    try:
        with tarfile.open(fileobj=p.stdout,mode='r|*') as stream:
            for item in stream:
                if (item.name[2:] if item.name.startswith('./') else item.name)==wanted:
                    if not item.isfile() or not 0<item.size<=65536:
                        raise ValueError('Invalid version metadata entry')
                    return stream.extractfile(item).read(65537)
        raise ValueError('Missing '+wanted)
    finally:
        p.stdout.close()
        if p.poll() is None:p.terminate()
        p.wait(timeout=5)

def self_test():
    control={'Package':'com.caucy.vibekits','Architecture':'amd64',
             'Version':'1.9.0~dev.684+2684','X-Kemi-Version-Code':'2684'}
    resource={'version':'1.9.0-dev.684','build_number':'2684'}
    validate(control,resource,'1.9.0-dev.684',2684,'amd64')
    rejected=0
    for c,r in [(control,{'version':'1.9.0-dev.681','build_number':'2681'}),
                ({**control,'X-Kemi-Version-Code':'2681'},resource),
                ({**control,'Architecture':'arm64'},resource),
                ({**control,'Package':'another.product'},resource)]:
        try:validate(c,r,'1.9.0-dev.684',2684,'amd64')
        except ValueError:rejected+=1
    assert rejected==4
    print('PASS: coherent metadata; four mismatch negative controls rejected')

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('package',nargs='?')
    parser.add_argument('--version')
    parser.add_argument('--build',type=int)
    parser.add_argument('--arch',choices=['amd64','arm64'])
    parser.add_argument('--self-test',action='store_true')
    args=parser.parse_args()
    if args.self_test:self_test()
    else:
        if not all([args.package,args.version,args.build,args.arch]):parser.error('package/version/build/arch required')
        archives=subprocess.check_output(['ar','t',args.package],text=True).splitlines()
        ctl=next(n for n in archives if n.startswith('control.tar'))
        data=next(n for n in archives if n.startswith('data.tar'))
        raw=member(args.package,ctl,'control').decode()
        control={line.split(':',1)[0]:line.split(':',1)[1].strip() for line in raw.splitlines() if ':' in line and not line.startswith(' ')}
        resource=json.loads(member(args.package,data,'opt/vibekits/data/flutter_assets/version.json'))
        validate(control,resource,args.version,args.build,args.arch)
        print(json.dumps({'status':'PASS','package':control['Package'],'architecture':args.arch,
                          'version':args.version,'build':args.build,'flutterResource':resource}))
