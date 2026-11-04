# VibeKits Linux 安装包（当前指针）

**gork.bot协助开发** · 机器可读指针见 [`../packages/CURRENT.json`](../packages/CURRENT.json)。

大包**不进 git**，只在 GitHub Releases。权威 tag：

**[vibekits-linux-1.9.0-dev.773-t58](https://github.com/caucy2026/grok.skills.vibekits/releases/tag/vibekits-linux-1.9.0-dev.773-t58)**

| 构件 | 用途 | SHA-256（前缀） | 字节 |
|---|---|---|---|
| `VibeKits-Linux-1.9.0-dev.773.tar.gz` | **统一交付**（内含双架构 deb + `install.sh`） | `0b6c301f…13259f67` | 548181962 |
| `VibeKits-1.9.0-dev.773-linux-amd64.deb` | x86_64 / 设备 88 等 | `a60da697…91bd6f2d` | 288285284 |
| `VibeKits-1.9.0-dev.773-linux-arm64.deb` | aarch64 / 设备 **101** | `b8801bad…8615c6b` | 263499874 |
| `install.sh` / `SHA256SUMS` / `FREEZE.txt` | 安装与冻结元数据 | 见 Release assets | — |

版本：`1.9.0-dev.773` · version_code **2773** · 源码 SHA `a580359bd06cd295daf874b114d0b41f081b6d4e`。

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
- 策略：挂**统一 tar**；**不要**另建 arm64 货架；**不要**只用 arm64 deb 覆盖 app90
- 详细合同：通用技能 [kemi-market-publish](https://github.com/caucy2026/skills/tree/main/kemi-market-publish) + 本仓 `skills/bot-kemi-box` §10

CDN / 现网 URL 以当次 `apps/update` 回执为准；勿把 Bearer 写进本仓。

## 相关技能

- 本仓 `skills/vibekits-linux-release` — 编译/验收/打包入口
- 通用 `caucy2026/skills` → `linux-desktop-build-acceptance`、`rust-linux-cross-build`（raw 引用）
