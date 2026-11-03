# Linux 101 研发与验收要求

日期：2026-10-30，Asia/Shanghai。执行会话：vibekits.linux开发；Session-ID：01a04dde-32ea-7da2-8b77-2991c5e79baf。

## 目标和范围

以101（mp730-156，ARM64）为主完成最新主线 VibeKits 和 KEMI远程办公的开发、安装与真实验收，88作为amd64兼容验证设备。先核对最新代码已有功能，缺项才实施最小修改。Apple发布按用户此前要求继续暂停。

用户最新要求包括：通过hbbv在非同一局域网输入Harness Key；应用中心能下载安装、打开、关闭和更新；两个应用在101实际运行；测试可自动执行并保存证据。必要的hbbv修复已获实施和按部署文档部署授权，仍须满足正式部署、身份、备份与资格门禁。

## 验收清单

|编号|要求|通过证据|
|---|---|---|
|L01|冻结最新主线与本会话Linux修改；保留其他端行为|源码提交、精确差异、输入清单和最终包哈希；不是目录名称或旧版本快照|
|L02|101/88对应架构完整构建|真实退出码、阶段耗时、实际并发、ELF架构、依赖及GLIBC审计、完整SDK与资源清单|
|L03|低内存、多核与即时反馈|101使用其八核能力并记录实际并发；点击有即时反馈；秒表连续显示；同机同场景前后CPU/RAM/Swap/响应数据；G6完整进程族单核等效空闲CPU中位数≤5%|
|L04|中文、字体、窗口和输入|中文环境界面中文、无乱码、远程窗口倒角透明；真实键盘、文件选择及收发结果|
|L05|hbbv跨网扫码输入Key|公网HTTPS二维码，手机与101不同网络；字段绑定、取消、过期、一次性消费、错误目标与重放拒绝；Key不进入URL、日志、报告或明文持久中转；实际填入并可正常使用|
|L06|Harness与房间仿真|原身份、Key与系统权限保持；默认通用服务按正式签名协议接入；实时心跳和真实工具调用；模型请求、文件与输入能力各自验收|
|L07|应用中心|正确ARM64/amd64包选择；下载完整性、正常安装、打开到前台、关闭、旧版更新、当前版不重复更新；状态缓存与点击反馈；不因密钥环问题循环弹窗|
|L08|KEMI远程办公|在101及88启动；本机Mac实际连接、画面和键鼠输入；断连重连、连接时间与帧率、后台资源；硬件H264/H265需以实际编码器和会话证据确认，不能把软件回退报硬编|
|L09|启动与升级|登录桌面后自启；单实例聚焦；旧授权版本覆盖升级后设备ID、账号、Keyring、权限和数据延续；不启用系统自动登录|
|L10|稳定性和日志|历史错误回归、错误/警告可追溯与脱敏；普通日志24小时、错误证据最多7天及容量轮转；完整包绑定的稳定性记录|
|L11|交付与主线|经验证的本会话Linux改动同步最新main，提交标注会话与影响范围；Remote Office同产物发布Common及KEMI商城，VibeKits发布KEMI商城；同一App兼容两架构；公开下载哈希与安装启动复验|
|L12|收尾|保留当前运行、在途输入、源码、原SDK/工具链、身份与最新正式包；核归属后清闲置生成物，回读实际可用空间；云端不留数据库备份，本地最近3份有效一致性备份|

## 已验证事实与未完成项

2026-10-30经已保存SSH连接核验：101为aarch64，运行VibeKits760 PID106997，路径位于source-public760-r1的bundle；当时磁盘可用80,909,455,360字节。该结果只证明旧候选运行，不是最新版验收。

当前101 Harness ID为7634801763，原主机SSH指纹沿用登记记录。实际relay状态为registered/callable，仿真访问开启；控制端1554650784的首次同意记录仍为空。请求具有有效期，旧请求消失时不得声称仍有弹窗；先对账再决定重新申请。后台房间资格、设备首次信任、系统管理员认证分别验收，不能互相代替。

已读本地Key接收实现为LanHarnessKeyReceiver，生成私网HTTP地址；两个扫码入口调用该接收器。这证明该入口受LAN限制，不能证明最新main或其他协同入口均无跨网实现；必须继续核对最新main再确定补丁范围。

尚无本轮最新版本的L02—L11全项通过证据。未发现名为rustdesk的进程不等于穷尽所有远程办公进程；需按安装清单与实际可执行路径补核。

## 执行顺序与恢复

1. 读最新main规则、资格台账及相关技能，核实际会话资格、共享脏树与当前事务。只读检查不因构建受阻停止。
2. 冻结最新源码，逐项映射已有实现、测试和真实设备证据；保留有效通过项，补缺而不重复开发。
3. 原仿真失败时使用已登记同机SSH/SFTP或远程办公，核固定指纹、原PID/出生时间和回执；不重复构建或安装。首次信任按正式目标端确认完成，不自行写授权名单或数据库。
4. 先完成hbbv跨网Key合同与客户端集成，再正式仿真构建、完整打包、101安装验收，随后88兼容验证。具体资源与并发门禁以当前官方检查器及实测为准。
5. hbbv确需改动时按hbbv-server-build-deploy：冻结测试源码、只落本地的一致性备份、保原serverId/身份/配置与外部门户、原supervisor部署、实际加载哈希与HTTPS功能复验、清自有云端暂存。部署前按当前台账检查资格，不因用户一般授权跳过真实门禁。
6. 失败记录准确原因、修复、负控与原场景复验；编译/单测/上传均不代替最终功能或发布通过。每项报告必须标版本、源码、产物哈希、时间、设备和剩余缺口。

## 进度记录格式

### 101 请求展示实测恢复（2026-10-30）

原保存SSH档案可正常以root执行，固定主机身份保持。760 App PID106997、启动代次1793194953800持有32147/32148；relay107109与只读控制子进程107448来自同一bundle，不能仅凭进程数清理。

通过原SSH访问目标现有受令牌保护loopback工具桥（令牌只在目标进程内使用），实际读取simulator.status、cluster.status和限定自有进程AT-SPI控件。状态为enabled/ready，customer=kemi、正式hbbv origin。仅此不证明跨机授权通过。

目标先显示Harness“开始使用”WebKit引导层，实际点击其“关闭”后读回消失。之后发现设置弹层已打开；工具对Ctrl+comma返回Unsupported key不能证明界面未变化，后续新鲜控件读回才是依据。实际退出本轮设置后，重新发起请求927949e7-7688-4bd5-8759-b6c42993c396，原生待办同ID存在，目标控件真实出现“拒绝”“允许”“暂不处理”。此前请求a9448c0f曾在设置层期间原生可见但界面未检出，之后过期；不能把到期待办消失称授权成功。

这组证据证明当前正常界面恢复后新请求可显示；尚未证明所有模态场景的永久源码修复。精确配对已请求人类确认，尚未点击允许；设备同意持久化、原ID连接、真实工具调用与持续稳定性均待验。不得直接写白名单或拿本机SSH成功冒称仿真通过。

### 2026-10-30 主线对账

- L01：已从origin获取main，核对提交d018507f573cdb937debdfbc10c92282343877c1。共享工作树未切换或重置；后续实现必须以此真实主线或更新后的明确冻结提交为依据。
- L05：main包含lan_harness_key_receiver.dart；本地harness_key_scan_dialog.dart尚不在该main树中，不能将本地新增入口称为主线已具备。main另有companion_host账号、手机事件与文件中继模块，须继续核对其是否提供安全Key传输，而不是仅凭LAN接收器判断整个产品缺跨网能力。
- 后端源码目录hbbv与priv当前均不是可直接使用origin的Git工作树；已定位server源码，但还未确认最新后端来源。不得把这两份目录直接当作最新生产源码部署。
- 后续已沿成熟备份脚本找到真实仓库：`/Volumes/ORICO/kemi-build-cache/app-release-gate/hbbv/github-backup-20260928`，origin为`caucy2026/priv`；获取main为ad74b9cecac3acd7f570c1a15caa9cac978129f9，hbbv位于其前缀下。此前目录非Git不再是源码定位阻塞。
- 已读取最新HostFileRelayTransport与AccountCollaborationFiles：它们要求同账号安装绑定、文件操作授权和SDK归属，内容由服务器持有的cipher加密并可解密，不是手机浏览器到目标输入框的一次性端到端秘密交接。不能将API Key伪装为附件发送来冒充跨网扫码实现，也不能跳过账号/文件权限。L05还需核对独立输入协议及与正式账户通道的集成边界，当前保持待实现/待验，未部署。

每次更新记录编号、状态（待查/待实现/验证中/PASS/BLOCK）、实际版本与哈希、命令或入口、真实结果、证据路径和下一动作。自动测试使用合成Key或明确授权的安全输入，不输出真实秘密；没有真实接收与外部效果的测试不得标PASS。


### 2026-10-31 status correction

L01: latest main03e8512a548e6ed1aa13ed90c8f65015f47597d5 now integrated into task branch commit155852c3df160b3ade81c1f926923aff4395b3c7; no complete client build yet, no main activation.
L07/L08: native secure-store startup creation defect repaired and real101 startup/ID/zeroCreate/Unlock/Prompt verified; this does not complete App Center or keyboard.
L08: real Mac connection remainsVP9; actual both OMX encoders initialize but sole first-packet probe returns0. Bounded async candidate4CPU tests pass, ARM native/runtime stillpending. Automatic keyboard fixture remainsNOT_PROVEN, not pass.
L09: ID digest preserved in current diagnostic candidate; full old-installed→final-package upgrade and permissions stillpending.
L12: one owned phase cleaned109files/links121414211logical bytes with same-volume before/after proof; not all historical workspaces claimed clean. CurrentROA4 PID945588 and original sim7634801763 retained. Mac own101 connection and GTK fixture ended; original port-forward window restored.
Detailed authoritative receipt paths and remaining scope: LINUX101_REMOTE_OFFICE465_PROGRESS_20261030.md and source branch report client/kemi-docs/LINUX101_CURRENT_ACCEPTANCE_20261031.md. Apple remains paused; no Common/market publication.

### 2026-10-31 application-center architecture boundary

Fresh original simulation on7634801763 operated the real761 process800151/start1793366194670 App Center through AT-SPI. The actual ARM64 UI displayed x86_64 VibeKits and Remote Office catalog records. Public Linux list simultaneously returned only apps63/90/91, each x64-only download; no architecture-specific alternate artifact metadata. This is not proof of a wrong package installation: no download or installation was attempted.

Real latest tracked main b6dfad936ac75992aeb854f05eb7403d0d6152df AppImage install checks Type2 magic/integrity but has no CPU architecture admission. Isolated candidate adds ELF64/little-endian/current-version and supported machine checks (x86_64=62, AArch64=183), comparing candidate with actual runtime /proc/self/exe before launch/record mutation. DEB path and other platform code unchanged. Constructor runtime injection supports deterministic tests only. No changes to the active761 package, identity, keyring or shared dirty working tree.

101 original ARM64 Dart SDK executed11 architecture contracts successfully, including both CPU matches/mismatches, malformed/truncated/unsupported headers and actual runtime. Actual KemiLinuxMarket integration script then passed wrong first install→matching install→wrong higher-version rejection, verifying no launch or installation-record overwrite on mismatch. Synthetic AppImage fixture was not actually executed; launch callback counted handoff. Initial integration compile failed because a compact tracked constructor did not match the patch template; fixed before any product build or deployment, original receipt retained. Full Flutter tests and packaged GUI delivery remain unverified.

This guard prevents unsafe architecture handoff but DOES NOT complete L07: catalog architecture selection and matching ARM64 artifact publication still required. Do not hide all apps or call a rejection a successful installation. Task candidate source and test receipts: /Volumes/ORICO/kemi-build-cache/kemi-linux-20261025/linux-appimage-architecture-20261031-r1.

G6 follow-up transaction started normally via original simulation: vibekits761-g6-idle-20261031-r1.service; target PID800151/birth26518267, runner0b2c80cd29569a37c70f7553ea042f955dde43d4612563ac2aa4000aac3dc919. Original mature5second/61point whole exact service-cgroup counter, no per-core division, includes reaped children and resource scope audit. Receipt /opt/vibekits-build-arm64-705-20261021/g6-candidate761-20261031-r1/result.json. Read same unit/receipt, never restart on observer timeout. Numeric result alone cannot exclude external physical activity or prove full UI acceptance.

Architecture candidate backed up and remote ref verified at89f528fafc6a866b47d0c7542c524a6d21291237 onlinux/appimage-cpu-admission-20261031 (backup only, no main activation). Follow-up adds existing managed-image open admission; its result and successor commit must be read before claiming that follow-up tested or uploaded.

G6 same transaction reached terminal exit0:305.026483357seconds/61samples, exact service family complete at samples, median15.81300539247267/max29.33253439738475 percent single-core equivalent; numericFAIL (threshold5). PSSpeak838767616bytes, repeated-page RSSsumpeak950104064bytes,164threads/258FD. External physical interaction not independently excluded; this cannot be a full idle acceptance PASS. Later15.0637second per-stable-process diagnostic identified GUI~6.90%, primary relay~2.79%, node~0.53%, WebKitWebProcess~0.53%; not evidence that hidden WebKit is sole CPU cause. Original current761 remains unchanged; no release.

Architecture follow-up tested and remote branch tip verified by successful push edd355907b1925109d8d871015ad5d665297b566, adding managed-image open admission. Full Flutter regression stillpending. Isolated template compile failure did not touch active source or package.

Browser reconciliation found own timed-out overview tab1441804342 at correct KEMI console URL. Exact tab binding again timed out40seconds/reset kernel; cannot claim UI session recovered or close succeeded. No new tabs/mutations after that; retain exact tab for normal-session recovery, never quit shared browser or use cross-profile/credential extraction.

15second thread follow-up: main/platform thread800151 ~8.38% single core, dart:io event handler~0.27%, render llvmpipe threads0 during this sample. This localizes work but does not prove a source root cause. Existing perf launcher is not a usable profiler for vendor kernel5.10.43_wudangstick; perf --version failed with missing matching kernel tools. No OS/kernel/packages changed. Main already has TickerMode on retained pages; do not reimplement that or attribute all CPU to hidden WebKit without evidence.

### 2026-10-31 continued source qualification and actual Flutter regression

Latest main freshly fetched f29b5397271a303de49c52afcfaf48c147905f7b; official latest-main checker prebuild ELIGIBLE for actualSession-ID01a04dde-32ea-7da2-8b77-2991c5e79baf /vibekits.linux开发. Product acceptance remains BLOCK. Task branch conflict-free merged main into8c453442df168c5d7275850f6e7242c143df0a23; relative to main exactly four owned Linux architecture/test/report paths, no other platform source or workflows modified. This is a source backup/freeze, not a new installed package. Latest VibeKits main has Mac/Windows push-triggered workflows; inspect current triggers and retain skip-ci policy before any future main sync, rather than reusing a RustDesk-workflow assumption. No main mutation this round.

Actual original101 Flutter regression transaction architecture-flutter-contract-20261031-r2 finished exit0,13/13 tests,210.908964183seconds total; the test reporter itself spans~1second. Prior direct SSH test was terminated by ssh_wall_time_limit and its original PIDs were explicitly absent before the new durable transaction. Bounded process inspection identified actual native asset build hook compiling sqlite3.c withClang-O3, not a permission/lock/network failure. The new durable test keeps its original exit/log/receipt and did not restart on observer timeout.

Tested exact production-file SHA:c4e1064690f2a246571a62b2f79ddf7374d369fc0695c92ce6ca2f1fd86fb580; architecture helper df25c584a1303ac100152107ee887e6c2f039f63783148dc2d9aefa67d4285da. Branch file SHA independently equals tested bytes.13tests include wrong CPU preserving old installed record, integrity failure, AppImage magic, newer/older version rules, native desktop identity, symlink rejection and failed launch preserving previous registration. This does NOT cover real packaged GUI, full App Center lifecycle or the missing multiarchitecture public catalog.

Existing installed perf binary /usr/lib/linux-tools/5.4.0-216-generic/perf works with this vendor kernel for user-space sampling; no OS/toolchain installation or kernel setting changed.15second process/all-thread sample49Hz cpu-clock:u recorded39samples/no lost;71.79% attributed to stripped libapp.so AOT. Exact Dart functions cannot be resolved because current release has no debug symbols. This is coarse localization, not proof of a specific faulty function. Do not blame WebKit/driver exclusively. Local retained report and identity: linux-appimage-architecture-20261031-r1/perf-report.txt and perf-report-identity.json.

Full objective remains incomplete: latest complete originalSDK/native/GUI build, G6/source-root repair, actual cross-networkKey and roles/settings/model/input flows,101/88 final-package upgrade and both public delivery channels. Apple remains paused by human instruction.

Latest branch report checkpoint ca06d6092c7116da17d2341b94b4a3a56b90bdab pushed and remote ref verified; actual code remains source merge8c453442. Full13test pass and G6 failure recorded in the same cloud report; not main activation or release.

Fresh read-only mature driver receipts: source-main5fcb-linux761-r1.prepare originally projected5334files/85801188bytes, complete in123.29seconds, sourcebase5fcb5c32c27d0a0eed1378a069675673eeaebd52 with attentionTask12b8845bf05affc44a889011223548485e7d3e4d. gui761-latest-main-attention-arm64-r2 was GUI/component-only j8 compile644.41seconds/config35.50, not fullSDK app; current runner differs due later documented runtime overlay. stage761-runtime-arm64-r1 is an OLD FAILED closure transaction (not current accepted runtime), nativeCommit1c7ad0bb1c1522a2cb5275b2af21aae5a08bc4e5. Reuse post-repair owned-runtime-repair761-arm64-r1 and official synchronized-input stage template; never replay the failed stale-SDK seed. Existing full source/SDK/toolchains must remain until new exact freeze/source/native/SDK manifests audited. Evidence latest-build-driver-preflight.json.
