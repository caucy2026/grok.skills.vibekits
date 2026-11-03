"""Independent read-only final-DEB command dependency gate; never installs."""
import argparse,json,re,subprocess

def missing_cli_packages(depends):
    groups=[g.strip() for g in depends.replace('\n',' ').split(',')]
    required=('libglib2.0-bin','xdg-utils','libsecret-tools','openssh-client',
              'zenity','python3','python3-pyatspi','xdotool','x11-utils')
    missing=[]
    for name in required:
        pattern=re.escape(name)+r'(?::[a-z0-9-]+)?(?:\s+\([^)]*\))?'
        if not any(re.fullmatch(pattern,g) for g in groups):missing.append(name)
    return missing

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('package');args=parser.parse_args()
    raw=subprocess.check_output(['dpkg-deb','-f',args.package,'Depends'],text=True,timeout=30)
    missing=missing_cli_packages(raw)
    print(json.dumps({'status':'BLOCK' if missing else 'PASS','missingRuntimeCliPackages':missing}))
    return 2 if missing else 0

if __name__=='__main__':raise SystemExit(main())
