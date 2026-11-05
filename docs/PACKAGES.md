# VibeKits Linux 安装包（当前指针）

**gork.bot协助开发** · 零基础从 [`../START-HERE.md`](../START-HERE.md) 开始。  
机器可读：[`../packages/CURRENT.json`](../packages/CURRENT.json)。

大包**不进 git**，只在本仓 GitHub Releases。权威 tag：

**[vibekits-linux-1.9.0-dev.773-t58](https://github.com/caucy2026/grok.skills.vibekits/releases/tag/vibekits-linux-1.9.0-dev.773-t58)**

| 构件 | 用途 | SHA-256 | 字节 |
|---|---|---|---|
| `VibeKits-Linux-1.9.0-dev.773.tar.gz` | 统一交付（双架构 + install.sh）· **app90** | `0b6c301f…259f67` | 548181962 |
| `VibeKits-1.9.0-dev.773-linux-amd64.deb` | 云机控制器 / x86_64 | `a60da697…bd6f2d` | 288285284 |
| `VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb` | **101 可跑**（捆绑 libstdc++）· **app106** | `5fe2cfd5…39dc` | 167302684 |
| `VibeKits-1.9.0-dev.773-linux-arm64.deb` | 未捆绑；Focal **FAIL**（留作对照） | `b8801bad…15c6b` | 263499874 |

版本：`1.9.0-dev.773` · code **2773** · FREEZE `a580359bd06cd295daf874b114d0b41f081b6d4e`。

## 商场

| 货架 | package_name | app_id | 构件 |
|---|---|---|---|
| VibeKits Linux | `com.caucy.vibekits` | **90** | 统一 tar |
| VibeKits Linux arm64 | `com.caucy.vibekits.arm64` | **106** | focalrt deb |

**禁止**用 arm64 覆盖 app90。硬门：101 冒烟 PASS 才发（已满足后 CREATE 106）。

## 下载

见导读 §3。资料全部在 `github.com/caucy2026`（本仓 Releases + skills raw）。
