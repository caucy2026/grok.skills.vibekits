# VibeKits Linux 安装包（当前指针）

**gork.bot协助开发** · 机器可读指针见 [`../packages/CURRENT.json`](../packages/CURRENT.json)。

大包**不进 git**，只在 GitHub Releases。权威 tag：

**[vibekits-linux-1.9.0-dev.773-t58](https://github.com/caucy2026/grok.skills.vibekits/releases/tag/vibekits-linux-1.9.0-dev.773-t58)**

| 构件 | 用途 | SHA-256（前缀） | 字节 |
|---|---|---|---|
| `VibeKits-Linux-1.9.0-dev.773.tar.gz` | **统一交付**（内含双架构 deb + `install.sh`） | `0b6c301f…13259f67` | 548181962 |
| `VibeKits-1.9.0-dev.773-linux-amd64.deb` | x86_64 / 设备 88 等 | `a60da697…91bd6f2d` | 288285284 |
| `VibeKits-1.9.0-dev.773-linux-arm64.deb` | aarch64 原未捆绑 deb（101 FAIL，见下） | `b8801bad…8615c6b` | 263499874 |
| `install.sh` / `SHA256SUMS` / `FREEZE.txt` | 安装与冻结元数据 | 见 Release assets | — |

版本：`1.9.0-dev.773` · version_code **2773** · FREEZE 源码 SHA `a580359bd06cd295daf874b114d0b41f081b6d4e`。

`packages/CURRENT.json` 与 `packages/FREEZE.txt` 仍指向上述 Release 构件。其中 `FREEZE.txt` 的 `MARKET=do-not-create-arm64-shelf` 是冻结当时的备注；**arm64 独立货架以本节以下为准**，不要据此改 app90。

## 安装

```bash
TAG=vibekits-linux-1.9.0-dev.773-t58
B=https://github.com/caucy2026/grok.skills.vibekits/releases/download/$TAG
curl -fL -O "$B/VibeKits-Linux-1.9.0-dev.773.tar.gz"
curl -fL -O "$B/VibeKits-Linux-1.9.0-dev.773.tar.gz.sha256"
sha256sum -c VibeKits-Linux-1.9.0-dev.773.tar.gz.sha256
tar -xzf VibeKits-Linux-1.9.0-dev.773.tar.gz
# 解压后目录内：
#   vibekits_amd64.deb / vibekits_arm64.deb / install.sh / SHA256SUMS
sh install.sh    # 按 uname/dpkg 选架构并 apt 安装
```

装后常见路径：`/opt/vibekits/vibekits` · 包名 `com.caucy.vibekits`。

## KEMI 商场（app90）

- 标题：**VibeKits Linux**（已去掉单独 x86_64 后缀口径）
- **app90 仍为统一 tar** / 包名 **`com.caucy.vibekits`**
- **不要**用 arm64 deb（含下面的 focalrt）覆盖 app90
- 详细合同：通用技能 [kemi-market-publish](https://github.com/caucy2026/skills/tree/main/kemi-market-publish) + 本仓 `skills/bot-kemi-box` §10

CDN / 现网 URL 以当次 `apps/update` 回执为准；勿把 Bearer 写进本仓。

## KEMI 商场 — arm64 独立货架（用户已批；硬门）

**package_name（独立）**: `com.caucy.vibekits.arm64`  
**勿覆盖** app90 `com.caucy.vibekits`（统一 tar）。

**硬门：101 冒烟 PASS 才商场发布。** 验证 ≠ 编译。本回合硬门已满足，**CREATE 仍待执行**（货架上还没有这条 package_name）。

| 项 | 值 |
|---|---|
| 计划产物 | `VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb` |
| SHA-256 | `5fe2cfd5d030398c70951164e57114ebab9d6d5c46a100b0ab46fa76c2c239dc`（`5fe2cfd5…39dc`） |
| 字节 | 167302684 |
| version / code | 1.9.0-dev.773 / 2773（仅 runtime bundle，未升版本） |
| FREEZE 源码 SHA | `a580359bd06cd295daf874b114d0b41f081b6d4e` |
| 真机冒烟 | **101 旁路 PASS**（2026-11-05 08:41 +0800）：短活 ≥10s，RSS≈334MB；现网 772 PID 541356 未杀 |
| CREATE | **待执行** |

原未捆绑 deb（Release 上的 `VibeKits-1.9.0-dev.773-linux-arm64.deb`）在 101 **FAIL**：SHA `b8801bad4b3e9093e13fa678122dfa73eed0fe0849d6399a4f99d26c98615c6b` · 263499874 字节 · 需 `GLIBCXX_3.4.29` / `CXXABI_1.3.13`，Focal `libstdc++6` 最高 `GLIBCXX_3.4.28`。focalrt 改为捆绑 conda-forge `libstdc++.so.6.0.30` + `libgcc_s.so.1`（只要 GLIBC_2.17）到 `/opt/vibekits/lib/`，wrapper 设 `LD_LIBRARY_PATH`，Depends `libstdc++6 (>= 9)`。

上架 deb 的应用 id 保持 `com.caucy.vibekits`。与现网并行时 GApplication 单实例会让未改 id 的第二实例约 1s 退出；**仅冒烟树**临时改为 `com.caucy.vk773smk`，该补丁不打进上架包。

证据：本仓 [`docs/work-notes/t84-20261105/`](work-notes/t84-20261105/) · 箱 `/workspace/t82-20261104/evidence/101-vibekits-arm64/`（FAIL）与 `…/101-vibekits-arm64-rt`（PASS）。deb 本体不进 git。

## 相关技能

- 本仓 `skills/vibekits-linux-release` — 编译/验收/打包入口
- 通用 `caucy2026/skills` → `linux-desktop-build-acceptance`、`rust-linux-cross-build`（raw 引用）
