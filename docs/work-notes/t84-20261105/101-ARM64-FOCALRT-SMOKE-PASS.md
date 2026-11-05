# 101 arm64 VibeKits 773 focalrt 旁路冒烟 — PASS（t84u）

时间: 2026-11-05 08:41:09 +0800 Asia/Shanghai
合主线: gork.bot协助开发

## 结论
- **冒烟: PASS**（短活 ≥10s，RSS≈334MB）
- **现网 772: 未杀**（PID 541356 全程存活）
- **CREATE: 待本回合执行**（硬门已满足）

## 产物
| 项 | 值 |
|---|---|
| deb | `VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb` |
| sha256 | `5fe2cfd5d030398c70951164e57114ebab9d6d5c46a100b0ab46fa76c2c239dc` |
| bytes | 167302684 |
| version / code | 1.9.0~dev.773+2773 / **2773**（仅 runtime bundle，未升版本） |
| package_name 货架 | `com.caucy.vibekits.arm64` |

## 修复
- 捆绑 conda-forge `libstdc++.so.6.0.30` + `libgcc_s.so.1`（只要 GLIBC_2.17）到 `/opt/vibekits/lib/`
- wrapper 设 `LD_LIBRARY_PATH`；原 ELF 仍为 `vibekits.real`（RUNPATH `$ORIGIN/lib`）
- Depends: `libstdc++6 (>= 9)`（原 ≥11）

## 冒烟说明
- ldd 已解析到捆绑 libstdc++（非系统 3.4.28）
- 与现网并行时未改 app-id 会因 GApplication 单实例 ~1s exit 0；**仅冒烟树**临时改为 `com.caucy.vk773smk`；**上架 deb 保持** `com.caucy.vibekits`
- 日志可见 `media_kit_libs_linux registered`；Harness status IPC 被现网占用属预期

证据目录: `/workspace/t82-20261104/evidence/101-vibekits-arm64-rt`
