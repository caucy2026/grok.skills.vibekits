# 同类 101 设备经仿针上架 KEMI 商场（KD）

**gork.bot协助开发** · 验证 ≠ 编译。禁止杀目标上的 vibekits。正式上架包 ≠ Docker 冒烟包。

本页是单仓入口。步骤以本仓 [`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) **§10** 为准。合同与发布技能的权威在 caucy2026/skills 的 `kemi-market-publish`（下面 raw）。Common 屏保通道不是 KD，见 [`COMMON-RELEASE.md`](COMMON-RELEASE.md)。

## 默认真机

| 项 | 值 |
|---|---|
| 设备 | Linux 101 |
| hostname | `mp730-156` |
| routingId | `7634801763` |

同类设备（同代、可仿真的 Linux/Mac 客机）换用户给的 `routingId`，先按 `bot-kemi-box` §2 摸底，再走同一路径 B。不要拿别的机器的货架身份硬套。

## KD 基址与身份

| 项 | 值 |
|---|---|
| 商场 | `https://kemi.newlinksz.com/kd/` |
| API | `KD=https://kemi.newlinksz.com/kd-api` |
| 用户中心 | `UC=https://kemi.newlinksz.com/usercenter` |
| Linux 包 | `.deb` / `.AppImage` / `.rpm` → `os_type=linux`，upload category **`linuxpkg`** |
| 身份键 | `(package_name, os_type)`；已有记录则 **update**，不要为了躲更新再复制一条 |

VibeKits Linux x86_64 现网货架是 app_id **90**、`com.caucy.vibekits`。货架标题仍是 x86_64 时，禁止用 arm64 包覆盖 app 90。arm64 要独立货架策略：先按身份键查重，再决定 create 还是 update。

体积字段：`file_size` = 精确十进制字节字符串，`file_size_bytes` = 同值整数，另交 SHA-256。

线上文档（与技能冲突时先停、跟线上合同）：

- `https://kemi.newlinksz.com/kd/docs/ai-publish`
- `https://kemi.newlinksz.com/kd/docs/app-upload`
- `https://kemi.newlinksz.com/kd/docs/store-api`

## 路径 B（首选）

在 bot 云机上当控制器，仿针连上 101（或同类设备），再在**目标机**上调 KD：

1. `vibekits.simulator.connect`
2. Bearer 放到目标机 **mode 600** 文件（例：`/root/.kemi-publish/token`）
3. `package-token`，category=`linuxpkg`
4. multipart 上传
5. `package-complete`（核对 url / size / sha）
6. `apps/update`（`file_size` 与 `file_size_bytes` 一起带上）
7. 四层验收（§10.5）后 `disconnect`

Bearer 从本 bot **Vault** 取，或使用当次临时 token 文件。禁止把 Bearer、JWT、上传 token 写入本仓、技能正文、issue 或聊天。用完删除目标机与控制器上的临时文件。

路径 A（目标机浏览器里已登录的开发者控制台）少见，没有会话就不要硬开。路径 C（会话只在某台控制机浏览器里）只作为取 JWT 的备用，再以 mode 600 投到目标机；大包分片规则见 §10.2。日常不要把控制机 Mac 当成执行宿主。

`package-complete` 若在七牛 stat 上报 Connect timeout，而 CDN `Content-Length` 已经等于本地字节：**不要重传**。对同一 key 带 Bearer 重试 `POST /api/upload/package-complete`，直到 status=200 且 size/sha 与本地一致，再 `apps/update`。详见 §10.4。

## 最短命令序

与 §10.3 相同。invoke 用 raw，不要写死某台机器上的技能目录。

```bash
INV_URL=https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
curl -fsSL "$INV_URL" -o /tmp/vibekits-invoke.rb
INV=/tmp/vibekits-invoke.rb
RID=7634801763
ruby "$INV" vibekits.simulator.connect "{\"routingId\":\"$RID\"}"
# deb 与 mode 600 的 Bearer 文件放到目标机之后再 ssh_exec。
# 不要把 token 写进这条命令或仓库。
ruby "$INV" vibekits.simulator.ssh_exec "{\"routingId\":\"$RID\",\"command\":\"KEMI_TOKEN_FILE=/root/.kemi-publish/token /root/t61-market-publish/kemi_linux_publish_on_device.sh /path/app.deb 90 com.caucy.vibekits <version> <version_code>\"}"
ruby "$INV" vibekits.simulator.disconnect "{\"routingId\":\"$RID\"}"
```

无密钥的脚本模板可以放在目标机 `/root/t61-market-publish/kemi_linux_publish_on_device.sh`：查重 → `linuxpkg` token → multipart → complete → `apps/update` → 公共详情 / 列表 / 正负 `update/check` / CDN `Content-Length`。

云机侧仿针本身（ABCD、半残注册、consent、tool-bridge）走 [`REMOTE-SIM-INDEX.md`](REMOTE-SIM-INDEX.md) 与 `bot-kemi-box` **§0**。`toolId` 不是 `name`。首次连接要目标 UI 同意，禁止旁路 consent。

## 权威 raw

```text
https://raw.githubusercontent.com/caucy2026/skills/main/kemi-market-publish/SKILL.md
https://raw.githubusercontent.com/caucy2026/skills/main/kemi-market-publish/references/release-contract.md
https://raw.githubusercontent.com/caucy2026/skills/main/vibekits-remote-simulator/scripts/invoke.rb
```

技能树：<https://github.com/caucy2026/skills/tree/main/kemi-market-publish>

本仓口令正文：[`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §10。T61 证据（无密钥）：[`work-notes/t61-20261103/DEBUG-T61-101-SIM-MARKET-PUBLISH-20261103.md`](work-notes/t61-20261103/DEBUG-T61-101-SIM-MARKET-PUBLISH-20261103.md)。

## 验收（摘自 §10.5）

- 开发者 list 里 `(package_name, os_type)` 唯一，且 version_code 是目标值
- `GET /api/store/apps/{id}?os=linux`：HTTPS URL、精确 `file_size`、SHA、version_code
- 不带 category 的 Linux 公共列表含该 app
- CDN HEAD `Content-Length` = 本地字节
- 旧 version_code：`has_update=true`；当前 code：`has_update=false`
- 删除 101 与控制器上的临时 token；不杀目标 vibekits
