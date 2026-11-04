# 远程仿真资料索引

**gork.bot协助开发** · 脚本一律 **GitHub raw**，禁止本机技能绝对路径。

## 最短成功路径（云机 → 101）

1. 读 [`../skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) **§0**
2. 钉 ABCD hosts（§6.2）；半残 registered 只重启**云机** vibekits+relay（§6.8）
3. tool-bridge：`toolId`（不是 `name`）→ `connect` →（目标 UI consent）→ `ssh_exec` / `upload_file` → `disconnect`
4. **禁止**杀 101 vibekits；consent 禁止旁路

默认 RID：**7634801763**（101，`mp730-156`）。其它设备换用户给的 routingId，先摸底。

上架 KD（路径 B：仿针 → Bearer → `linuxpkg` → complete → `apps/update`）：[`KEMI-MARKET-101.md`](KEMI-MARKET-101.md) · `bot-kemi-box` §10。  
Common 屏保通道不是仿真、也不是 KD：[`COMMON-RELEASE.md`](COMMON-RELEASE.md)。  
从零搭 Bot：[`GORK-BOT-HANDOFF.md`](GORK-BOT-HANDOFF.md)。

## 关键文件（本仓）

| 路径 | 内容 |
|---|---|
| `skills/bot-kemi-box/SKILL.md` | 云机编译 + 真机验证 + 仿针 + 商场 §10 |
| `docs/KEMI-MARKET-101.md` | 同类 101 经仿针上 KD 的单仓入口 |
| `docs/COMMON-RELEASE.md` | Common 屏保通道（与 KD 分开） |
| `docs/GORK-BOT-HANDOFF.md` | 从零搭 Grok Bot、Vault、凭证 |
| `skills/vibekits-remote-simulator/` | 本仓镜像（通用权威仍在 caucy2026/skills） |
| `skills/vibekits-remote-simulator/scripts/invoke.rb` | 控制端 invoke（若用本仓副本） |
| `skills/vibekits-remote-simulator/references/*` | 通道恢复、consent、市场更新、Windows/Mac 事故 |
| `docs/gork-sim-inject/` | 投异账号 Gork 的 calib / wrap |
| `docs/codex-AGENTS.md` | 会话约束镜像 |

## 通用权威（caucy2026/skills）

```bash
INV_URL=https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
curl -fsSL "$INV_URL" -o /tmp/vibekits-invoke.rb
```

通道恢复长文：  
https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/references/channel-recovery.md  
（本仓亦有同名 references，有分歧时以 **caucy2026/skills** 为准并开 PR 回灌。）

## 验收口诀

- SSH 通 ≠ 仿真通
- `connected:true` + 同 routingId + 真实工具调用（进程/页面）才算
- transport 常见 `p2p_or_relay`；`transport_timeout` 先查目标静默 peer（§6.9）
