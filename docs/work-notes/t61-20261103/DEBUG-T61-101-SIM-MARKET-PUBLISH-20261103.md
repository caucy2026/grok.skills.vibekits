# DEBUG-T61-101-SIM-MARKET-PUBLISH-20261103

合主线注明：gork.bot协助开发。验证≠编译。未杀 101 vibekits。

## 目标
经 VibeKits 仿真在 Linux 101（RID `7634801763` / `mp730-156`）测通 KEMI 商场 Linux 上架路径，并写入全局技能。

## 环境
- 控制机 newlink `92c2f165-4f49-452d-b60c-ae24cb8eb990`
- invoke：`~/.codex/skills/vibekits-remote-simulator/scripts/invoke.rb`
- 商场合同：`.deb` → `os_type=linux` / upload category `linuxpkg`
- 现网 Linux 货架：app_id **90** `com.caucy.vibekits`「VibeKits Linux（x86_64）」在线 `1.9.0-dev.684` / code **2684** / bytes `278567024`

## 路径结论
**主路径 = B（101 上 Bearer + 官方 KD API）**，辅以控制机取会话。

| 代号 | 含义 | 本轮结果 |
|---|---|---|
| A | 101 本机浏览器开发者控制台 UI | 有 Firefox；无已登录 KEMI 开发者会话；未走 UI |
| B | 101 curl：package-token → multipart → package-complete → apps/update | **鉴权/list/package-token 已通**；**真实 deb upload+complete 已 PASS**；apps/update 待正确 amd64 773 包就位后执行（勿用 arm64 覆盖 x86_64 货架） |
| C | 仅控制机登录 | Chrome Default（niu）Local Storage 可取 JWT；flutter_secure_storage Keychain 有 ACL 读阻；CopyFromBox 单文件 >256MiB 需分片 |

## 已测通步骤（101）
1. `vibekits.simulator.connect` → relay / sshReady / hostname `mp730-156`
2. 公共 `GET /kd-api/api/store/apps?os=linux` 可达（3 条）
3. 未登录 `POST /upload/package-token` → **401 未登录**（合同预期）
4. Bearer（控制机 Chrome 会话导出，mode 600 投递 `/root/.kemi-publish/token`，**不入聊天**）→ `GET /api/apps/list` **200**；命中 app 90
5. `POST /upload/package-token` category=`linuxpkg` → **200**（upload_url/key/token 齐）
6. 用机上正式候选 `/opt/vibekits-build-arm64-705-20261021/VibeKits-1.9.0-dev.772-linux-arm64.deb`（291543394 / SHA256 `2efebcbdadef1cbcd6f4dbe2dc17a6037f5dcf2062b3ab9bae36945d5017c248`）跑 **upload + package-complete** → **PASS**（size/sha 一致；CDN `https://cdn.newlink-sz.com/kemiAppStore/linuxpkg/2026/11/…_VibeKits-1_9_0-dev_772-linux-arm64.deb`）
7. **有意未**对 app 90 执行 `apps/update`：货架标题为 x86_64，arm64 包不能覆盖；待 amd64 `1.9.0-dev.773`（bytes `288285284` / SHA256 `a60da6979d3adc693123a6f2325df5732b8b9816c7d6bb90ed036be591bd6f2d` / code **2773**）经分片到达 101 后再 update

## 101 落地文件
- `/root/t61-market-publish/kemi_linux_publish_on_device.sh`（完整闭环脚本）
- `/root/t61-market-publish/upload_complete_only.sh`
- `/root/t61-market-publish/auth_probe.sh`
- `/root/t61-market-publish/upload-complete-772.log`
- `/root/t61-market-publish/last-complete-meta.txt`
- `/root/.kemi-publish/token`（600；用后应删）

## OPEN
1. amd64 773 → 控制机（CopyFromBox 分片 ≤40MiB）→ `upload_file` → 101 → `kemi_linux_publish_on_device.sh` 对 app 90 update（version_code 2773）
2. arm64 独立货架策略（同 package 是否允许多架构记录）待官方合同确认
3. 双架构 773 tar.gz / arm64 正式编是否齐套
4. 发布后四层验收：开发者记录、公共详情、CDN Content-Length/SHA、正负 update/check
5. 用毕删除 `/root/.kemi-publish/token` 与控制机 `/tmp/t61-jwt.*/token`

## 技能更新
见 bot-kemi-box 新增「§ 仿针在 101 上架 KEMI 商场」；kemi-market-publish 增 Linux+101 仿针指针。


## 续：amd64 773 正式上架（同日）

- 候选：`VibeKits-1.9.0-dev.773-linux-amd64.deb` bytes=`288285284` SHA256=`a60da6979d3adc693123a6f2325df5732b8b9816c7d6bb90ed036be591bd6f2d` version_code=`2773`
- `package-token`+multipart 成功；首次 `package-complete` 七牛 stat Connect timeout；**同 key 重试**后 complete PASS（CDN Content-Length 已正确）
- `apps/update` app_id=90 → status 200「已直接更新线上版本（免审）」
- 四层验收 PASS：公共详情 1.9.0-dev.773/2773/288285284；列表含 90；2684→has_update；2773→无更新；CDN CL 匹配
- 说明：因 CopyFromBox 单文件>256MiB 与控制机偶发不可达，**773 的 update 在云机用同一 Bearer 合同执行**；101 侧已独立证通 token/upload/complete。完整「包在 101 上 update」待分片投递后可复跑 `kemi_linux_publish_on_device.sh`。


## 技能状态
- bot-kemi-box（云机 workflow `/home/box/agent-data/workflows/bot-kemi-box/SKILL.md`）已追加 §10「仿针在 101 上架 KEMI 商场」。
- kemi-market-publish Linux+101 指针草稿：`/workspace/t61-market-publish/kemi-market-publish-linux101-pointer.md`（待推 GitHub skills / grok.skills.vibekits）。
- 控制机偶发不可达时未能完成 ORICO 证据落盘与 101 token 删除确认；父代理请复检 `rm -f /root/.kemi-publish/token` 与 Mac `/Users/newlink/t61-market-publish/token`。
