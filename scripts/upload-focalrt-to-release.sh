#!/usr/bin/env bash
# Upload focalrt deb onto existing tag (run where gh is authenticated as caucy2026 writer).
set -euo pipefail
TAG=vibekits-linux-1.9.0-dev.773-t58
REPO=caucy2026/grok.skills.vibekits
CDN=https://cdn.newlink-sz.com/kemiAppStore/linuxpkg/2026/11/1793839701798_ac917449_VibeKits-1_9_0-dev_773-linux-arm64-focal.deb
EXPECT_SHA=5fe2cfd5d030398c70951164e57114ebab9d6d5c46a100b0ab46fa76c2c239dc
WORKDIR=$(mktemp -d)
trap 'rm -rf "$WORKDIR"' EXIT
cd "$WORKDIR"
curl -fL -o VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb "$CDN"
echo "$EXPECT_SHA  VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb" | sha256sum -c -
printf '%s  %s\n' "$EXPECT_SHA" "VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb" > VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb.sha256
# skip if already present
if gh release view "$TAG" -R "$REPO" --json assets -q '.assets[].name' | grep -qx 'VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb'; then
  echo "asset already on release"
else
  gh release upload "$TAG" \
    VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb \
    VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb.sha256 \
    -R "$REPO" --clobber
fi
gh release view "$TAG" -R "$REPO" --json assets -q '.assets[].name'
