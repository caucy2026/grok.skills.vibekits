# 101五应用编译与发布目标

Session-Name: vibekits.linux开发
Session-ID: 01a04dde-32ea-7da2-8b77-2991c5e79baf

用户最新目标：尽快在101完成VibeKits、KEMI远程办公、KEMI传书、Clash Verge代理、KOffice最新版的编译或正式来源适配、真实运行验收，并全部发布KEMI商城。此前完整Linux要求继续有效；88承担原amd64兼容验证，Apple维持人类暂缓。本文件沿用原三应用文件名以保留引用，当前范围为五应用。

| 应用 | 交付 | 当前事实 |
| --- | --- | --- |
| VibeKits | ARM64完整GUI/原生/原SDK，应用中心安装打开关闭更新、身份和Key延续、中文输入及资源验收，发布KEMI商城 | 763源b5830609、main冻结b6c7ce2f；j8 GUI658.721秒、实际最高8编译进程；完整SDK装配2252.488秒通过；已运行PID1245250，原ID/公钥/授权保持。45秒短诊断CPU中位22.878%仍失败；新增Linux密钥生成前安全存储准入修复已通过5项非交付合同，尚未整包激活/CPU复验，未发布 |
| KEMI远程办公 | 101/88真实连接、中文/倒角/键鼠、实际H264/H265硬编及断连稳定，同一验证产物发布Common和KEMI商城 | 101的465隔离候选运行过，最新完整包、硬编/输入/稳定性仍未完成，不称已发布 |
| KEMI传书 | 最新main ARM64完整构建，中文收发、身份升级及应用中心生命周期，发布KEMI商城及既定Send Common渠道 | 主线14bd88d0，隔离165源码1235项校验通过；Rust1.99.1就绪；工具链和各锁文件依赖预检通过；完整Release R1通过（原生2171.057秒、GUI j8 260.564秒，实际最高8个C++编译进程）。Linux-only原生安全存储修复R2重建通过并真实运行PID1354091；31秒观察CreateCollection/Unlock/Prompt均0，原仿真UI确认39节点/1可见frame/6可见可用按钮。中文收发、最终包装与发布尚未完成；既有商城160是amd64 |
| Clash Verge | 101 ARM64实际运行，保留Mac对应版本的操作逻辑和界面，稳定验收后发布KEMI商城 | 已安装2.5.2-1kemi1；763编译后按原配置恢复过；当前因传书构建内存租约正常暂退，原事务结束自动恢复。首页WebKit高CPU未修复，未发布 |
| KOffice | 核对最新主线和项目原构建路线，在101编译运行、中文和文档功能验收后发布KEMI商城 | 主线2c2eacf8、版本1.0.142，上游b91cb742；干净浅层Git对象及独立源码检出完成，未复制脏上游；已按原脚本顺序成功复放328个补丁、跳过0200–0207共8个Windows专用补丁（源码准备，非产品编译通过）。原生路线要求Qt6.6及C++20，目前101缺Qt6与Flatpak依赖；按项目Ubuntu26原生路线准备独立ARM64 SDK根目录，不替换宿主Ubuntu20/GLIBC。非root隔离能力已验证。尚未编译Linux产品 |

正式工作沿原仿真7634801763和固定SSH指纹；备用入口只作同机恢复。保留原应用身份、用户数据、账号和密钥环。不以单换AOT、手改版本登记或上传成功冒充完整发布。各产品分别核对正确应用记录和资源，传书不得写入远程办公资源。

完成标准：冻结最新源码及Linux增量；真实完整构建与架构/依赖/GLIBC检查；实际安装启动及应用中心入口；核心功能、旧授权延续和稳定性；对应商城/云端公开下载字节、SHA及升级正负验证；自身源码同步、闲置生成物清理和现场恢复。完整要求继续见LINUX_101_REQUIREMENTS_AND_ACCEPTANCE_20261030.md。失败和未完成项保留，不缩减目标或虚报完成。

## 用户2026-10-31新增要求：并行优化与第三方源码备份

所有五项Linux应用均评估多线程：区分编译并发、CPU计算worker和异步IO；保持界面单线程的正确性与即时反馈，不用忙等制造多核占用。报告实际并发、同场景耗时、CPU/内存峰值、界面延迟和失败数；不能把串行阶段报成j8，不能用降低资源保护强行满核。

Clash Verge当前安装包是官方预编译2.5.2加兼容运行时，明确不是本会话源码编译。最新新增目标改为源码构建；已冻结官方tag v2.5.2、提交28f2efc504059b1dc75c793618b775c8e1b2a5f1。官方代码已有Tokio rt-multi-thread，仍需实际运行和性能验证。KOffice的原始引擎冻结b91cb7428e620f5c34c2ff94d7f8ce2a7d494c62。

第三方原始源码、许可、Linux补丁、构建脚本和脱敏验收结果备份到用户指定https://github.com/caucy2026/linux-730；原版与优化版分开追溯。该仓库当前是公开仓库，只放可公开的第三方原始源码及明确授权的对应改动，不复制其他私有产品仓库、账号配置、密钥、订阅或用户数据。原始源码备份不等于源码编译或优化通过；最终编译产物通过实际安装运行与各产品必要门禁后上KEMI商场，验证CDN字节和升级入口。

### 最新第三方源码备份证据

用户指定公开仓库linux-730已保存两个完整原始上游子树，远端提交b236f48d3c8ac058fb68978d11486814a72e03b4，后续状态说明提交ee37ea6ff18824f4535d61689ea5496fdef277f3。Clash原始tree9242c84f7797d083c522e96b47bb65a5fd9be97c；Collabora原始tree3979bebf85a0de73fb519bb4d53f5ad29bfb34a2；远端Git trees API与各原始提交tree均逐一相同。不包含私有KEMI产品源码、凭据或用户数据。源码备份不称优化或商城发布完成。

KOffice独立SDK签名依赖准备R1在产品编译前发现/tmp目录模式未恢复及ARM仓库地址问题，已保留首败；R2恢复官方归档的目录模式，强制/tmp和/var/tmp为1777，使用官方签名ARM ports源，gpgv预检已通过。宿主系统包与账户不变；当前原事务koffice142-qt6-build-deps-r2.service继续对账，不重复发起。

## 本轮真实进展（2026-10-31）

传书165-R2已通过原仿真真实文件选择及中文TLS双向字节验收：入站51B（0496b5fd…349f5）、出站45B（053f8584…14a3d），精确完整SHA与回执在Send自身ACCEPTANCE_PROGRESS.md及101的incoming165-tls-r2/outgoing165-tls-r3/result.json。这里是受控TLS端验收，不冒充跨物理Mac/88或全业务长稳。修正了夹具对标准chunked请求的错误假设，不把夹具失败记为产品故障；已退出的测试TLS私钥均清除。Send普通界面、原数据和进程保留。

KOffice/Clash共用的独立编译SDK已通过：GCC15.2.0、Node22.22.1、QtCore/QtWebEngine6.10.2、WebKitGTK2.52.6、真实C++20 std::format可执行；SDK目录/签名仓库修复后实际完成，宿主库/包与账户不变。原单元koffice142-qt6-build-deps-r2终态passed，1810.194秒（含网络依赖准备，非产品编译时间）。

Clash官方626项完整源已上传，新的耐久事务clash252-source-tools-r1通过原仿真启动，路径/opt/clash-verge-source252-20261031/prepare-source-and-tools-r1/result.json。仍不称Clash原生源码编译成功；必须将Mihomo及service侧车也走相应源码构建，不盲用上游prebuild脚本下载二进制来冒充源码构建。

传书Linux安全存储修复与真实验收报告已按独立index/commit-tree正常快进同步其main：c9dda82ac54bda13f9473c5e6e418716b27432c0，远端ls-remote核验同值；只含app/linux/CMakeLists、三项Linux overlay资源及报告，不移动共享HEAD/index、不更改其他端版本/发布。冷加密存储五阶段真实私有DBus合同2.054秒通过，原始用户密钥环未触碰。整包最终包装与发布仍未完成。

Clash源准备R1在根目录TarInfo形态校验失败、未写源码；R2已按Git对象逐文件校验的规范清单完整准备626项源（7.356秒），随后只读SDK缺少/work挂载点导致工具预检失败，未进行产品编译。两次首败保留。R3仅复用并全量回读已通过的源码，补空的SDK挂载点及磁盘TMPDIR后重新验同一命名空间；不得重复制已封存源码或称为产品源码编译通过。

Clash R3精确命名空间内执行rustup --version会因当前源码rust-toolchain.toml自动同步1.95，超过只读预检30秒限制；已保存终态并清自有子树，没有启动产品编译。R4将只读命名空间预检限制为Node/路径可执行与可写检查，真正Rust1.95安装使用原3600秒有界阶段；复用已验证626项源及原Rustup目录，由官方管理器正常续接，不重新复制源码。当前唯一工具准备单元clash252-source-tools-r4.service，回执/opt/clash-verge-source252-20261031/prepare-tools-r4/result.json；后续先只读对账该原事务，不重复启动。

### 传书最终产物与实际应用中心打开

最终ARM64 AppImage 2.0.5+165：33,405,448B，SHA256 5ed9292c667268535eaf221491100281dc0f16b96e6e3b34c472c67b945ab46f。原仿真取回并核验至/Volumes/ORICO/ios-build/kemi-send/bin/release/KEMI_Send-2.0.5+165-linux-arm64.AppImage；自己的传输暂存copy已移除。最终包51项bundle成员与R2完整Release相等；使用真实生产KemiLinuxInstaller API持久安装，独立桌面启动adapter，四项原有身份摘要均保持。已运行PID1446555/出生32411722，/tmp/.mount_applicFnACIM/kemi_send，APPIMAGE指向/root/.local/share/kemi/app-market/org.kemi.send/165/5ed9292c667268535eaf221491100281dc0f16b96e6e3b34c472c67b945ab46f/application.AppImage。30秒持续进程、可见原生frame已核验；不是通过商城GUI下载安装，不能混称该门禁通过。

在Vibe763真实应用中心中打开传书详情，已识别本机版本高于线上160并禁降级；实点“打开”后原PID1446555到前台，仍仅一个Send GUI实例。该按钮来自AppCard的父Semantics按钮，不是图标image子节点；多行标题用已检索identifier定位，不传入被参数契约禁止的换行。当前“关闭”只是关详情对话框，不冒充已验证关闭应用进程。测试对话框已关闭，原Harness导航已恢复；所有私有WebKit/会话正文未读取，仅按允许范围检查Flutter应用中心子树标题与元数据。

本次Chrome扩展能建/列标签，但规则页内容读取、截图及刷新组合数次超时，未新鲜读取成功规则或提交商城变更；没有改用其他profile/底层浏览器存储绕过。自建标签1441804352已按正常API关闭，用户原新标签1441804303仍保留。多架构发布合同仍需明确，当前未用ARM包覆盖旧x64记录。

Clash工具R4真实网络组件下载到3602秒上限失败，未进行产品编译。R5复用626项源，以Rust官方1.95清单SHA固定5个组件，慢链路缺件经国内镜像取得完全相同字节并由原仿真上传；官方清单SHA821ff14e4c4a1cbe1e8915f35aff0a3fbbdf8d293ad48ab8f31e3b0440c581f9。R5是clash252-source-tools-r5.service，原回执/opt/clash-verge-source252-20261031/prepare-tools-r5/result.json；官方管理器恢复先前部分安装时额外保留rust-docs，因此实际下载6组件，不把5组件缓存齐全称工具链完整。缺的docs归档也已按官方SHA30ef25da7f1bb1953aeb28b152a03cb22d29f597796cc1b7fbca2f61e5930121独立取齐，后续只补完整不可变缓存、不改动正在写的partial，不重启未知结果事务。

### 2026-10-31最终包验收收尾与后续事务

按kemi-storage-cleanup精确清理两份已结束的Send165生成AppDir/解包copy，114文件、192,631,130逻辑B；删除前完整成员SHA/保留原件、当前任务和进程FD/maps/定向lsof均过，删除后原件、最终AppImage及运行PID1446555不变。101可用58,057,814,016→58,250,801,152B，存在并发SDK写入，不能把观测差额全归本次清理。原始源、Git、SDK/工具链、证据及最终包保留；未宣称全盘或所有历史范围清完。

Send45秒资源采样入口因固定cgroup路径无usage计数器而准入/采样失败，没有有效CPU/PSS数据，不报告性能PASS。尝试临时CPUAccounting后已恢复原值；应先核实际ControlGroup/挂载，再沿成熟/proc按PID及出生时间有界采样，不重复固定路径假设。

ClashR5仍为原单元clash252-source-tools-r5.service/worker1466886；六个组件归档已经均有官方SHA匹配的完整缓存，新增docs完整文件用只增不覆盖的原子link存入，未修改其正在下载的partial，也未重启或中断原管理器。需继续只读原回执、PID/阶段和真实日志，不凭缓存齐全称安装完成。

KOffice完整真实Git输入已封成490,610,917B受控传输归档，SHA eca2d7acc67c62fcf2626071f2496421c931c2509efe7bc389a3535b5c84d91c，包含main2c2eacf8与上游b91cb742实际对象/refs/shallow，移除原仓库认证config，仅重建不含凭据的Git配置，不制造提交或父历史。这是用户授权101编译源输入，不上传到公开linux730。15段32MiB串行原仿真传输仍在进行，控制端exec session2115；每段真SHA/字节回执落在KOffice自身canonical-source-part-transfer-r1.json，归档与原Git输入保留，已验证的本地分块临时文件随段移除；远端尚未重组，不能称源码已在101完整就绪或产品已编译。

KOffice15段均已原仿真回读SHA和字节通过，控制端传输完整终态passed。已由原仿真启动koffice142-source-prepare-r1.service，回执/opt/koffice-linux142-20261031/source-prepare-r1/result.json；此阶段在1800秒源准备预算内重组归档、恢复真实Git对象、克隆实际提交/索引并逐文件按Git blob OID物化与读回，尚需单独按原脚本完成patch/verification后才允许产品编译。原Root源码Git和当前正式包不动，不重发已确认15段。

资源采样失败原因已定位到本机hybrid挂载：cgroup2在/sys/fs/cgroup/unified，并非固定/sys/fs/cgroup。已修正为实际/proc/mounts发现路径，并启动新的45秒R2采样单元kemi-send165-final-resource-45s-r2.service，原失败R1保留；数据未完成前不报告CPU值或性能PASS。

### 传书最终165资源阻塞及最小修复候选

真实46.2956秒16点/15区间、整条独立service的cgroup v2 CPU计数（实际unified挂载）得到CPU中位56.3197%、最大65.9196%（单核100%，未除以8），PSS峰235,419,648B、RSS合计峰297,467,904B、线程峰64、FD峰41。临时CPUAccounting并未用于本次R2，R1的改动已恢复。此为短场景实测，不是长稳、极致优化或发布PASS。

三秒同族线程归因总52.329%，主GTK4.906%、Flutter raster3.271%，主要消耗在多个llvmpipe软件渲染worker，已有8线程组，不把它解释成没有多线程或网络故障。旧RotatingWidget负控5个tick导致静态父页面5次重绘。最小Linux-only候选仅在原Transform外加RepaintBoundary，原30fps/角度/动画保留；其他平台返回原Transform。源在Send自身perf-paint-isolation，候选SHA f2b163ca42db1b5d055fab0777d8552d7f0e41d411c2222af432290c6eeb589b，未写入运行源或主线。positiveR1画图断言后因测试debugDefaultTargetPlatformOverride恢复时机触发框架不变量失败，不能记通过；R2移除不必要的平台override，在实际Linux上复验，原失败保留。需读/opt/kemi-send-linux-20261031/.tools/paint-positive-r2/result.json。只有组件正控通过后才准备166完整构建/真升级/同场景CPU对比，不能把paint计数改善冒充CPU已改善。

positiveR2已真实终态passed/exit0，原5次静态父重绘→0次，运行包仍165未改，不把此组件结果转换为CPU百分比改善或发布PASS。下一阶段为带该单一Linux渲染隔离修复的166完整构建。

### 用户新增：Linux错误提示与资源即显（2026-10-31）

远程办公必须定位并修复实际错误提示，不以隐藏警告替代功能修复。各自有App的应用中心列表、图标、安装状态及关于资源须缓存首显、后台异步刷新；离线保留最后有效缓存或随包资源。安装前仍新鲜读取实际版本、架构和包完整性，缓存不能绕过升级门禁。验收记录冷/热入口首帧、网络慢/断网、损坏缓存恢复、重复进入、身份/版本缓存失效，绑定最终包。

当前只读源码已确认远程办公：图片本身有本地文件缓存，但关于页图片URL清单每次等待HTTP；应用中心每次清空loading并等待网络及串行本机安装查询。这两处是即显缺口，不能称全App已完成缓存。

传书166-R1在任何源码改动前系统代理状态预检被拦截，原因是预检未继承自身桌面DBus环境；用精确原进程环境读取系统代理得到none。R2保留同一保护并修正环境后，正常暂退自有Clash仍不足2560MiB初始内存，准入正常BLOCK，未执行格式/测试/构建/源码覆盖；finally已请求按原profile恢复Clash。首败保留，不降低内存门禁，不称166编译通过。

远程办公缓存候选已从最新main eb30bef3冻结：Linux关于页使用完整集合active/backup缓存，图片摘要/解码用有界compute worker；商城目录先内存/磁盘首显再后台刷新，本机安装查询最多4项并发，未知版本及下载前新鲜校验保持。5生产文件分析无问题、7项真实磁盘合同、5项Flutter组件测试通过；尚未ARM整包/真实页面验收，不称秒开或发布PASS。源码备份至rust-desk独立分支linux/cache-first-20261031，远端22241506beea79e3db7003f89d5e96dd86fe7cb9已核验，未覆盖共享HEAD/index或合main。完整报告client/kemi-docs/LINUX_CACHE_FIRST_20261031.md。

当前远程办公service日志仅做脱敏分类：桌面portal设置NotFound、EGL DRI2认证/退出时shader cleanup、GDK输入设备类型断言。未确认哪条对应用户实际弹窗，不隐藏警告冒充修复。Clash原profile进程已由166 finally恢复PID1513215，原可执行SHA保持。Clash锁定依赖获取仍在原R5事务，有官方网络低速重试，不重复启动。KOffice原完整Git源准备已终态PASS，SDK只读预检发现缺ripgrep，先补齐明确工具前置再应用补丁，不盲启产品编译。

### 硬编优先最新续接：R10（2026-10-31）

用户要求继续查以前8帧视频输出记录并必须完成硬编，授权增加交换空间。当前环境/proc/swaps缺失，swapon不存在文件负控返回ENOSYS；没有创建无用交换文件，没有改内核/开机配置。实际生产hwcodec RLIB封装复验：旧单次策略H264/H265均0包；新策略第二次分别15/12ms得到关键帧，解码1280×720且观察到VENC句柄。另发现持续流latency_free误将OMX首帧空输出视作失败，新Linux ARM-only pending判定已通过真实101两项合同，源码备份远端4b7194a9664ee6660bec8a2698f7110088af49d0，仅任务分支未合main。

R7驱动遗漏旧单元名被隔离检查挡住，未启动编译；R8同入口真实旧名负控拒绝/正确单元及MainPID正控通过，校验前移到退出应用前。R9按明确j2实际编译644.898秒后触及原768MiB保护退出，未生成成功包，应用与身份已恢复。保护不降低。

当前唯一在途R10：kemi-office465-native-arm64-omx-release-r10.service，MainPID1627212/出生33814086；producer1627566/出生33816175。原仿真763启动，正式离线metadata exit0，已进入实际原生构建。此次编译同时正常暂退本任务远程办公旧A4以释放内存，已有无外部写入/原ID摘要核验；可用内存实测4,451,778,560字节。结束自动恢复四App并核Vibe身份/授权、Send身份和远程办公ID。不重启、不clean；载体暂退期间仅用已登记同机profile remote_1792635358249998只读原事务。两份权威回执在/opt/kemi-remote-linux-20261025/native465-arm64-omx-release-r10/result.json及native465-omx-r10-resource-lease-r1/result.json。全部用户数据/权限/原包保留。

控制端详报及成熟后续脚本：/Volumes/ORICO/kemi-build-cache/kemi-linux-20261025/omx465-wrapper-policy-hardware-r1/PROGRESS.md。真实整包硬编、Mac画面/输入/稳定性、最终最新主线完整包及Common/KEMI发布尚未完成；不能以组件或在途编译报PASS。Apple保持用户要求的暂缓，不恢复。
