# grok.skills.vibekits

Grok Bot / vibekits.linux 线经验与技能备份，供同事**远程仿真**与接力开发。

- **通用技能权威库**：[caucy2026/skills](https://github.com/caucy2026/skills)（安装到 `~/.codex/skills/`）
- **本仓**：Linux 101/双架构、bot 云机仿针、继承包经验、`bot-kemi-box` 等 vibekits 专用技能与证据索引

## 布局

| 路径 | 内容 |
|---|---|
| `skills/` | 可安装技能目录（整目录复制到 `~/.codex/skills/`） |
| `docs/` | 交付口径、工具片段、关键文档 |
| `experience/` | 会话 work-notes / session 摘要 |
| `goals/` | 继承目标 |
| `INHERITANCE.md` | 继承说明 |

## 引用约定

技能之间互相引用时，**禁止写死本机路径**（`/Users/…`、`/Volumes/ORICO/…`、`~/.codex/skills/…`）。用 GitHub 地址做文件传递：

- 通用技能：`https://raw.githubusercontent.com/caucy2026/skills/main/<skill>/…`
- 本仓技能/经验：`https://raw.githubusercontent.com/caucy2026/grok.skills.vibekits/main/skills/<skill>/…`

同事拿仓后即可按 `skills/bot-kemi-box/SKILL.md` §0 口令做云机→101 仿针；合主线注明「gork.bot协助开发」。验证 ≠ 编译。

## 安装

```bash
git clone https://github.com/caucy2026/grok.skills.vibekits.git
cp -a grok.skills.vibekits/skills/bot-kemi-box ~/.codex/skills/
# 通用仿真 invoke 等仍从 caucy2026/skills 安装 vibekits-remote-simulator
```

更新时间：2026-11-03（t59 · vibekits.linux继承）
