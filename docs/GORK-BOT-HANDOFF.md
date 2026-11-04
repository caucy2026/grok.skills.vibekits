# Gork / Grok Bot 配置与交接

**gork.bot协助开发** · 2026-11-04 起硬规则：**日常工作不依赖控制机 Mac**。

三条同事路径（只看本仓）：

| 要做的事 | 打开 |
|---|---|
| 从零搭 Bot | 本节「从零搭 Grok Bot 同事清单」 |
| Common 默认发布通道 | [`COMMON-RELEASE.md`](COMMON-RELEASE.md) |
| 同类 101 上 KD | [`KEMI-MARKET-101.md`](KEMI-MARKET-101.md) · [`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §10 |

## 从零搭 Grok Bot 同事清单

1. **装本仓 skills。** 克隆 `https://github.com/caucy2026/grok.skills.vibekits`，把 `skills/bot-kemi-box` 与 `skills/gork` 拷进你们代理的 skills 根。不要写死某台控制机的目录。
2. **装通用技能（caucy2026/skills，不要整份拷进本仓）。** 执行宿主上要有这三份，互相引用只用 raw：
   - `vibekits-remote-simulator` — <https://github.com/caucy2026/skills/tree/main/vibekits-remote-simulator>
   - `kemi-market-publish` — <https://github.com/caucy2026/skills/tree/main/kemi-market-publish>
   - `newlink-common-release` — <https://github.com/caucy2026/skills/tree/main/newlink-common-release>
3. **Vault 放 Common + KD。** 在本 bot 的 Vault 里放好再开工：
   - Common 密码（条目标题常为 `newlinksz.cn`）。用户名用文档里的 `common`。
   - KD 的 Bearer（商场开发者会话）。
4. **云机起 vibekits。** 按 [`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §6：钉 ABCD、实活注册、tool-bridge。容器当控制器。
5. **§0 仿针 101。** 默认真机 `mp730-156` / routingId `7634801763`：`connect` → 真实工具调用 → `disconnect`。首次要目标 UI 同意。禁止杀 101 上的 vibekits。同类设备只换 routingId，先摸底。

仿真资料索引：[`REMOTE-SIM-INDEX.md`](REMOTE-SIM-INDEX.md)。技能总表：[`SKILLS-INDEX.md`](SKILLS-INDEX.md)。

## 执行宿主

| 角色 | 做法 |
|---|---|
| **主路径** | Grok Bot **云机（box）** 自当控制器：Docker vibekits + tool-bridge → 仿针 101 |
| **真机** | Linux **101** `mp730-156` · routingId **`7634801763`**（以当次 harness status 为准） |
| **Mac 控制机** | 仅历史/一次性 bootstrap；新同事不要假设控制机本机目录或外置盘仍可用 |

口令全文：[`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §0 / §6。

## 凭证

默认账号名可以写进文档。密码、Bearer、JWT 的值只放 Vault 或当次临时文件。

| 用途 | 存放 | 禁止 |
|---|---|---|
| Common 用户名 | 默认 **`common`**（可用 `NEWLINK_COMMON_USERNAME` 覆盖） | — |
| Common 密码 | **Vault**（本 bot 条目标题常为 `newlinksz.cn`）或当次环境变量 `NEWLINK_COMMON_PASSWORD`；用后 `unset`，临时文件 `shred -u` | 把值写进 git / 技能 / issue。见 [`COMMON-RELEASE.md`](COMMON-RELEASE.md) |
| KEMI KD Bearer / JWT | **Vault**，或目标机临时 `mode 600` 文件，用完删 | 写进 git / 技能正文 / 公开 issue。见 [`KEMI-MARKET-101.md`](KEMI-MARKET-101.md) |
| tool-bridge token | 容器内 `tool-bridge.json`，用后即弃 | 扩散到聊天或本仓 |

历史 Mac Keychain（service=`KEMI Newlink Common Publisher`，account=`common`）只作对照。新同事不要假设 Keychain 可用。

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
- `kemi-market-publish` → [`KEMI-MARKET-101.md`](KEMI-MARKET-101.md)
- `newlink-common-release` → [`COMMON-RELEASE.md`](COMMON-RELEASE.md)
- `kemi-send-common-release` / `linux-desktop-build-acceptance`

本仓用 README + raw 链接指向即可。不要把通用技能整份拷进本仓。
