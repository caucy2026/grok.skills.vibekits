# Gork / Grok Bot 配置与交接

**gork.bot协助开发** · 2026-11-04 起硬规则：**日常工作不依赖控制机 Mac**。

## 执行宿主

| 角色 | 做法 |
|---|---|
| **主路径** | Grok Bot **云机（box）** 自当控制器：Docker vibekits + tool-bridge → 仿针 101 |
| **真机** | Linux **101** `mp730-156` · routingId **`7634801763`**（以当次 harness status 为准） |
| **Mac 控制机** | 仅历史/一次性 bootstrap；新同事不要假设 `/Users/newlink` 或 ORICO 仍可用 |

口令全文：[`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §0 / §6。

## 凭证

| 用途 | 存放 | 禁止 |
|---|---|---|
| KEMI KD / Common / JWT | **Vault** 或目标机临时 `mode 600` 文件，用完删 | 写进 git / 技能正文 / 公开 issue |
| tool-bridge token | 容器内 `tool-bridge.json`，用后即弃 | 扩散到聊天或本仓 |

## 异账号 Gork 投递

技能：[`skills/gork/SKILL.md`](../skills/gork/SKILL.md)

```text
invoke.rb ← https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
wrap/calib ← https://raw.githubusercontent.com/caucy2026/grok.skills.vibekits/main/docs/gork-sim-inject/…
```

成功判据 = 终屏本次用户蓝气泡（截屏），不是 API ok。

## 合主线注释模板

```text
gork.bot协助开发
Session-Name: vibekits.linux开发
（可选）Session-ID: 01a04dde-32ea-7da2-8b77-2991c5e79baf
```

## 通用技能依赖（勿整仓拷进本仓）

权威：https://github.com/caucy2026/skills

至少会用到：

- `vibekits-remote-simulator`（invoke / 通道恢复）
- `kemi-market-publish` / `newlink-common-release` / `kemi-send-common-release`
- `linux-desktop-build-acceptance`

本仓用 README + raw 链接指向即可。
