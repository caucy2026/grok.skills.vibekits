# 101 arm64 VibeKits 773 旁路冒烟 — FAIL（t84u）

时间: 2026-11-05 08:26:30 +0800 Asia/Shanghai
合主线: gork.bot协助开发

## 结论
- **冒烟: FAIL**（`LIBSTDCXX_TOO_OLD`）
- **CREATE: 未执行**（遵守 t84u；货架仍无 `com.caucy.vibekits.arm64`）
- **现网 772: 未杀**（PID 541356 全程存活）

## 已完成
1. heal 控制器 `vk-u20-amd64-772-run` PASS
2. connect 101 RID `7634801763` PASS
3. 上传 deb PASS（sha/bytes 对齐 `b8801bad…5c6b` / 263499874）
4. 旁路解包到 `/opt/vibekits-773-arm64-smoke/` PASS（**未** `dpkg -i`）
5. ELF aarch64 + version `1.9.0~dev.773+2773` 校验 PASS
6. 冷启短活 FAIL：缺 `GLIBCXX_3.4.29` / `CXXABI_1.3.13`

## 根因
101 = Ubuntu 20.04 Focal，`libstdc++6` 最高 `GLIBCXX_3.4.28`。773 产物需 `3.4.29`（典型 Jammy/GCC11+）。deb 未捆绑 libstdc++。

## 货架身份（预备，未 CREATE）
| 项 | 值 |
|---|---|
| package_name | `com.caucy.vibekits.arm64`（独立；勿覆盖 app90 `com.caucy.vibekits`） |
| version | 1.9.0-dev.773 / 2773 |
| FREEZE src SHA | `a580359bd06cd295daf874b114d0b41f081b6d4e` |
| arm64 deb sha256 | `b8801bad4b3e9093e13fa678122dfa73eed0fe0849d6399a4f99d26c98615c6b` |

## 下一步
1. Focal 兼容重建或捆绑新 libstdc++
2. 101 旁路冒烟 PASS
3. 才允许 CREATE

证据目录: `/workspace/t82-20261104/evidence/101-vibekits-arm64/`
