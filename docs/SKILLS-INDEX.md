# 本仓 skills 索引

安装：把目录复制到你们代理的 skills 根。互相引用用 **GitHub raw**，不要写死控制机本机目录。

| 目录 | 用途 | raw 根 |
|---|---|---|
| `bot-kemi-box` | 云机编译 / 101 仿针 / ABCD·consent·tool-bridge / 商场 §10 | `…/grok.skills.vibekits/main/skills/bot-kemi-box/` |
| `gork` | 仿真投异账号 Grok Bot | `…/skills/gork/` |
| `vibekits-remote-simulator` | 远程仿真（本仓有副本；**权威**优先 caucy2026/skills） | skills 仓或本仓 |
| `vibekits-linux-release` | Linux 编译调试验收商场总入口 | 本仓 |
| `linux-desktop-build-acceptance` | 字体/GLIBC/透明窗/低内存 | 本仓（通用亦可 skills 仓） |
| `rust-linux-cross-build` | 纯 Rust Linux 交叉（非整包 Flutter） | 本仓 |

通用商场 / Common / Apple 等：**不要**整份拷进本仓，直接链到  
https://github.com/caucy2026/skills

## 同事入口互链

| 要做的事 | 本仓 | 权威 raw |
|---|---|---|
| 从零搭 Grok Bot | [`docs/GORK-BOT-HANDOFF.md`](GORK-BOT-HANDOFF.md) | `vibekits-remote-simulator` |
| Common 默认发布 | [`docs/COMMON-RELEASE.md`](COMMON-RELEASE.md) | <https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/scripts/publish_common.py> · <https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/references/release-contract.md> |
| 同类 101 上 KD | [`docs/KEMI-MARKET-101.md`](KEMI-MARKET-101.md) · `bot-kemi-box` §10 | <https://raw.githubusercontent.com/caucy2026/skills/main/kemi-market-publish/SKILL.md> · <https://raw.githubusercontent.com/caucy2026/skills/main/kemi-market-publish/references/release-contract.md> |
| 远程仿真 | [`docs/REMOTE-SIM-INDEX.md`](REMOTE-SIM-INDEX.md) | <https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb> |
