# grok.skills.vibekits

> **零基础请先打开 [`START-HERE.md`](START-HERE.md)**（下载 → 云机部署 → 设置 → 仿针 101）。  
> 可跑包只在本仓 [Releases](https://github.com/caucy2026/grok.skills.vibekits/releases)。  
> 仿真 invoke 等通用技能**不重复拷贝**，用 [caucy2026/skills](https://github.com/caucy2026/skills) raw。  
> 合主线：gork.bot协助开发。

同事所需材料都在 GitHub **`caucy2026`**：本仓放安装包指针、Gork / Grok Bot 搭建、远程仿真索引、Common 默认发布、同类 101 上 KD；仿真技能正文在 [caucy2026/skills](https://github.com/caucy2026/skills)。

合主线 / 提交 / 文档注明：**gork.bot协助开发**。验证 ≠ 编译。禁止杀 101 上的 vibekits。

- **通用技能权威库**：[caucy2026/skills](https://github.com/caucy2026/skills)（用 raw 引用，勿整仓重复拷贝）
- **本仓**：VibeKits Linux 双架构包指针、bot 云机仿针、`bot-kemi-box` / `gork` 等专用技能与证据索引

## 同事入口（先看这四块）

| 要找什么 | 先打开 | 说明 |
|---|---|---|
| **① vibekits 安装包** | [`docs/PACKAGES.md`](docs/PACKAGES.md) · [`packages/CURRENT.json`](packages/CURRENT.json) · [Releases](https://github.com/caucy2026/grok.skills.vibekits/releases) | Linux **1.9.0-dev.773** 统一 `tar.gz` + amd64/arm64 `.deb`；商场 app90 挂统一包 |
| **② gork / Grok Bot 配置** | [`START-HERE.md`](START-HERE.md) · [`docs/GORK-BOT-HANDOFF.md`](docs/GORK-BOT-HANDOFF.md) · [`skills/gork/SKILL.md`](skills/gork/SKILL.md) | 从零先走导读，再搭 Bot：本仓 skills + 通用三技能 + Vault；执行宿主=**bot 云机** |
| **③ 远程仿真全套** | [`START-HERE.md`](START-HERE.md) · [`docs/REMOTE-SIM-INDEX.md`](docs/REMOTE-SIM-INDEX.md) · [`skills/bot-kemi-box/SKILL.md`](skills/bot-kemi-box/SKILL.md) §0 · raw `invoke.rb` | 零基础全链路在导读。ABCD / consent / 101 RID / tool-bridge。同类设备上 KD → [`docs/KEMI-MARKET-101.md`](docs/KEMI-MARKET-101.md) |
| **④ Common 默认发布通道** | [`docs/COMMON-RELEASE.md`](docs/COMMON-RELEASE.md) | Newlink 屏保固定资源（≠ KD 商场）；用户名 `common`，密码只 Vault |

技能总表：[`docs/SKILLS-INDEX.md`](docs/SKILLS-INDEX.md)。继承背景：[`INHERITANCE.md`](INHERITANCE.md)（其中控制机本机路径为**历史**记录，运行时一律改用本表与 GitHub raw）。

## 硬规则

1. **不再依赖控制机 Mac** 做日常发布/仿针；执行宿主 = Grok Bot 云机 →（tool-bridge）→ 101。
2. 技能互相引用脚本：**只用 GitHub raw**，禁止写死 `/Users/…`、`/Volumes/ORICO/…`、`~/.codex/skills/…`。
3. **禁止**把密钥 / JWT / Common 密码推进 git。默认账号名可文档化，密码只 Vault（当次可用环境变量 `NEWLINK_COMMON_PASSWORD`，用后清除）。
4. 不杀 101 vibekits；合主线注明 gork.bot协助开发。

## Raw 引用约定

```text
通用：https://raw.githubusercontent.com/caucy2026/skills/main/<skill>/…
本仓：https://raw.githubusercontent.com/caucy2026/grok.skills.vibekits/main/skills/<skill>/…
invoke：https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
```

## 布局

| 路径 | 内容 |
|---|---|
| `packages/` | 当前版本指针（不把数百 MB 包塞进 git；包在 Releases） |
| `skills/` | 可安装技能（整目录复制到本机 skills 根） |
| `docs/` | 入口文档、工具片段、work-notes |
| `experience/` | 会话摘要 / 历史 work-notes |
| `goals/` | 继承目标 |
| `INHERITANCE.md` | 继承说明（历史路径） |

## 安装技能（示例）

```bash
git clone https://github.com/caucy2026/grok.skills.vibekits.git
# SKILLS_ROOT = 你们代理的 skills 根，不要写死某台控制机的目录
cp -a grok.skills.vibekits/skills/vibekits-box-onboard "$SKILLS_ROOT/"
cp -a grok.skills.vibekits/skills/bot-kemi-box "$SKILLS_ROOT/"
cp -a grok.skills.vibekits/skills/gork "$SKILLS_ROOT/"
# 通用技能从 caucy2026/skills 装，勿整仓拷进本仓：
#   vibekits-remote-simulator · kemi-market-publish · newlink-common-release
curl -fsSL https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb -o /tmp/vibekits-invoke.rb
```

## 装包（Linux）

见 [`docs/PACKAGES.md`](docs/PACKAGES.md)。最短：

```bash
TAG=vibekits-linux-1.9.0-dev.773-t58
BASE=https://github.com/caucy2026/grok.skills.vibekits/releases/download/$TAG
curl -fL -O "$BASE/VibeKits-Linux-1.9.0-dev.773.tar.gz"
curl -fL -O "$BASE/VibeKits-Linux-1.9.0-dev.773.tar.gz.sha256"
sha256sum -c VibeKits-Linux-1.9.0-dev.773.tar.gz.sha256
tar -xzf VibeKits-Linux-1.9.0-dev.773.tar.gz
cd VibeKits-Linux-1.9.0-dev.773 && sh install.sh
```

更新：2026-11-05（t88 · gork.bot协助开发 · 零基础导读 START-HERE）
