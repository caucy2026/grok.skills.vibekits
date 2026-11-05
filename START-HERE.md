# 导读：从零完成「下载 Vibekits → 云机部署 → 设置 → 仿针 101」

**只认 GitHub `caucy2026`。** 不要依赖同事 Mac、ORICO、聊天记录或本机私有路径。  
合主线注明：**gork.bot协助开发**。验证 ≠ 编译。**禁止杀** 目标机（默认 101）上的 vibekits。

本文件是**唯一入口**。按章节顺序做即可；细节链到本仓其它文档或 `caucy2026/skills` 的 raw（不在本仓重复拷仿真技能正文）。

---

## 0. 你需要什么

| 项 | 说明 |
|---|---|
| 账号 | 能读 [caucy2026/grok.skills.vibekits](https://github.com/caucy2026/grok.skills.vibekits) 与 [caucy2026/skills](https://github.com/caucy2026/skills) |
| 执行宿主 | **Grok Bot 云电脑（box）**（x86_64，可跑 Docker） |
| 真机目标 | 默认 Linux **101** `mp730-156` · routingId **`7634801763`**（以当次 harness status 为准） |
| 凭证 | Common / KD 密码与 Bearer **只放 Vault**，永不进 git |

---

## 1. 克隆本仓（入口仓）

```bash
git clone https://github.com/caucy2026/grok.skills.vibekits.git
cd grok.skills.vibekits
# 先读本文件，再装技能
```

给空 Grok Bot 的最短口令：「按本仓 [`START-HERE.md`](START-HERE.md) 从第 2 步做到第 6 步。」

---

## 2. 装技能（本仓 + 通用仓 raw，不重复拷仿真全文）

### 2.1 本仓必装（拷到你们代理的 skills 根）

```bash
# SKILLS_ROOT = 该 bot / Codex 的 skills 根目录（不要写死某台机器路径）
cp -a skills/vibekits-box-onboard "$SKILLS_ROOT/"
cp -a skills/bot-kemi-box "$SKILLS_ROOT/"
cp -a skills/gork "$SKILLS_ROOT/"
```

| 技能 | 干什么 |
|---|---|
| [`skills/vibekits-box-onboard`](skills/vibekits-box-onboard/SKILL.md) | **本导读的可执行版**：下载包 → 云机部署 → 设置 → 仿针 |
| [`skills/bot-kemi-box`](skills/bot-kemi-box/SKILL.md) | 编译对齐 / ABCD·consent·tool-bridge 细则 / 商场 §10 |
| [`skills/gork`](skills/gork/SKILL.md) | 经仿真投异账号 Grok（可选） |

### 2.2 通用技能（权威在 caucy2026/skills，**不要整份拷进本仓**）

执行时用 **raw** 拉脚本即可：

```bash
# 仿真 invoke（权威）
INV_URL=https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
curl -fsSL "$INV_URL" -o /tmp/vibekits-invoke.rb

# 通道恢复长文（权威）
# https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/references/channel-recovery.md
```

| 通用技能 | 用途 | 入口 |
|---|---|---|
| `vibekits-remote-simulator` | connect / upload / ssh_exec / disconnect | [tree](https://github.com/caucy2026/skills/tree/main/vibekits-remote-simulator) |
| `kemi-market-publish` | KD 商场合同（上架时才需要） | [tree](https://github.com/caucy2026/skills/tree/main/kemi-market-publish) |
| `newlink-common-release` | Common 屏保通道（≠ 仿真） | [tree](https://github.com/caucy2026/skills/tree/main/newlink-common-release) |

本仓若仍有 `skills/vibekits-remote-simulator/` 副本：仅作离线备份；**有分歧以 caucy2026/skills 为准**，导读与 onboard 技能一律 raw 指过去。

---

## 3. 下载可跑的 Vibekits（只走本仓 Releases）

机器可读指针：[`packages/CURRENT.json`](packages/CURRENT.json)  
人工说明：[`docs/PACKAGES.md`](docs/PACKAGES.md)

```bash
# 读指针（也可用浏览器打开 CURRENT.json）
curl -fsSL https://raw.githubusercontent.com/caucy2026/grok.skills.vibekits/main/packages/CURRENT.json -o /tmp/vk-current.json

TAG=$(python3 -c 'import json;print(json.load(open("/tmp/vk-current.json"))["release_tag"])')
B="https://github.com/caucy2026/grok.skills.vibekits/releases/download/$TAG"

# 云机控制器（x86_64）：用 amd64 deb 或统一 tar
curl -fL -O "$B/VibeKits-1.9.0-dev.773-linux-amd64.deb"
curl -fL -O "$B/VibeKits-1.9.0-dev.773-linux-amd64.deb.sha256"
sha256sum -c VibeKits-1.9.0-dev.773-linux-amd64.deb.sha256

# 真机 101（aarch64 Focal）：必须用 focalrt（捆绑 libstdc++），不要用未捆绑 arm64
curl -fL -O "$B/VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb"
curl -fL -O "$B/VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb.sha256"
sha256sum -c VibeKits-1.9.0-dev.773-linux-arm64-focalrt.deb.sha256
```

| 谁用 | 构件 | 备注 |
|---|---|---|
| bot 云机控制器 | `…-linux-amd64.deb` 或统一 `tar.gz` | Docker Ubuntu 20.04 amd64 冒烟 runtime |
| 101 / 同类 Focal aarch64 | `…-linux-arm64-focalrt.deb` | KD 独立货架 `com.caucy.vibekits.arm64` app106 |
| 商场 app90 | 统一 `VibeKits-Linux-….tar.gz` | **禁止**用 arm64 覆盖 app90 |

大包**不进 git**，只在 [Releases](https://github.com/caucy2026/grok.skills.vibekits/releases)。

---

## 4. 云电脑部署（控制器）

细则：[`docs/BOX-DEPLOY.md`](docs/BOX-DEPLOY.md) · 技能 [`vibekits-box-onboard`](skills/vibekits-box-onboard/SKILL.md) · [`bot-kemi-box` §6](skills/bot-kemi-box/SKILL.md)

最短意图：

1. box 上起 **Ubuntu 20.04 amd64** 容器（挂显示 `:99` / Xvfb）。
2. 把 amd64 Vibekits 装进容器（或解压到固定 runtime 目录）。
3. **宿主机 + 容器** 都钉 ABCD hosts（见下节）；禁止解析成 `198.18.0.1`。
4. 启动 vibekits + harness-relay；打开 **simulator access**；记下控制器 `routingId`（每次新 Harness 可能变，勿写死进脚本）。
5. 确认 `tool-bridge.json` 出现（token 勿进 git/聊天）。

冒烟 runtime ≠ 正式商场 deb；合主线「gork.bot协助开发」。

---

## 5. 云机必须做的设置

摘自 `bot-kemi-box` §6.2（ABCD）：

```text
119.96.24.110 kemi-chat1.newlinksz.com kemi-chat.newlinksz.com
171.43.138.47 kemi.newlinksz.com
159.27.117.207 kemi-sh1.newlinksz.com
172.188.240.186 kemi-sg1.newlinksz.com
```

勾选：

- [ ] `getent hosts kemi-chat1.newlinksz.com` → 真 IP（不是 198.18）
- [ ] 到 A:`21116` 等有 **ESTAB**；有 `request_pk`（防虚报 registered，§6.8）
- [ ] `simulatorAccessEnabled=true`
- [ ] 与目标对齐 `protocol_v4`（已验证路径）
- [ ] 容器内有 `openssh-client`

半残 registered：只重启**云机** vibekits+relay，**不要**杀 101 vibekits。

---

## 6. 仿真一台「类似 101」的设备

默认 RID=`7634801763`。其它设备：用户给的 routingId，先摸底（`bot-kemi-box` §2）。

### 6.1 有控制机 invoke（同事 Mac 隧道仍可用时）

```bash
INV=/tmp/vibekits-invoke.rb
RID=7634801763
ruby "$INV" vibekits.simulator.connect "{\"routingId\":\"$RID\"}"
# 验收：ok · connected:true · sshReady:true · hostname 对
ruby "$INV" vibekits.simulator.ssh_exec "{\"routingId\":\"$RID\",\"command\":\"hostname; uname -m\"}"
ruby "$INV" vibekits.simulator.disconnect "{\"routingId\":\"$RID\"}"
```

### 6.2 纯云机 tool-bridge（主路径）

按 `bot-kemi-box` **§0 / §6.11**：`POST …/invoke`，字段名必须是 **`toolId`**（不是 `name`）。

```text
预检 §6.8 → connect(RID) →（目标 UI 同意）→ ssh_exec / upload_file → disconnect
```

首次对该目标：`consent_pending` → **在目标设备 UI 点同意**，禁止旁路。  
成功时间线：proof 后约 0.4–0.6s 应有 peer info；否则按 §6.9（静默 peer / identity_mismatch 等）。

投递文件：`upload_file.localPath` = **控制器可见**绝对路径（云机则先 `docker cp` 进容器）。

索引：[`docs/REMOTE-SIM-INDEX.md`](docs/REMOTE-SIM-INDEX.md)

---

## 7. 验收清单（全链路 DONE）

- [ ] 只从本仓 Releases 下到包，SHA 核对通过
- [ ] 云机容器 vibekits registered 且 ESTAB 真 IP（非虚报）
- [ ] 对 101（或指定 RID）`connect` + 真实 `ssh_exec`/`upload_file` 成功
- [ ] 未杀目标 vibekits；临时 token 已删
- [ ] 回执写明：控制器 routingId、目标 RID、transport、hostname、是否经 consent

---

## 8. 相关入口（仍全部在 caucy2026）

| 主题 | 链接 |
|---|---|
| 包指针 | [`packages/CURRENT.json`](packages/CURRENT.json) · [`docs/PACKAGES.md`](docs/PACKAGES.md) |
| 云机部署详解 | [`docs/BOX-DEPLOY.md`](docs/BOX-DEPLOY.md) |
| Bot 交接 / Vault | [`docs/GORK-BOT-HANDOFF.md`](docs/GORK-BOT-HANDOFF.md) |
| KD 上架（可选） | [`docs/KEMI-MARKET-101.md`](docs/KEMI-MARKET-101.md) |
| Common 屏保（可选） | [`docs/COMMON-RELEASE.md`](docs/COMMON-RELEASE.md) |
| 应用类源码备份 | [caucy2026/linux-730](https://github.com/caucy2026/linux-730)（Clash / OpenClaw 等顶层目录） |
| 通用技能权威 | [caucy2026/skills](https://github.com/caucy2026/skills) |

更新：2026-11-05（t88 · gork.bot协助开发）
