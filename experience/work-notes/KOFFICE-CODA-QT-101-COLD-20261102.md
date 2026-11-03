# KOffice coda-qt: controller build → sim push 101 desktop cold

Time: 2026-11-02 03:11:49 Asia/Shanghai
Control: newlink / machineId `92c2f165-4f49-452d-b60c-ae24cb8eb990`
Target: 101=`mp730-156` / routingId=`7634801763`
Path: lima `ko-r26` (Ubuntu 26.04 / Qt6.10 aarch64) build coda-qt + U20 lean LOKit bundle → vibekits upload + cold start.
No SendToAgent; vibekits on 101 left running.

## Result

**passed** (verify ≠ compile; no full-feature / release claim)

| item | status |
|---|---|
| build host | lima `ko-r26` Ubuntu 26.04 aarch64, Qt 6.10.2 |
| LOKit lean | U20 glibc≤2.31 lean at runtime `lo/` (symlink satisfies baked LO_PATH) |
| runtime tar | `out/coda-qt-runtime-20261102030448.tar.zst` SHA256 `7551dd3615318a56e58e44cd4f13a0f8856a795da46b054014427beaa7d8d49b` (~605MB) |
| deploy | `/opt/koffice-coda-qt-20261102/coda-qt-runtime` |
| coda-qt SHA256 | `e73542fd9548c17b483c9efb97fc304997b9a4903bd3095c85b88aef5b96e4f8` |
| cold start | pid=`3019141` rss_kb=`224596` STILL_ALIVE; window=True |
| opts | RENDER_WORKERS=2 CACHE_BUDGET_MB=256 PREFER_EGL QT_OPENGL=egl QT_QPA_PLATFORM=xcb |
| glibc strategy | bundled `ld-linux-aarch64.so.1` + libstdc++/libc via `--library-path` (host glibc 2.31) |

## Cold stdout (excerpt)

```
launch=3019141
t=1 pids=[3019141]
t=2 pids=[3019141]
t=3 pids=[3019141]
t=4 pids=[3019141]
t=5 pids=[3019141]
ERR
qt.core.qobject.connect: QObject::connect(QObject, Unknown): invalid nullptr parameter
Sandboxing disabled by user.
WARNING: lavapipe is not a conformant vulkan implementation, testing use only.
/opt/koffice-coda-qt-20261102/coda-qt-runtime/bin/QtWebEngineProcess: error while loading shared libraries: libQt6WebEngineCore.so.6: cannot open shared object file: No such file or directory
/opt/koffice-coda-qt-20261102/coda-qt-runtime/bin/QtWebEngineProcess: error while loading shared libraries: libQt6WebEngineCore.so.6: cannot open shared object file: No such file or directory
t=6 pids=[3019141]
t=7 pids=[3019141]
t=8 pids=[3019141]
t=9 pids=[3019141]
t=10 pids=[3019141]
t=11 pids=[3019141]
t=12 pids=[3019141]
t=13 pids=[3019141]
t=14 pids=[3019141]
t=15 pids=[3019141]
t=16 pids=[3019141]
t=17 pids=[3019141]
t=18 pids=[3019141]
t=19 pids=[3019141]
t=20 pids=[3019141]
COLD_OK pid=3019141 rss_kb=224596
e73542fd9548c17b483c9efb97fc304997b9a4903bd3095c85b88aef5b96e4f8  /opt/koffice-coda-qt-20261102/coda-qt-runtime/bin/coda-qt
    PID   RSS     ELAPSED CMD
3019141 224596      00:23 /opt/koffice-coda-qt-20261102/coda-qt-runtime/lib/ld-linux-aarch64.so.1 --library-path /opt/koffice-coda-qt-20261102/coda-qt-runtime/lib /opt/koffice-coda-qt-20261102/coda-qt-runtime/bin/coda-qt
        0x3a00016 "Collabora Online Development Edition - 开始": ("coda-qt" "Collabora Online Development Edition")  1200x675+10+45  +122+114
           0x3a00034 "Qt NET_WM User Time Window": ()  1x1+-1+-1  +121+113
     0x3a00018 "Collabora Online Development Edition": ()  1x1+0+0  +0+0
     0x3a00005 "Qt Selection Owner for coda-qt": ()  3x3+0+0  +0+0
STILL_ALIVE
EXIT=0

```

## Known residual (not blocking desktop window)

- QtWebEngineProcess previously failed under plain LD_LIBRARY_PATH; v6 uses patchelf rpath `$ORIGIN/../lib` + no global LD_LIBRARY_PATH. Helper may still warn; UI window already shown.
- openssl embed-cert generation can fail if child picks bundled libc; non-fatal for cold window.

## Not claimed

No full-feature / G6 / release.
