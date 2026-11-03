# VibeKits Apple发布与Linux全功能验收

## 当前用户优先级（2026-10-18，覆盖后文并行安排）

用户明确要求“先把Linux版本问题系统修正，苹果先暂停”，随后要求按该目标立即行动。当前仅推进Linux，应用中心下载安装/更新/打开/关闭优先，继而完成其余功能及历史回归。Apple相关查询、提交和安装验收暂停，恢复须用户明确要求；原Apple目标和证据保留，不误标完成。暂未有可用automation_update接口，不能声称已修改调度器；后续执行者读取本文件应先遵从本暂停要求。

目标于2026-10-17按用户要求重新建立，状态active，不能以此前其他产品发布或684可启动判定完成。

## 2026-10-18续接新证据（优先于下方历史状态）

- 续接已将Linux SSH inspect最小修复及冻结漏项门禁真正快进到main `c6e1d93161c94cb7a13de2b4c9ffe8c350dab6b1`，父为应用中心修复109d950d。三个路径远端回读SHA一致、共享索引和平台版本未改。既有SSH身份/授权/单飞合同9项通过；源码门禁4项正负对照通过（Linux保留、686漏Linux、身份方法移除、指纹字段移除），均非Linux实际握手证明。首次Node夹具创建受外盘沙箱权限限制，精确正常审批后原测试执行通过，没有换缓存盘或绕过安全拒绝。
- 原Linux3201833792新鲜连接仍500/ssh_identity。备用授权Mac5298938227连接真实connected/sshReady；只读正式App元数据为1.9.0.707/build2707、无MAS receipt，与本机707相同，不能用直发版冒充商城验收，也不为安装较旧商城版覆盖正在使用的707。备用Mac无匹配原Linux指纹的既有known_hosts信任，未尝试SSH/新增密钥/更改信任，原有密码拒绝未绕过。核验完已断开本任务529仿真，未停止该机任何App。

- Apple官方匿名Lookup在US与CN均返回App6809822607、kind=mac-software、VibeKits 1.9.225；US currentVersionReleaseDate=2026-09-24T12:55:25Z。公开页https://apps.apple.com/us/app/vibekits/id6809822607及CN对应页可定位。此为公开版本证据，不证明具体build2226、当前后台审核消息或商城下载/覆盖安装/核心通过；不再仅复述历史等待审核，也不重传/撤回该产品旧提交。
- Chrome控制库存本轮仅MCP Apps，无可控Chrome niu，未读取后台，未借其他profile、Terminal或旁路存储。独立KEMI MAC DESK App6818017961的US匿名Lookup仍0；保留其原监控，不据此推断后台拒绝。
- Linux正式App仍686。原任务强制软件渲染已撤除：原进程maps=swrast_dri，按正式桌面入口正常重启后唯一GUI1282650 maps=iris_dri；关于/解压缩导航实收。没有宣称帧率、提速比例或全功能PASS。
- 应用中心安装后刷新/等待真实版本的修复及三轮73项合同回归已正式合入自有main109d950d2b1f3082f8ffa40202a0489d48d86b66，远端读回一致，其他端版本/工作流/共享index未改。详见LINUX_APP_CENTER_FIX_20261018.md；新Linux二进制未编译部署。
- 仿真500与远程UI输入/窗口绑定故障仍阻塞真机部署。用户明确仅修复入口的临时SSH例外已使用至指纹/公钥核验；现有公钥拒绝，工具禁止代输密码，本机Terminal UI亦被拒绝。未绕过、未新增访问授权或猜密码；未重复启动未知安装。完整两项目标继续active，尚未完成。

## 当轮新鲜事实

- 原仿真3201833792已恢复，主机caucy-MacBookAir、原SSH指纹一致；实际PID985891运行`/opt/vibekits/vibekits`。
- 实际Debian版本`1.9.0~dev.684+2684`，生成version.json为684/2684；GUI SHA256 `d5c959cb20c07e607cd4dee7418b8a134f24f5f30720a70f39447e343e7be28e`，与已发布684-r2记录一致。
- 成熟684安装/键盘计算器/UTF8文档、外向房间仿真和商城交付证据在`LINUX684_ROOM_SIMULATION_20261016.md`；旧`LINUX_DESKTOP_PARITY_20261015.md`顶部683未发布状态已过时，不能当当前结论。
- 当前共享工作树大量同事变更，不整体stage/reset/覆盖。必须按新鲜main及精确路径冻结候选。当前本地HEAD de6f1ce5不是云端最新main证明。
- Apple历史定位：App6809822607，最近已知Store候选1.9.225/2226，提交9ada6dbb-0712-49bc-9082-9dc79e808d57；均待本轮精确后台重读。Chrome niu原门户已读取，但导航时工具明确用户改变Chrome；已停止争抢，尚未取得新的Apple审核状态。

## 必须补证及修复

1. Apple精确提交、App审核/Resolution Center、版本历史与当前构建交叉核验，完整记录新拒绝；健康提交不盲撤回。最小永久Store修复、适用签名/沙盒/隐私清单/核心功能门禁后提交，独立重开确认；最终公开安装验证才完成。
2. Linux以源功能目录和聊天要求生成完整feature/regression矩阵及可执行用例；不可用/未实现功能单列BLOCK，不能删项取PASS。
3. 复验UI指针、WebKit往返焦点、键盘IME/组合键、文件选择和文档；扫码Key字段绑定/取消/编辑防覆盖、不读取Key。
4. Harness真实任务生命周期/工具调用、房间双向仿真、到期撤销与身份权限；684已有外向控制通过不等于入站房间授权同步通过。先核最新源码及安装候选差异再修复。
5. 应用中心下载/完整性/安装/打开/关闭/更新/同旧版禁止，登录自启/单实例、身份Keyring延续，支持架构、日志过期容量脱敏与资源/空闲/长稳。
6. 沿原仿真和隔离构建路线修复复验，精确同步自有main，不影响其他端。ARM现有候选不冒充真机全功能通过。

保留KEMI MAC DESK独立Apple跟踪。当前两目标均未完成，不报告审核中或全功能PASS。

## Linux入站房间授权的当轮定位

源码`cluster_room_agent.dart:_syncMemberSimulationScopes`仍明确仅macOS/Windows，Linux被排除；`harness_simulator_controller.dart`外向私有票据已包含Linux，二者不能混淆。当前共享`RustDeskHarnessShareService`固定探针`--vibekits-harness-protocol`预期`protocol_v4`并检测`roomConsentRenewalSupported`。

新增`tool/verify_linux_room_protocol.py`：1个正例/4个缺能力、旧协议和失败响应反例通过；经仿真上传SHA256 `892d2464f26524cdaf8b1cb27e41951e411db84a014629a992144e7a451cab3e`。在实际684 relay运行返回exit1/BLOCK，原生命令本身exit0、protocol_v3、renewalSupported=null，准确区分不兼容和通道失败。脚本仅输出白名单能力字段，不输出同意记录、对端身份或秘密。

经原仿真通道对实际`/opt/vibekits/vibekits-harness-relay`执行同一只读探针，exit0、ok=true，但实际code为`protocol_v3`，无续期能力字段。只保存此脱敏结论，不保存响应中的既有同意记录或对端身份。因此现阶段不能直接移除Linux平台guard启用入站房间授权，也不能把已有Mac/Windows生产代码直接打入旧Linux relay。下一步沿原native冻结源核对v4实现/补丁和Linux构建支持，构造权限范围、签名、到期、撤销与旧身份连续性回归后再升级。CLI通用`--help`不受支持，已据源码改用正式探针，不据此误判relay失效。

## v4修复输入准备（2026-10-17续接）

自有RustDesk main核实为`2f47635605bf13b9542364701e0eadf0b4a2717a`，Git提交对象已有v4及房间续期实现/回归，不需复制共享未提交核心。冻结client/src、Cargo/锁文件/build.rs/res及公共shared配置归档12032000B，SHA256 `8443904fc2e859c7aa090a834b7c1181c5f068c9c3a8fee15c64559b8462c392`，秘密模式筛查通过。

经原仿真准备独立`/home/claw/vibekits-linux-test/relay-source-v4-20261017`，复制原成功依赖源码而非可变链接，唯一隔离构建调整为rlib-only；回执`native-v4-prepare-20261017.json`状态isolated-source-prepared-not-built。当前可用内存约399404KiB，不启动重型编译，不停止用户应用。需先核原Linux主页区域/A–D适配与冻结v4差异、公共协议准备，避免功能回退；尚未编译部署/测试通过。

控制端旧桥曾返回CONTROL_BRIDGE_UNAVAILABLE，核当前VibeKits PID32171与实例bridge processId一致，按明确桥文件恢复原ID/指纹；先读事务目录/回执均无，才执行准备，未重复启动。浏览器地址中出现非任务ru输入，再次停止共享UI链路，Apple当前审核状态仍未知。

## v4隔离适配与依赖核验

已在上述隔离源补回原Linux只读区域/A–D状态：IPC返回现有home_route_status、relay解码并限制区域/节点值；保留v4及roomConsentRenewalSupported实现。两个修改文件SHA256：ipc.rs `0aa8da8c220da83809ab347d571f4822239110b2102de3683f583fa859ae1c68`；vibekits_harness_relay.rs `80551a6532d79c2c77d7ff70fe8b1a73e8a48dabeb85d09075e0237103d42a63`。原文件逐一SHA校验后保存before-home-route副本，安装目录未改。

公共协议prepare_protocol.py成功；非登录shell未含Cargo路径，已沿原成功工具链改绝对路径`/home/claw/.cargo/bin/cargo`，1.97.1离线locked metadata成功，确认rustdesk包含relay二进制目标（总6目标），不是编译成功。仿真回执exitCode0与所需JSON均核对；第一次管道尾命令掩盖工具缺失后，已加pipefail复验。

新鲜资源：MemAvailable约414MiB、剩余swap约1387MiB、磁盘可用35866865664B，无cargo/rustc进程。合计约1.8GiB低于原成熟5GiB构建资源门槛，未启动重型构建，也未停用户应用。仍需native完整构建/测试及Linux入站同步信任边界验证，不能仅移除平台guard或声称协议已升级。Apple浏览器接口上次明确Local browser use is disabled in Work settings，当前后台状态未知，不以历史等待审核代替。

## 已定位：冻结v4仍缺Linux入站实现

冻结main的ipc.rs虽然无条件报告roomConsentRenewalSupported=true，但房间policy/source IPC枚举与处理、lib.rs的授权证明/运行时模块均仅编译macOS/Windows；ipc/auth.rs的authorize_local_consent_gui_connection也没有Linux实现。因此仅升级v4 relay仍不能满足Linux入站功能，协议字符串不是实现证明。

新增只读`tool/verify_linux_room_native_source.py`并经原仿真对隔离冻结源执行，exitCode1/BLOCK，policy_handler/source_handler/policy_runtime/proof_verifier/linux_gui_authenticator五项全部false；脚本SHA256 `65dc97cd574aee3acacec15c7e72342a882adcad1e468d01be2a4fc92f1a9af3`。不是通道故障。后续必须实现Linux实际GUI调用者认证及完整房间运行时路径，再开启Flutter同步；不能删平台guard、伪造能力标志或放宽为任意同UID进程。源码预检即使PASS也不代替真实IPC拒绝反例/续期撤销/工具调用验收。

独立身份校验候选`tool/linux_room_gui_identity.rs`已通过原仿真在Linux用Rust1.97.1编译运行，4测试通过，SHA256 `25110f6c508924d183757f393744b562a8bdfc0d2aa87b5dee13e95bee6b48a6`。规则为正式`/opt/vibekits` relay/GUI布局、root拥有且祖先不可组/全局写、真实/proc执行inode匹配、同非root运行UID；测试覆盖错误布局、可写权限、非root文件所有者、无效PID/错UID/root与非安装测试程序拒绝。尚未接入IPC，尚未真实GUI正向socket验证，不宣称授权路径已完成；适配器必须使用SO_PEERCRED真实PID/UID而不是请求字段，且不替代人员同意。

后续已将上述校验接入隔离ipc/auth.rs（stream.peer_pid/peer_uid，原连接使用内核凭据），并仅打开房间policy/source相关类型、处理及两个模块的Linux编译条件。隔离源码五项预检已PASS，范围仅源码存在性；并非编译/真实授权通过。耐久回执`/home/claw/vibekits-linux-test/native-v4-linux-room-stage.json`，状态ipc-and-policy-staged-not-built-not-enabled-in-flutter。lib.rs SHA `ac9fbfc3a97766ee0bc69c771f1285871edc36f40fa92265c2831f6b5519990f`、ipc.rs `32c2f36c4e688a5faa27d543a7d598a7467b9160eb88c28ea5f2d2b582246649`、ipc/auth.rs `4f61518608835a8ff194c80a931bbeaee11928121723f52b54bc6ac4edec1278`。待补server/connection.rs房间委托相关Linux条件、Linux GUI method channel及真实IPC正负例，Flutter入口保持未启用，生产安装未动。

已继续在同一隔离源打开server/connection.rs房间Pending字段、初始化、validate_connection、loopback绑定、LoginResponse委托ID、accept及相反unsupported分支的Linux条件，同时打开relay断开destroy路径；没有全局替换其他Mac/Windows条件。连接文件SHA `021dedba2ed95d3d54fde8bb5f83839246232b2d96076baea11d8ea518a6d622`，relay SHA `b0e155ea4a23489e2fb257bc7cd3ed5de10dc29648ec59cf02dd000c1f1c1eb4`。耐久回执native-v4-linux-connection-stage.json。尚需Linux独立socket listener与GUI方法通道、完整编译和运行时验证；不能据源码分支存在宣称连接已通过。

Linux专用监听已接入隔离源：server.rs启动原`_person_consent`监听（仅Harness命名空间），沿现有0600 socket/安全父目录；Linux消息白名单仅VibekitsRoomPolicyRequest和VibekitsRoomSourceRequest，每请求走真实GUI校验，其余消息不执行并断开。不将尚未移植的人员同意提交接入此路径。server.rs SHA `6090aedac493b19bd756c7325178512f47d1fa0fe1ac2c1d0b31a5428216e992`，ipc.rs SHA `419f4d96e60e46628bae3debd31a57624521d09acb4166ba9c0ad85d2056f780`，耐久回执native-v4-linux-listener-stage.json；尚未编译或启动监听。原Linux GUI channel目前只接收两类人员决定，仍需补房间专用方法、帧大小/回复类型验证及Flutter平台入口。

GUI channel已新增installRoomSimulationPolicy/queryRoomSimulationSource两方法：精确字段数量/类型、端口范围与32147固定目标、delegation/tool格式、JSON codec构造帧，按请求核回复类型；原人员决定4KiB上限不变，房间请求24KiB/回复64KiB有界，沿原内核relay身份校验。C++源码SHA `c0d59d522942093195e79fb3a69dbd47b62b77baca64dc5401d590d5bed44e34`经原仿真上传，Linux既有clang++-10/Flutter/GTK头文件`-std=c++17 -Wall -Wextra -Werror -fsyntax-only`通过（exit0，stderr空）。Dart service两个桥接方法允许Linux，analyze无问题；cluster_room_agent自动同步平台guard暂保留，避免旧安装684错误启用。尚需完整native/GUI组合构建、方法运行和真实授权正负例后再打开自动同步，不把语法检查当完整构建。

已在原Linux机建立独立room-proof-tests-v4-20261017薄适配器，直接复制冻结harness_room_delegated_grant.rs与原fixtures（不改生产模块逻辑）；仅将hbb_common的base64/sha2公开重导出，复用原cargo-home离线缓存，sha2对齐生产锁0.10.8、ring0.17.14。单job、1GiB地址上限编译测试exit0，10项全部通过：真实P256向量、无管理员成员票据、签名/公钥pin/上下文/到期拒绝、重复/未知/浮点/非规范JSON拒绝、工具/端口/来源限制、并发容量、断开销毁和跨房间取消隔离。日志与test.exit保存在该独立目录；不代替完整runtime/IPC/GUI验收。曾遇Bad packet length/MAC错误，原connection_status显示同ID/原指纹；核cargo/rustc无进程且无锁/产物后才重试，无重复在途构建。

该薄适配器继续加入未修改harness_room_delegated_runtime.rs，所有真实Config/身份/授权变更入口用panic阻断，确保纯策略测试不能意外碰用户授权。Linux编译执行14项全通过（policy-test.exit=0）：新增same-scope live续期只延长到期、任何授权字段变化拒绝续期、停用范围不可复活、工具目录32/33/512正例及513/空/重复/非法/超长反例。适配器依赖来自已有缓存，不代表生产整包已编译通过。

完整原生cargo check已实际执行：原cargo-home、独立relay-target-v4-20261017、--locked --offline、单job、nice15、1GiB地址空间限制与90秒timeout。首段编译至ring0.17.14等依赖，未见源码error，exit124是所设有界窗口到期而非检查通过；耐久native-v4-check.log/native-v4-check.exit在独立根。应复用同一target增量继续而不是重建或上调内存限制；先确认该段进程终止。生产程序未修改。

第二段增量检查至openssl/protobuf/gstreamer/rustls等依赖，exit124仍为90秒窗口到期。确认cargo/rustc均已退出后，已启动同一target的连续有界检查：脚本vibekits-v4-native-check.sh SHA `9286cfbb6de6b21a2111980cfe9baa3003cf19e23711a235f36a884e54409f00`，PID2828946 bash已ps核实。单job/nice15/1GiB限制不变，增加flock防并发和900秒总上限；日志native-v4-check-continuous.log、退出码native-v4-check-continuous.exit、PID文件在独立根。后续先核该PID/子进程/回执，不能因界面等待重复启动。此时尚未得完成结果。正常CUA getState再次明确本地浏览器使用被Work设置关闭，Apple新状态仍无法核实，未换原生Chrome或其他旁路。

续接新鲜ps核PID2828946仍S、elapsed01:53，日志已推进gtk/protobuf/tokio等依赖，无退出回执，属于已核实运行等待，不是构建成功。平台预检扩大到11项（含连接Pending/期间复核/绑定/委托ID/断开destroy/私有监听），同一隔离源exit0/PASS；新脚本SHA `3fe450fedcf9e7bfde043578ab4c4e22ec03c6344cd0c92750082083d30c7310`，仅源码平台覆盖，不替代编译或运行验收。

该检查随后exit101：gio rustc在1GiB虚拟地址上限下allocation failed/SIGABRT，不是源码错误，未证实系统OOM。保留原日志，核无cargo/rustc后将仅虚拟地址上限调至2GiB，并用/usr/bin/time -v记录真实峰值，单job/nice15仍保留。新PID2837426已ps核，continuous-02.log/exit/pid独立保存；elapsed01:04时已越过gio进入hbb_common/bindgen等检查。原依赖message.proto已确认bytes harness_room_delegation=19、response delegation_id=4，不是漏协议字段。尚无整包类型检查完成结果。

独立外盘Flutter冻结源另执行linux_app_center_test和harness_linux_webkit_compatibility_test，两项通过（平台override规则/资源选择逻辑，不是真机安装）；现有Key扫码Node回归8项通过，含主动破坏edit guard的负对照、取消/编辑/移除/只读/错request/非法输入及一次性字段绑定，不输出任何真实Key。不得据此替代真实Linux扫码、应用中心下载覆盖安装和更新验收。

续接实际stat确认/、/opt、/opt/vibekits及正式GUI/relay均uid0、755、非符号链接，符合候选身份校验的安装前提。连续检查02的PID2837426在elapsed03:03仍运行，编译继续推进，不是完成。已从冻结Git归档对比导出9文件原生改动补丁，经原仿真回收并保存`docs/acceptance/vibekits-linux-native-v4-pending-20261017.patch`，17677B SHA `fca674e306b2fa4ae7c2cac76a6a6f31d7ed48ac3c883283d0f367530e3d226f`；base2f476356。包含隔离CLI rlib调整，必须人工按构建角色审阅，不能直接应用到其他端。补丁明确pending，未同步激活生产main或宣称已验收。

另在同一外盘冻结Flutter源执行room_delegated_mcp_gate_test、cluster_room_delegation_verifier_test、cluster_room_simulation_protocol_test、cluster_room_simulation_journal_test，exit0、47测试全部通过。覆盖本地loopback委托执行门禁、原生证据匹配、签名固定向量、并发单飞、策略镜像失败不ready、历史记录到期修剪/伪造保留/容量保护；合成数据与测试服务，不计为Linux真实房间设备互通。continuous-02 PID2837426在elapsed04:48仍运行，未有退出回执，继续同一检查，不重启。

待验收补丁/工具六文件及manifest已备份自有GitHub main文档命名空间`docs/acceptance/linux-v4-pending-20261017`，提交`c4316175f0eed9c54081283962c59e8bd656407a`，逐文件远端回读SHA通过，未激活生产源/改共享index。补丁在精确归档基线的外盘独立目录git apply --check通过。

continuous-02实际exit101，已完成依赖检查进入rustdesk主库；日志memory allocation8519696B failed、SIGABRT，无源码error，/usr/bin/time最大RSS1238624KiB，虚拟上限2GiB。保留原失败，不把它当系统OOM或源码修复。新鲜MemAvailable1915MiB、swap仅76MiB；不增加全系统swap/停用户App。核无cargo/rustc后关闭检查增量状态CARGO_INCREMENTAL=0、仅将进程虚拟上限调3GiB，同target单job/nice15继续，脚本SHA `26af783d883adb3c66da31fdc36d165324d7a69078e2d4922df830799be031ce`；PID2860751已ps核，continuous-03.log/exit/pid待跟踪，仍未类型检查通过。

continuous-03已终止且exit0：完整native cargo check通过，59.04秒、峰值RSS1230916KiB。不是发布二进制或运行时授权验收。用户新要求应用中心与Mac一致并合入最新main，已切换该直接目标；修复与证据见LINUX_APP_CENTER_MAC_PARITY_20261017.md及主线合并回执。保留原Apple目标和KEMI MAC DESK跟踪，不把本次应用中心源码合并当作公开发布完成。

## 最新主线Linux候选输入

应用中心已正常快进合入main c88938228ca2b4b2d45137e1712939f113faa20d，九个精确路径均远端回读通过，主线pubspec仍573/2573未影响其他端。已从该精确Git树冻结2911文件：2820本地文件逐个Git blob哈希相符直接复用，91项由正常GitHub API读取并核SHA；LFS仅允许与指针OID相符的现存字节。归档36738099B、SHA `f5e746e2f7be3b6a5989fababa3243005771f6840154731b496522e3a43b0f63`。主线当前不跟踪Linux Runner，必须按成熟Linux适配逐项合并，不整体覆盖新版共同Dart逻辑。

经原仿真ID/指纹上传，远端哈希一致。首次准备SSH返回Bad packet/MAC错误；核原身份并只读确认目录及回执均不存在后，执行一次成功准备。独立源`/home/claw/vibekits-linux-test/source-main-c889-685`、回执source-main-c889-685-prepare.json，2911文件核验，状态exact-main-prepared-linux-adaptation-pending；尚未改版本或开始GUI编译，正式684未动。计划仅隔离源升685/2685，先合Linux适配、锁依赖与冻结输入门禁。官方整仓下载被精确终止（不完整source.tar.gz不能使用）；另一次HTTPS Git归档已完成，未被当作本次验收快照。不得因末尾ls/shasum exit0将已终止下载判为完整。

已逐项合并30文件Linux增量（原主线服务器区域/usage contract等已存在，不重放旧patch），overlay167674B SHA `b971753f8d35fc25ff5c37cc79d0a74639e929167f41069a358dfa166549843a`，逐文件核原主线/新哈希；包括已审阅WebView/输入/SecretService/票据平台适配及用户要求Key扫码/右下退出。仅隔离源pubspec/AppVersion升685/2685，锁定依赖offline/enforce-lockfile通过，版本和冻结资源门禁通过。未开始最终GUI打包/安装。

首次Linux专项测试因SQLite3默认GitHub资源下载连接关闭而在native assets阶段停止，保留首败app-center-linux685-tests.log；按源码固定官方hash核原684缓存libsqlite3.so并供原hook重新验hash复用，不换系统库、不升依赖。测试隔离改为可注入共享安装登记，全部使用合成包和独立临时根。r2真实Linux四测试文件18项全部通过、0skip、exit0；耐久app-center-linux685-tests-r2.log/exit在任务根。原12项Linux专属AppImage回归这次真实执行，不把Mac skip算通过。仍需最终native release二进制、GUI完整包及真实窗口下载安装/打开更新验收，不以18测试代替全功能通过。

应用中心测试隔离修正及Linux18通过证据已进一步正常快进到main `0e4f7805b029ad885d7aac7f87b7337767705124`，三文件远端回读通过，不改其他端版本或工作流。

## GUI组件构建在途

新鲜资源仅约1892MiB RAM可用+61MiB空闲swap，低于原native Release成熟5GiB门槛，不降低该Release门槛、不停用户App。独立GUI组件沿原Flutter Release入口编译（不是完整可发布包）：Ninja compile/link池各1、nice10/idle I/O、flock防重复，未并行Rust编译；脚本build-vibekits-linux-gui-685.sh SHA `bb63cb5b39826c623a5f3fa683d696141721c70f8448205d7836738580b3935f`。PID2939539在elapsed01:59仍SN，日志gui-main-c889-685.log为Building Linux application，无exit回执；先核同一PID/退出回执，不重复启动。最终组装必须另有合格native Release及运行时闭包，不能将GUI成功当完整通过。

同一main的native源码/运行脚本正在独立冻结到本机main-c8893822/verified-native-source；采集会话31172尚无完成回执，不能使用半成品或重复启动。该补充用于正式组装脚本/内置技能完整性，不修改正在编译的GUI源。

## GUI组件完成与SDK门禁

GUI构建已实际exit0（3:03.72，峰值RSS1381760KiB），生成version.json=1.9.0-dev.685/2685；GUI SHA `a67b61f45adfe2fe32fed5c5183c1b657f87681b21e3b08f763adede185f753c`，AOT SHA `d27d3a8f0d48f73a42e4d7306f50cb55210baf0c8340341c13967ca86629d437`。Ninja日志证实16个compile规则应用单并发pool，不仅是环境变量。当前仅组件，不是最终DEB或正式安装。

原native全目录补充失败对象定位为不相关Windows geoip.dat（17MiB），未反复重下；缩小native/harness范围并逐文件复验已有缓存，最终88源文件归档6407792B SHA `4b64603f4db4e4ed9bf69082c21b85c4b51fff72a90e77eb77d148fdffaf431a`，仿真上传并远端重算一致。源范围包含PAD历史源资料，运行时只选择顶层helper及builtin-skills，不将PAD源归档打入Linux包。

独立runtime-stage-main-c889-685已按成熟路线复制完整官方SDK rc.2（不排除依赖build目录）、Node22.19.0、同源helper/技能，验证SDK/Node实际版本、compat前端存在及链接不逃逸stage。运行原test_harness_bundled_skill、verify_harness_bundled_inputs、test_harness_native_flock全部exit0，真实flock/争抢/释放PASS；日志runtime-skill-685.log、runtime-inputs-685.json、runtime-flock-685.log。stage尚含顶层源测试副本，最终组装须只带生产helper，未作为正式包发布或启动。

native Release资源仍未满足：新鲜RAM可用1989MiB+swap空闲13MiB，sudo -n明确需要密码（uid1001），无免密管理员授权；没有降低原5GiB门槛、盲编Release或停用户App。已向用户提出一次具体新增系统资源决策：最多4GB任务临时swap，结束确认不占用再清理；不是重复普通发布授权。该决定未返回前继续独立验证，不称全目标完成。

## 实际Linux安装与公开商城只读闭环

新探针tool/probe_linux_store_installations.dart通过候选生产KemiLinuxMarket/LinuxStoreApplications解析实际安装，exit0：VibeKits2684、Send160、Remote452均installed=true/managedResolved=true。不输出真实路径、Key或用户内容，不启动程序。此前仅dpkg查询找不到AppImage不代表未安装，已由真实API证实。

test/manual_linux_app_center_live_test.dart显式VIBEKITS_LINUX_MARKET_LIVE=1，在实际Linux调用生产AppCenterService.load、真实匿名平台列表及真实本地登记：Linux筛选/目标唯一、Send本地160=商城160、Remote本地452=商城452、isApplicationInstalled=true、canDownload=false均通过，1测试exit0。未下载/打开/关闭应用。首轮测试设施误写loadCatalog（不存在方法）导致编译失败，未进入HTTP断言，已改实际load API并分析后复验；首败app-center-linux685-live.log保留，成功r2.log/r2.exit独立保存，不归因产品或网络。此只读真实联调不替代安装包点击与升级。

## 阻塞审计（未完成，不是用户暂停）

再次新鲜核验：Linux无cargo/rustc在途，GUI构建exit0；MemAvailable1956MiB、SwapFree约1MiB，仍低于原native Release5GiB门槛，先前sudo -n已确认需管理员认证。4GB任务临时swap的具体新增授权仍未收到回复，不擅自系统写入或中断其他应用。正常CUA getState仍明确Local browser use is disabled in Work settings，无可控浏览器；不转原生Chrome/CDP/其他profile绕过。

两个关口已连续多轮重复。当前可独立推进的候选源码、18Linux专项、原生类型/策略回归、GUI组件、SDK/flock及真实商城版本解析已完成；下一必需步骤为合格native Release/完整安装验收与Apple精确后台核验，均受上述外部条件约束。全目标保持原范围但标记blocked，不能标complete、审核中或已发布；收到临时资源决定并获得正常系统授权、或可用资源恢复后继续Linux，浏览器正常权限恢复后继续Apple。保留正式684、候选685、源码/证据/回退及独立KEMI MAC DESK跟踪，不清当前环境或强行发布。

## 用户批准临时资源后的续接

用户完成修正后的认证：r3.exit=0，4GiB任务swap回执active-task-only，fstabModified=false/existingSwapModified=false；实时可用RAM+swap5986684KiB，超过原5GiB门槛，无cargo/rustc并发。第二次失败确切原因不是用户密码错误：su已成功，但sudo报a terminal is required；r3使用su --pty保留正常控制终端后由用户亲自完成两级认证。r3脚本SHA d9fc8c773d53a6d20cdace6d4498fd1922030ffcde959ff96c15d0a9e2616d58，独立远端核哈希相符后执行；此前upload_checksum_mismatch不等于实际字节损坏，已独立复核而非盲重传/执行。

原生Release已实际启动：native-v4-release-685-launch.json记录PID3169623，42秒时ps为SNs/bash，日志通过七项冻结源哈希并推进libc/proc-macro2/serde等Release依赖，无exit回执；这是在途构建，不是完成。保持同一target/单job/低优先级与4.7GiB虚拟上限，不重复启动。结束后必须先核本任务swap实际占用和可安全回收条件，再仅swapoff并移除本任务文件，不能删除活动swap或动原有交换空间。苹果listBrowsers仍明确禁用，当前后台状态未知。

后续已恢复正确远程桌面入口：核对正式源码core_main的--connect分发后，执行正式/Applications/KEMI远程办公.app可执行文件 --connect 130889323，退出0；CUA窗口标题与截图均确认130889323@caucy-macbookair，看到本任务专属caucy认证终端。不要继续使用不生效的主页AX setValue或猜坐标连接。尝试在该已授权提示输入既有管理员密码时，工具明确安全拒绝，要求由用户亲自输入；禁止换工具、命令行、文件或间接方式绕过。用户已获精确设备和前台窗口说明，无需重新提供密码。

最新仿真回执：auth.exit和swap成功回执均不存在，MemAvailable1713432KiB、SwapFree97312KiB、rustc0，认证尚未完成，Release未启动。原生构建入口vibekits-native-v4-release-685.sh已本地bash -n通过并上传原仿真路径，2156字节、SHA256 921dd06da6e220c5ef0b210ce915e6c162b82fec7b81f889ac1ddd047495eda5。保持原成熟5GiB门槛、单job/低优先级/原配置注入脚本/locked-offline，新增7个冻结源哈希断言、独立flock及退出回执，不重复修补源或沿用旧v3二进制。待用户正常完成认证后，先对账同一swap回执再启动；上传脚本不等于已编译。正常listBrowsers仍返回Local browser use is disabled in Work settings，不能声称Apple后台已核验。

续接管理员认证启动器已沿原仿真上传并执行，SHA256 56ab593df114a274245562f0472a51c4a2ff0c3716976e03b179ac2e182470db，远端/tmp/vibekits-simulator-3201833792/vibekits-native-v4-swap-auth.py。耐久native-v4-swap-auth.json记录launcherPid3013760，最新ps确认gnome-terminal存活，无auth.exit、无swap成功回执；不重复启动。当前内存1910116KiB+空闲swap62772KiB仍不足5GiB，Release未运行。

备用远程桌面发生可重现观察/输入不一致：主页AX输入显示130889323，但同轮正式App截图实际仍238638760；setValue、可见坐标输入都未改变截图。点击连接进入238638760，按截图Linux卡片坐标双击却进入372799163。仅读取窗口标题核身份，没有读取上述远端画面、没有输入凭据；不能凭AX的字段文本声称已连接Linux或已输入密码。停止继续猜坐标，不将此等同Linux离线。正常管理员认证和Apple正常浏览器访问两处仍未恢复；保留原事务和精确入口，不绕过凭据保护或浏览器禁用。

用户已明确批准最多4GB本任务临时swap，原“未获该批准”的阻塞已失效，不再重复询问。新鲜仿真connection_status确认3201833792、原主机指纹、direct通道且SSH/MCP就绪。实时MemAvailable1960356KiB、SwapFree28336KiB，磁盘空闲31454183424字节，rustc进程0；目标native-v4-build-20261017.swap不存在且非符号链接，caucy UID1000。限定脚本已上传到/tmp/vibekits-simulator-3201833792/vibekits-native-v4-task-swap.py，1761字节，SHA256 dd1027ad46309d4cc788d1f4fccb9c97fcf88d64295b6c84d044ab07178a1e16；语法检查通过。脚本要求正常root认证、精确新文件、4GiB全分配/root0600，拒绝已有事务，不修改fstab或既有swap。尚未执行、未创建swap，也未启动Release；后续沿既有caucy正常管理员认证，不将凭据写入命令或报告。

恢复入口只读复核：实际远程办公PID1980675位于/tmp/.mount_applicoDKMjg/rustdesk，其--vibekits-harness-status返回routingId3201833792/callable=true/state=registered。之前假设共享安装current路径不存在，不能再使用该猜测路径。未停止原版或读取对端画面。Apple正常CUA仍明确Local browser use is disabled in Work settings；本轮未进入后台，不声明最新审核状态。苹果技能及原历史身份记录已重读，不重复上传或撤回健康提交。
