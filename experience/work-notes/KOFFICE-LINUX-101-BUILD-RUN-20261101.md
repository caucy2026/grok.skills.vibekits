# KOffice Linux: local build -> sim push 101

Time: 2026-11-02 01:32:11 CST (Asia/Shanghai)
Control: newlink / machineId 92c2f165-4f49-452d-b60c-ae24cb8eb990
Target: 101=mp730-156 / routingId=7634801763
Path: lima ko-u20 Ubuntu 20.04 aarch64 (glibc 2.31, g++-12) -> lean pack (+bundled libstdc++/libgcc_s) -> vibekits sim push + cold attempts + 101 hw opts.
No SendToAgent; vibekits left running (PID 2901167 on 101).

## Result

**failed** (verify != compile; no full-feature/release claim)

Cold-stable headless/--accept/convert did **not** hold on 101.
ABI smoke **did** pass: soffice.bin --version prints Collabora Office 26.04.3.0 with exit 0 — **no missing GLIBC_/GLIBCXX_ loader crash** (unlike prior U26 glibc-2.43 build).

| item | status |
|---|---|
| build host | lima ko-u20 Ubuntu 20.04.6 / glibc 2.31 / aarch64 |
| configure | DISABLE_GUI=TRUE ENABLE_HEADLESS=TRUE MERGELIBS=TRUE USE_HEADLESS_CODE=TRUE; LDFLAGS -static-libstdc++ -static-libgcc; --disable-gui / CPLinux-LOKit style |
| soffice.bin | real ELF aarch64 (72280B launcher); work in libmergedlo.so (~627MB unstripped) |
| probe_elf GLIBC<=2.31 | **PASS** — guest readelf NEEDED scan 111 ELFs, configuredLimitsSatisfied=True, worst needed GLIBC **2.30**; report work-notes/probe-u20-final.json |
| GLIBCXX note | stock 101 libstdc++ max 3.4.28; build/external libs need up to 3.4.30 → lean bundles program/libstdc++.so.6 (to 3.4.35) + libgcc_s.so.1; cold uses LD_LIBRARY_PATH=program |
| lean tar | out/koffice-instdir-lean-u20-ext-20261102012654.tar.zst SHA256 72808f0146a2958d2afc6aca0bf9c9b1b5033af4b00116304eac28eec2ef0f98 (~746MB zst; ~2.7G unpacked, includes share/extensions) |
| 101 deploy | /opt/koffice-lokit-r5b-20261101/instdir-lean |
| version smoke | **PASS** Collabora Office 26.04.3.0 ver_ec=0; soffice.bin SHA256 abdc07391ec00ea15f8f20bad81292a4d08abab5fe4b1e39b64b49261b0bfe8a |
| headless --accept / convert / --terminate_after_inits | **FAIL** on 101 (UCB isFolder/deployment → Signal 6 / ICU __gxx_personality_v0); **same fail on build guest** (tai_exit=1, conv_exit=81) → not 101-only ABI |
| opts loaded | RENDER_WORKERS=2 CACHE_BUDGET_MB=256 PREFER_EGL QT_OPENGL=egl (+ SAL_USE_VCLPLUGIN=svp for attempts) |

## Cold / verify notes

- Prior U26 package: instant GLIBC_2.32+ crash — fixed by U20/glibc2.31 rebuild.
- Mergelibs stubs (text: invalid - merged lib, 21B) are expected; not the GLIBC issue.
- Headless path aborts during extension/UCB bootstrap; --version short-circuits before that and is the ABI proof for this --disable-gui LOKit-oriented build.
- Next (out of this verify slice): LOKit API smoke, or rebuild without --disable-gui if full soffice convert/server is required.

## Artifacts

- lean: /Volumes/ORICO/kemi-build-cache/koffice-linux-ctrl-20261101/out/koffice-instdir-lean-u20-ext-20261102012654.tar.zst
- probe: /Volumes/ORICO/kemi-build-cache/koffice-linux-ctrl-20261101/work-notes/probe-u20-final.json
- cold json: work-notes/coldstart-u20-20261102012654.json (and earlier stamps)
- hw env: hw/101-koffice-opt-profile.env

## Not claimed

No full-feature / release / GUI / convert acceptance.
