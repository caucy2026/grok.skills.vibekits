#!/usr/bin/env bash
set -euo pipefail
LINUX_RELEASE_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT=${1:?task root}
SOURCE=${2:?frozen source}
RELAY=${3:?verified relay}
case "$(uname -m)" in
 x86_64) ARCH=x64;DEBARCH=amd64;ELFARCH='x86-64';;
 aarch64) ARCH=arm64;DEBARCH=arm64;ELFARCH='ARM aarch64';;
 *) echo 'Unsupported architecture';exit 2;;
esac
test -n "${EXPECTED_RELAY_SHA:-}"
test "$(sha256sum "$RELAY" | cut -d' ' -f1)" = "$EXPECTED_RELAY_SHA"
file "$RELAY" | grep -q "$ELFARCH"
BUNDLE="$SOURCE/build/linux/$ARCH/release/bundle"
test -n "${VIBEKITS_ADB_SOURCE_DIRECTORY:-}"
test -n "${EXPECTED_ADB_SHA256:-}"
python3 "$SOURCE/tool/package_linux_adb.py" \
 --source-dir "$VIBEKITS_ADB_SOURCE_DIRECTORY" \
 --destination "$BUNDLE/tools/adb" --arch "$DEBARCH" \
 --sha256 "$EXPECTED_ADB_SHA256"
test -n "${VIBEKITS_7ZIP_SOURCE_DIRECTORY:-}"
test -n "${EXPECTED_7ZIP_SHA256:-}"
test -n "${EXPECTED_7ZIP_VERSION:-}"
python3 "$SOURCE/tool/package_linux_7zip.py" \
 --source-dir "$VIBEKITS_7ZIP_SOURCE_DIRECTORY" \
 --destination "$BUNDLE/tools/7zip" --arch "$DEBARCH" \
 --sha256 "$EXPECTED_7ZIP_SHA256" --version "$EXPECTED_7ZIP_VERSION"
NODE="$ROOT/harness-linux-staging/node-v22.19.0-linux-$ARCH/bin/node"
test "$("$NODE" -p process.arch)" = "$ARCH"
RUNTIME="$BUNDLE/tools/harness"
test -f "$BUNDLE/lib/libapp.so"
file "$BUNDLE/vibekits" | grep -q "$ELFARCH"
mkdir -p "$RUNTIME/bin"
cp "$NODE" "$RUNTIME/bin/node"
cp -a "$ROOT/harness-linux-staging/package/node_modules" "$RUNTIME/"
for name in vibekits-mcp-server vibekits-codex-mcp vibekits-approval vibekits-parent-watchdog vibekits-fs-pressure vibekits-android-stress-mcp vibekits-session-rebind vibekits-continuation-context vibekits-readonly-control vibekits-cluster-task-runtime; do
 cp "$SOURCE/native/harness/$name.mjs" "$RUNTIME/"
done
cp -a "$SOURCE/native/harness/builtin-skills" "$RUNTIME/"
"$NODE" - "$RUNTIME/harness-runtime.json" "$ARCH" <<'NODE'
const fs=require('fs');fs.writeFileSync(process.argv[2],JSON.stringify({version:'@deepseek-ai/dsh@0.2.0-rc.2',nodeVersion:'v22.19.0',architectures:[process.argv[3]==='x64'?'x86_64':'arm64'],nodeArguments:['--expose-internals'],builtInSkills:['kemi-s1-hardware-debug','vibekits-remote-simulator','vibekits-cluster-capabilities','vibekits-cluster-agent'],cli:'node_modules/@deepseek-ai/dsh/lib/bin.js'},null,2));
NODE
cp "$RELAY" "$BUNDLE/vibekits-harness-relay"
"$BUNDLE/vibekits-harness-relay" --vibekits-harness-protocol
python3 "$SOURCE/tool/linux_readonly_relay_package.py" --bundle "$BUNDLE" --sha256 "$EXPECTED_RELAY_SHA" --stage
"$NODE" "$SOURCE/tool/test_harness_bundled_skill.mjs" "$RUNTIME"
"$NODE" "$SOURCE/tool/verify_harness_bundled_inputs.mjs" "$SOURCE" "$RUNTIME"
"$NODE" "$SOURCE/tool/test_harness_native_flock.mjs" "$RUNTIME" "$ROOT"
PACKAGE="$ROOT/deb-683-$DEBARCH"
test ! -e "$PACKAGE" || { echo 'Reconcile existing package staging first';exit 2; }
mkdir -p "$PACKAGE/DEBIAN" "$PACKAGE/opt" "$PACKAGE/usr/bin" "$PACKAGE/usr/share/applications" "$PACKAGE/usr/share/icons/hicolor/128x128/apps"
cp -a "$BUNDLE" "$PACKAGE/opt/vibekits"
ln -s /opt/vibekits/vibekits "$PACKAGE/usr/bin/vibekits"
cp "$SOURCE/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png" "$PACKAGE/usr/share/icons/hicolor/128x128/apps/vibekits.png"
mkdir -p "$PACKAGE/usr/share/doc/com.caucy.vibekits"
cp "$ROOT/relay-source/client/LICENCE" "$PACKAGE/usr/share/doc/com.caucy.vibekits/relay-LICENCE"
AUDIT="$ROOT/dependency-audit-$DEBARCH"
mkdir -p "$AUDIT/debian"
printf '%s\n' 'Source: vibekits' 'Section: devel' 'Priority: optional' 'Maintainer: KEMI Development Team' '' 'Package: com.caucy.vibekits' 'Architecture: any' 'Description: VibeKits runtime dependency audit' > "$AUDIT/debian/control"
shlib_args=(-O --ignore-missing-info "-l$BUNDLE/lib" "-l$BUNDLE/tools/adb/lib64" "-e$BUNDLE/vibekits" "-e$BUNDLE/vibekits-harness-relay" "-e$RUNTIME/bin/node" "-e$BUNDLE/tools/adb/adb" "-e$BUNDLE/tools/7zip/7zz")
for library in "$BUNDLE/lib/"*.so; do shlib_args+=("-e$library");done
for library in "$BUNDLE/tools/adb/lib64/"*.so; do
 test ! -f "$library" || shlib_args+=("-e$library")
done
(cd "$AUDIT" && dpkg-shlibdeps "${shlib_args[@]}") > "$AUDIT/shlibs.txt" 2> "$AUDIT/warnings.log"
AUTO_DEPS=$(sed -n 's/^shlibs:Depends=//p' "$AUDIT/shlibs.txt")
test -n "$AUTO_DEPS"
DEPS=$(python3 - "$AUTO_DEPS" <<'PY'
import sys
extra=[d.strip() for d in sys.argv[1].split(',') if d.strip().split()[0] not in ('libc6','libwebkit2gtk-4.0-37')]
print(', '.join(['libc6 (>= 2.31)','libwebkit2gtk-4.0-37 (>= 2.38.6)','libglib2.0-bin','xdg-utils','libsecret-tools','openssh-client','zenity','python3','python3-pyatspi','xdotool','x11-utils']+extra))
PY
)
printf '%s\n' 'Package: com.caucy.vibekits' 'Version: 1.9.0~dev.683+2683' "Architecture: $DEBARCH" 'Maintainer: KEMI Development Team' 'Section: devel' 'Priority: optional' 'X-Kemi-Version-Code: 2683' "Depends: $DEPS" 'Recommends: openssh-server' "Description: VibeKits developer toolkit for Linux $DEBARCH" ' Shared desktop Harness workspace and authorized remote simulation.' > "$PACKAGE/DEBIAN/control"
printf '%s\n' '[Desktop Entry]' 'Type=Application' 'Name=VibeKits' 'Exec=/opt/vibekits/vibekits' 'TryExec=/opt/vibekits/vibekits' 'Icon=vibekits' 'Terminal=false' 'Categories=Development;Utility;' 'StartupWMClass=com.caucy.vibekits' > "$PACKAGE/usr/share/applications/com.caucy.vibekits.desktop"
chmod -R go-w "$PACKAGE"
dpkg-deb --root-owner-group -Zgzip -z3 --build "$PACKAGE" "$ROOT/VibeKits-1.9.0-dev.683-linux-$DEBARCH.deb"
python3 "$LINUX_RELEASE_SCRIPT_DIR/verify-package-runtime-deps.py" "$ROOT/VibeKits-1.9.0-dev.683-linux-$DEBARCH.deb"
python3 "$LINUX_RELEASE_SCRIPT_DIR/verify-package-version.py" "$ROOT/VibeKits-1.9.0-dev.683-linux-$DEBARCH.deb" --version 1.9.0-dev.683 --build 2683 --arch "$DEBARCH"
sha256sum "$ROOT/VibeKits-1.9.0-dev.683-linux-$DEBARCH.deb" "$BUNDLE/vibekits" "$BUNDLE/lib/libapp.so" "$BUNDLE/vibekits-harness-relay"
stat -c '%s bytes' "$ROOT/VibeKits-1.9.0-dev.683-linux-$DEBARCH.deb"
echo "COMPILED_PACKAGE_ONLY_NOT_FULL_FUNCTIONAL_ACCEPTANCE=$DEBARCH"
