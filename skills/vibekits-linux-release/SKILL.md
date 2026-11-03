---
name: vibekits-linux-release
description: 编译、调试、验收和发布 VibeKits Linux Ubuntu20 amd64/arm64 客户端到 KEMI 商场；不修改 PAD、macOS、Windows 的版本或发布配置。
---

# VibeKits Linux 发布

用户2026-10-22新增验收第一项CPU/GPU跑分、第二项同源clean重编计时，执行时读取[统一验收说明](../vibekits-fleet-compatibility/references/benchmark-clean-build.md)。本轮两台Linux须运行同一VibeKits源码版本的对应架构候选后再发布；旧运行版、语法检查或编译检查不算完整clean构建/运行通过。保留以下全部原门禁。

沿用共享桌面源码和 Linux 原生适配，保持包名 `com.caucy.vibekits`、安装路径 `/opt/vibekits`、既有设备 ID、Key、Keyring 和入房身份。当前事实、失败和待验收项见项目 `docs/acceptance/LINUX_DESKTOP_PARITY_20261015.md`；历史成功不代替当前候选验证。

Linux桌面通用字体、架构/GLIBC、透明窗口、阶段环境与真实验收经验见 [linux-desktop-build-acceptance](../linux-desktop-build-acceptance/SKILL.md)。遇对应问题时读相关引用，沿本项目成熟入口执行，不用通用示例覆盖项目目标。

## 编译与恢复

- 先读项目 AGENTS 和本机 LOCAL-ENVIRONMENT-RULES。共享脏工作树不整体提交、重置或覆盖；冻结本次输入，Linux 版本常量只在隔离构建源更改。
- 远程设备使用 `vibekits-remote-simulator`。对账原 PID、退出回执、日志再恢复，不能因 SSH 工具超时重复构建。仿真失败先核实际控制端桥，不直接断言目标离线。
- 仿真首次信任、运行时通道和构建通道是不同门禁。出现 `consent_pending` 时保留同一请求与原 ID，等待目标端确认；不得换 ID、重复申请或以保存 SSH 冒充仿真已恢复。正式编译、安装、部署和验收必须回到经确认的原仿真 ID 与固定身份。
- 原仿真不可用时，先使用已登记、主机指纹匹配的 SSH/SFTP 或远程办公入口作只读恢复：核对运行 PID/路径、登录会话、Harness 状态、集群配置、网络和原在途单元。对未知结果只读原 unit/PID/出生时间/回执，不能因连接超时重启、重装或重复 clean。系统管理员认证、首次设备信任和应用级授权分别处理；不猜密码、不改 sshd/sudoers/账号、不提取 Key。
- 若设备属于 KEMI 默认通用服务，按 `vibekits-cluster-operations` 的实时服务合同检查 `service-info`、客户端 `cluster.rooms` 与原身份的自动服务分配。通用服务的签名 resolve 不需要后台人工审批；业务房的申请、管理员批准、客户端激活和心跳则各自验证。不能用后台记录、绿色缓存或 SSH 连通代替实际原 ID 的仿真调用。
- 发生链路事故时记录：原仿真 ID、安装指纹或 SSH 指纹摘要、运行版本/路径、原事务/请求 ID、恢复动作和重连后的真实工具调用。恢复后先确认原 ID、`p2p_or_relay`、MCP ready 和新鲜房间心跳，再开始正式构建。
- 本任务受控重启目标 App/native 后，若固定指纹仍匹配、目标本机 MCP 认证入口及时响应且无待批准任务，而远程 MCP 仍超时，先对账原操作，再断开本任务原仿真连接并用同 ID 重连，验证真实工具与页面；`connect` 的缓存 ready 标志不等于调用已恢复。2026-11-01 的765实测此步骤恢复进程查询和两次页面操作；不要由一次恢复推断全部超时根因，也不重启共享控制端或借他人通道。
- Flutter 3.41.9 的 x64 主机不能直接交叉编译 arm64。使用对应架构 Ubuntu20 原生构建环境；ARM 编译成功只算候选，不算 ARM 真机功能通过。
- **新Linux GUI输出目录在退出原App之前，必须先完成原生下载输入准入。** `media_kit_libs_linux` 的 CMake 配置会隐式下载 mimalloc；只有 pub/源码分析通过不代表这一输入已准备。复用项目 `tool/linux_media_native_input_preflight.py`，按真实 package_config 定位插件，校验保留的原始归档声明、大小、SHA256/MD5，并在应用生命周期动作之前 staging；配置动作再经同一 `run_admitted_configure` 入口。不可只挪用GUI成功脚本而遗漏其前置供应步骤，不关闭分配器/校验或覆盖未知目标；原始依赖归档不是可删中间物。插件/依赖升级时先更新声明和正负控，不能永远套旧版本。原失败见项目 `docs/development/incidents/LINUX764_MIMALLOC_PREFLIGHT_RECURRENCE_20261031.md`；实际坏/缺输入必须在退出App与配置回调前拦截。
- 新 Linux 候选复制 relay 后必须通过项目 `tool/linux_readonly_relay_package.py --bundle BUNDLE --sha256 PIN --stage` 完成真实只读协议验证并原子生成 `vibekits-harness-relay-readonly-v1.json`；首次/覆盖启动与正式出包前用同入口 `--verify` 检查。缺失、陈旧或错 SHA 的标记必须在退出当前 App 之前拦截。旧包可保守回退 CLI，但新包不能漏掉既有常驻只读能力；正常文件名不等于标记齐全，不放宽 selector 或哈希检查。细节见项目 `docs/development/incidents/LINUX765_READONLY_MARKER_ASSEMBLY_20261101.md`。
- GUI、Flutter AOT、relay、Node、SDK 和动态库必须来自一致冻结输入。完整复制官方 Harness SDK、兼容 WebKit 资源、内置技能、Node 和 relay，不能仅替换旧包的 AOT。
- 共享Dart新增原生调用时，按`references/linux-incidents.md`的平台通道一致性案例核Linux处理器及最终原生协议；static契约检缺不代替实际wire/授权/身份验收，缺夹具skip不算通过。
- Linux ADB不能漏包：使用项目 `tool/package_linux_adb.py`，为stage脚本提供 `VIBEKITS_ADB_SOURCE_DIRECTORY` 与 `EXPECTED_ADB_SHA256`，随包保留NOTICE/版本及所需库。缺件、错架构/哈希、依赖或Ubuntu20 ABI不满足必须阻断出包。读取 [references/linux-adb-runtime.md](references/linux-adb-runtime.md)；最终包运行能力自检不能用编译/单元测试结果代替。
- 解压页另需完整7-Zip：用 `tool/package_linux_7zip.py` 和stage变量 `VIBEKITS_7ZIP_SOURCE_DIRECTORY`、`EXPECTED_7ZIP_SHA256`、`EXPECTED_7ZIP_VERSION`；MCP ready=true不代表全部页面后端齐全。归档互操作前读 [references/linux-archive-runtime.md](references/linux-archive-runtime.md)，冻结测试源时保留显式必需夹具，不把缺夹具错误归为产品失败。
- 编译前同时同步隔离源 pubspec 与 AppVersion，运行已有 `node tool/verify_app_version.mjs SOURCE`。CLI build-name/build-number不能代替生成资源检查。发布前执行 `python3 scripts/verify-package-version.py FINAL.deb --version VERSION --build CODE --arch amd64`（ARM传arm64）；它流式核对最终包control和Flutter version.json，拒绝684外壳夹带681资源。先用 `--self-test` 验证正例与旧版本/身份/架构负例；不得直接修改旧成品JSON冒充重建。
- 低内存机器串行 Rust/Flutter，单 Cargo job、有界资源、低优先级；保留耐久退出回执。CLI relay 可在隔离源使用 rlib-only crate 类型，不能改共享其他端库产物。OOM 查具体失败，不盲目重跑或去掉安全限制。
- 资源兼容与打包教训见 [references/linux-incidents.md](references/linux-incidents.md)。打包脚本在本技能 scripts，参数为冻结源和精确 relay；运行前核对脚本版本常量与在线版本，不能永远沿用示例683。
- 新版乱码或正常允许后仍pending时，先读[字体与确认入口回退](references/font-and-consent-regressions.md)，核旧版适配和Linux实际编译链路，不反复索取相同授权。

## 真机门禁

- 系统占用、loading与操作响应是重要验收项；执行性能优化或验收时读取 [references/linux-performance-acceptance.md](references/linux-performance-acceptance.md)。必须给出同机同场景、精确候选绑定的优化前后报告；不能用停止App、缩减功能、降低采样范围或把多核归一后的数字当作优化。

- Linux 浏览器输入/控件不可靠时，读取 [references/linux-browser-control.md](references/linux-browser-control.md)，使用已授权独立配置的官方 Firefox 控制路线及随附三轮实收脚本；不反复重试不稳定的 X11 输入，不借用户 profile 或绕过工具拒绝。

- 用真实指针验证 Flutter 和 WebKit 相邻布局；`tool/test_linux_webview_pointer.py` 含拦截负对照。检查从 WebKit 返回 Flutter 后的键盘焦点、计算器实收结果、文件选择/文档打开；不能用 MCP 计算成功代替界面输入通过。
- 验证官方 Harness 启动、扫码 Key 字段绑定/取消/字段切换/覆盖防护；不读取 Key。检查 capability_check 实际响应，目录条目存在不等于工具可执行。
- 覆盖升级后核设备 ID、签名/包身份、既有 Key 和 Keyring、权限、房间心跳；新建用户测试不代替升级。运行用户与管理员可不同，不能迁移运行账户掩盖凭据问题。
- 当前用户 XDG 登录自启，既有实例再启动应聚焦，不开第二实例；不启用 OS 自动登录。测试后恢复原版、关闭自己的通道，保留可用回滚。
- 切换候选前先创建不会冲突的日志/回执，区分构建与包装修订；停止旧候选后的日志创建、进程启动和验收全部放在失败可恢复区。若中断，先对账原PID、真实运行路径和回执，从确切断点恢复，不重复stop或把控制脚本错误归为产品启动失败。
- 普通临时日志24小时、错误警告/崩溃最多7天；验证限量轮转、脱敏、启动清理和空闲资源，正式报告保留摘要与索引。不要把会话正文或客户文件当缓存删除。
- 性能判定沿用当前项目G6：严格空闲完整进程族单核等效CPU中位≤5%；没有有效平台覆盖约定时不能擅自改为“仅诊断”或用多核心归一规避。新包装/部署需绑定最终候选证据，不把旧包样本转记新包通过；日志与临时采样按原期限保留。

## KEMI 商场：明确地址与发布流程

- 商场：**https://kemi.newlinksz.com/kd/**
- API：**https://kemi.newlinksz.com/kd-api**
- 账号正常登录：**https://kemi.newlinksz.com/usercenter**
- 当前官方规则：
  - https://kemi.newlinksz.com/kd/docs/ai-publish
  - https://kemi.newlinksz.com/kd/docs/app-upload
  - https://kemi.newlinksz.com/kd/docs/store-api
  - https://kemi.newlinksz.com/kd/docs/app-self-update/linux

使用 `kemi-market-publish` 并读取其 release-contract；每次读取实时规则，401是认证缺失，不用旧字段猜测生产写入。`.deb` 使用 `os_type=linux`、`linuxpkg`。先按 `(com.caucy.vibekits, linux)` 查重，已有则更新，不复制 Mac53/Windows54 的记录；先核在线 Linux version_code，新二进制必须更高。核实当前 API 如何区分架构，不把 ARM 包覆盖成 amd64 通用下载。

用 `dpkg-shlibdeps` 审计 GUI、全部插件、Node、relay 的实际依赖；本轮最低 Ubuntu20/glibc2.31、测试 WebKitGTK2.38.6，并需 Secret Service 工具。不能只手写几个依赖。记录最终字节数与 SHA256；`file_size` 十进制字符串、`file_size_bytes` 同值整数。上传完成后核开发者记录、无类别过滤 Linux 公共列表/详情、CDN完整下载哈希、旧版有更新/当前无更新、下载包真实安装启动及自更新入口。

ELF审计不覆盖外部命令：`gio/gapplication`必须声明`libglib2.0-bin`，`xdg-open`必须声明`xdg-utils`。生成控制字段后，对**实际最终DEB**运行`python3 scripts/verify-package-runtime-deps.py FINAL.deb`；版本自检PASS或开发机预装这些程序均不能替代此门禁，替代依赖组也不能保证必需命令存在。

介绍只列实测功能，Linux cleaner/未实现工具不能伪称全可用。未过输入/安装等必要门禁时记录具体失败，不把“已编译”当“已发布”。仅更改 Linux 记录；不触发其他端编译或发布。

## 主线备份和收尾

备份可将待整合的精确源码/补丁放在不参与构建的文档目录，标注 pending；不得把未知作者共享修改整体激活到主线。独立 index 从最新 main 构造仅含本任务路径的提交，普通快进推送，禁止 force，不移动同事 HEAD/index。检查远端路径和提交后才称备份成功。

云编译后执行 cloud-build-cleanup；本地清理按 kemi-storage-cleanup，仅删除本任务闲置可再生文件，保留最新包、源码、证据和回滚，不能删除活动 swap/编译目录。
