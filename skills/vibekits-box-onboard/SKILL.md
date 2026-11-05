---
name: vibekits-box-onboard
description: Use when an empty Grok Bot or new colleague must go from zero to downloading VibeKits, deploying it on the bot cloud box, applying ABCD/simulator settings, and simulating a 101-like device — following only caucy2026 GitHub (this repo + skills raw), no Mac/ORICO paths.
---

# Vibekits 云机全链路（空 bot 可执行）

**权威导读**：[START-HERE.md](https://github.com/caucy2026/grok.skills.vibekits/blob/main/START-HERE.md)（本仓根目录）。本技能是导读的步骤化执行版。

合主线「gork.bot协助开发」。验证 ≠ 编译。禁止杀目标 vibekits。  
仿真 invoke / 通道恢复 **不要在本仓重复维护全文** → 一律 raw：

```text
https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/references/channel-recovery.md
```

细则长文：本仓 [`bot-kemi-box`](https://github.com/caucy2026/grok.skills.vibekits/blob/main/skills/bot-kemi-box/SKILL.md) §0 / §6。

## When

- 空 Grok Bot / 新同事只拿到本仓链接
- 需要：下载可跑包 → 云机部署控制器 → 设置 → 仿针 101（或同类 RID）

## Steps

1. **读指针**  
   `curl -fsSL https://raw.githubusercontent.com/caucy2026/grok.skills.vibekits/main/packages/CURRENT.json`  
   记录 `release_tag`、amd64 / arm64-focalrt 的 name、sha256、bytes。

2. **下载（只走本仓 Releases）**  
   `https://github.com/caucy2026/grok.skills.vibekits/releases/download/<tag>/…`  
   - 云机控制器：`…-linux-amd64.deb`（或统一 tar）  
   - 101 Focal：`…-linux-arm64-focalrt.deb`（未捆绑 arm64 会 GLIBCXX FAIL）  
   `sha256sum -c` 必须过。

3. **云机部署**  
   按 [docs/BOX-DEPLOY.md](https://github.com/caucy2026/grok.skills.vibekits/blob/main/docs/BOX-DEPLOY.md)：Ubuntu 20.04 amd64 容器 + Xvfb `:99` + 安装/解压 amd64 包 + 启动 vibekits 与 harness-relay。  
   数据目录自定；记下 `VibekitsData/Mcp/tool-bridge.json`（token 勿外泄）。

4. **设置**  
   - 宿主机+容器钉 ABCD（见导读 §5 / bot-kemi-box §6.2）  
   - `simulatorAccessEnabled=true`；对齐 `protocol_v4`  
   - 实活注册：ESTAB 真 IP + `request_pk`（§6.8 防虚报）  
   - `openssh-client` 已装

5. **仿针**  
   - 默认真机 RID `7634801763`（101）  
   - 控制机路径：raw `invoke.rb` → connect → ssh_exec → disconnect  
   - 云机路径：tool-bridge，`toolId` 字段 → 同序；首次目标 UI consent  
   - 错误表：bot-kemi-box §6.9

6. **回执**  
   控制器 routingId、目标 RID、hostname、transport、sha、是否经 consent；临时文件删掉。

## Do not

- 写死 `/Users`、`/Volumes/ORICO`、`~/.codex/skills`  
- 把 Bearer / tool-bridge token 推进 git 或技能正文  
- 用未捆绑 arm64 deb 冒充 101 可跑包  
- 用 arm64 覆盖商场 app90；arm64 独立货架是 `com.caucy.vibekits.arm64`  
- 杀目标 vibekits；无授权盲重启目标

## Related

- 导读：本仓 `START-HERE.md`  
- 包：`docs/PACKAGES.md` · `packages/CURRENT.json`  
- 仿真索引：`docs/REMOTE-SIM-INDEX.md`  
- 通用权威：`https://github.com/caucy2026/skills`
