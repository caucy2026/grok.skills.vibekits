# 运行时路径约定（覆盖继承包里的本机路径）

`INHERITANCE.md` / 旧 work-notes 里出现的 `/Users/newlink/…`、`/Volumes/ORICO/…`、`~/.codex/skills/…` 是 **2026-11-01 继承快照**，保留作考古。

**2026-11-04 起运行时：**

| 旧写法 | 新写法 |
|---|---|
| 控制机 Mac 钥匙串 / ORICO 证据盘 | bot 云机 `/workspace/…` + GitHub Releases/docs；凭证进 Vault |
| `~/.codex/skills/<name>/scripts/…` | `https://raw.githubusercontent.com/caucy2026/skills/main/<name>/…` 或本仓 raw |
| 控制机 `invoke.rb` 必经 | 优先云机 tool-bridge；invoke 仅作兼容 |

合主线注明 gork.bot协助开发。
