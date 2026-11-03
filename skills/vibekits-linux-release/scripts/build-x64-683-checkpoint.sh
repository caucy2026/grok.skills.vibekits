#!/usr/bin/env bash
set -euo pipefail
ROOT=/home/claw/vibekits-linux-test
SOURCE="$ROOT/source-683"
trap 'printf "%s\n" "$?" > "$ROOT/build-683.exit"' EXIT
test ! -e "$SOURCE" || { echo 'Existing final source must be reconciled';exit 2; }
if pgrep -x cargo >/dev/null || pgrep -x rustc >/dev/null; then echo 'BLOCK_RESOURCE: native compiler active';exit 75;fi
renice -n 10 -p "$$" >/dev/null
ionice -c 3 -p "$$"
mkdir "$SOURCE"
tar -xzf "$ROOT/arm64-source-682.tar.gz" -C "$SOURCE"
tar -xzf "$ROOT/arm64-required-models.tar.gz" -C "$SOURCE"
tar -xzf /tmp/vibekits-simulator-3201833792/linux-final-ui-683-inputs.tar.gz -C "$SOURCE"
cd "$SOURCE"
patch --dry-run --fuzz=0 -p1 < /tmp/vibekits-simulator-3201833792/vibekits-linux-final-ui-v2.patch
patch --fuzz=0 -p1 < /tmp/vibekits-simulator-3201833792/vibekits-linux-final-ui-v2.patch
cp /tmp/vibekits-simulator-3201833792/vibekits-linux-app-version-683.dart lib/app/app_version.dart
export PATH="$ROOT/flutter/bin:$PATH" PUB_HOSTED_URL=https://pub.flutter-io.cn FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get --offline --enforce-lockfile > "$ROOT/pub-683.log" 2>&1
python3 tool/verify_flutter_frozen_inputs.py "$PWD" --output "$ROOT/frozen-inputs-683.json" > "$ROOT/frozen-inputs-683.log"
flutter test --no-pub --concurrency=1 --reporter expanded test/harness_home_server_status_test.dart test/platform_storage_layout_test.dart > "$ROOT/tests-683.log" 2>&1
flutter test --no-pub --concurrency=1 --reporter expanded test/harness_capability_catalog_test.dart --plain-name '每个独立工作区都声明真实连续使用合同' >> "$ROOT/tests-683.log" 2>&1
flutter build linux --release --no-pub --build-name=1.9.0-dev.683 --build-number=2683 > "$ROOT/build-683.log" 2>&1
sha256sum build/linux/x64/release/bundle/vibekits build/linux/x64/release/bundle/lib/libapp.so > "$ROOT/gui-683.sha256"
