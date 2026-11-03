# vibekits.linux开发 — 完整继承包（gork.bot 2026-11-01）

生成时间：2026-11-01 14:45 Asia/Shanghai

## 1. 会话身份（必须原样继承）

| 字段 | 值 |
|---|---|
| name | **vibekits.linux开发** |
| 曾用名 | vibekits → vibekits.软件发布 → vibekits.软件发布（linux）→ vibekits.linux开发 |
| thread id | `01a04dde-32ea-7da2-8b77-2991c5e79baf` |
| cwd | `/Users/newlink/kemi/RustDesk` |
| writable roots | `/Users/newlink/kemi/RustDesk`, `/Volumes/ORICO/newlink-new/vibekits`（另常关联 hbbv） |
| rollout | `/Users/newlink/.codex/sessions/2026/08/29/rollout-2026-08-29T22-13-22-01a04dde-32ea-7da2-8b77-2991c5e79baf.jsonl`（约1.94GB；本包软链 `session/rollout-FULL.jsonl`） |
| 目标状态 | **active** |
| goal_id | `6193ed96-b55d-4c72-8001-a33f1c29ecba` |
| 描述缓存 | 101 Linux VibeKits 多线程编译、Mali GPU、CPU占用优化、Harness 仿真 |

本包路径：
- ORICO：`/Volumes/ORICO/gork.bot/vibekits-linux-inherit-20261101/`
- Documents 镜像：`/Users/newlink/Documents/_vibekits-linux-inherit-20261101/`

## 2. 双目标（不可裁剪）

权威：`goals/thread-goal.txt`、`docs/LINUX_101_THREE_APPS_DELIVERY_GOAL_20261031.md`、`docs/LINUX_101_REQUIREMENTS_AND_ACCEPTANCE_20261030.md`。

1. **Apple / App Store Connect**：沿既定 KEMI Apple 发布技能核验 VibeKits ASC 精确记录与完整拒绝原因；最小永久商城专用改动修复、验证、上传并显式送审，推进至目标版本公开可下载/安装启动/核心功能通过。用户曾要求人类暂缓 Apple 时须核对最新用户指令，不擅自恢复。
2. **VibeKits Linux 全功能 + 历史回归**（主责设备 **101 / mp730-156 / ARM64**）：UI/键盘/文件选择、Harness+扫码 Key、房间集群/远程仿真、应用中心安装打开关闭更新、自启与身份授权延续、兼容架构及资源/日志稳定性；发现问题自主修复重建复验；**不以启动或部分测试代替全功能通过**。另含五应用扩展目标（远程办公/传书/Clash Verge/KOffice）见 THREE_APPS 文档。88 做 amd64 兼容。保护其他平台与 MAC DESK Apple 跟踪。

## 3. 工作方法与约束

1. `docs/codex-AGENTS.md`（镜像自 `~/.codex/AGENTS.md`，**勿改原文件**）
2. `docs/LOCAL-ENVIRONMENT-RULES.md`（ORICO 构建外盘强制；本机控制端）
3. 技能入口（已复制到 `skills/`）：
   - **`vibekits-linux-release`** — Linux 编译/调试/验收/商场发布总入口
   - **`linux-desktop-build-acceptance`** — 通用字体/GLIBC/透明窗/低内存
   - **`vibekits-remote-simulator`** — 按 routingId 远程仿真；正式构建/验收必须回原仿真通道
   - **`rust-linux-cross-build`** — 仅纯 Rust Linux 二进制交叉，不用于 Flutter 桌面整包
4. 合主线/文档/提交注明 **`gork.bot协助开发`**，并含 `Session-Name: vibekits.linux开发` / `Session-ID: 01a04dde-32ea-7da2-8b77-2991c5e79baf`
5. **验证≠编译**；上传成功≠发布；SSH 连通≠仿真通过
6. companion 手机线勿抢：`/Volumes/ORICO/kemi-build-cache/vibekits-companion/monorepo-worktree`
7. 集群线另包参考：`/Volumes/ORICO/gork.bot/vibekits-cluster-inherit-20261101/`（非本会话主责；集群编译 SUSPENDED 勿自恢复）

## 4. 「云主机」与 101 标识（本会话事实）

| 项 | 值 |
|---|---|
| 云主机/构建机含义 | **就是设备 101 本机 ARM64 Ubuntu 构建根**，不是 swdol-box，也不是在 newlink Mac 上交叉编 Flutter arm64 |
| 构建根（会话沿用） | `/opt/vibekits-build-arm64-705-20261021/`（例：`source-main*-linux76x-r1`、`stage*-runtime-arm64-r1`） |
| 控制机 cwd | `/Users/newlink/kemi/RustDesk`（经仿真驱动 101 上的构建单元） |
| 共享源码树 | `/Volumes/ORICO/newlink-new/vibekits`（脏树；隔离构建源在 101 `/opt/...`） |
| 101 主机名 | `mp730-156` |
| 101 Harness routingId | **`7634801763`** |
| 成功判据（仿真） | `connected:true` + 同 routingId + `transport: p2p_or_relay` + 真实工具调用（进程/页面），SSH 备用只作同机恢复 |

查阅入口：`docs/LINUX_101_REQUIREMENTS_AND_ACCEPTANCE_20261030.md`、会话 rollout 尾部、目标机 `simulator.status` / 控制端 `vibekits.simulator.connect`。

## 5. 聊天记录落盘

| 文件 | 内容 |
|---|---|
| `session/thread-meta.txt` | 线程元数据 |
| `session/session-meta.json` | session_meta（instructions 截断） |
| `session/rollout-FULL.jsonl` | 全文软链（~275k 行 / 1.94GB） |
| `session/ALL-REAL-USER-MESSAGES.md` | 全部真实用户消息 |
| `session/real-user-messages.jsonl` | 同上 JSONL |
| `session/assistant-agent-messages.jsonl` | 近期助手结论尾部 |
| `session/LAST-CONCLUSIONS.md` | 最近助手结论可读版 |
| `session/STATUS-MENTIONS.md` | 状态关键词提及 |
| `session/AFTER-UNFINISHED-ASK.md` | 近期含继续/101/编译等用户消息 |
| `goals/thread-goal.txt` | SQLite 登记目标全文 |

## 6. 未完成项（继承时快照，详表见 work-notes）

会话尾部（2026-11-01 ~14:42 CST / 06:42Z）现场：

- **765** 只读标记漏装已修并同步主线；用户已回复「恢复资格，继续原门禁」；补标记后复测 **完整进程族 CPU 中位约 50%**，GUI≈45% 单核等效，主因 **llvmpipe 软件渲染**；未发布。
- GPU/应用加速路径调查未闭环（保留画质帧率，不关动画压数字）。
- Linux 全功能回归（应用中心/键盘文件/Harness Key/房间/自启身份/日志）与五应用商城发布仍缺最终包证据。
- Apple/ASC 拒审修复→重提：目标仍在 goal 内；执行前核用户是否仍暂缓。
- 资格：曾出现 `QUALIFICATION_EXECUTOR_SUSPENDED` 预部署 BLOCK；用户口头恢复后须按项目台账/检查器登记复核，不得自我恢复集群线资格。

## 7. gork.bot 接手当次动作

- [x] 定位 `01a04dde-…` / vibekits.linux开发 并落盘全文软链/用户消息/技能/约束/目标
- [ ] 按用户最新指令：读全局技能 → 在 101 云构建根把 VibeKits Linux 编过 → 原仿真连上 101（7634801763）并留证据
- [ ] 合主线注明 gork.bot协助开发；验证≠编译
