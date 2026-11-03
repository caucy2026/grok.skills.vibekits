# 101（用户亦称110）近期问题修复与验收

Session-Name: vibekits.linux开发
Session-ID: 01a04dde-32ea-7da2-8b77-2991c5e79baf
日期/时区：2026-10-26，Asia/Shanghai。

## 身份与交付条件

用户本线程明确110就是原101：mp730-156、仿真5713793648、当前192.168.3.101、Ubuntu20 ARM64/8逻辑核。88为caucy-MacBookAir/3201833792/amd64，用于同源兼容对照。只用原仿真与指纹；载体维护暂停时用原登记同机保存SSH只读对账，正式执行回到原仿真。保留原App/身份/授权/配置/工具链与必要证据，不靠用户代操作。

当前RemoteOffice自有main=7d938a4f819b34b34deb6a9a8ebf3d0360faf191；453 ARM原生e8cd3c81…、原453 AOT3b85a5cc…；453 x64包ec4cb37d…；新454字体/倒角GUI尚在构建，不将旧453截图或测试记到454。VibeKits实际757，秒表候选代码已在最新main之上的独立备份分支6e6871af9b2f65486a42f510da7ff3467825970a，尚未编译/安装；不得把它称运行中的新版。

## 近期问题、原因与当前结论

| 编号 | 产品/问题 | 依据与原因 | 当前状态 |
|---|---|---|---|
| RO-01 | 101远程办公中文方框 | 真实453顶部40像素导航见“应用”“关于”方框；系统Noto CJK存在，包缺随包CJK和Linux主题绑定，ARM3.41 fallback未生效 | 补齐Regular/Bold/OFL与启动FontLoader、亮暗Theme，仅Linux打包；实际字体加载/重试/中粗字形栅格测试已通过，454 GUI进行中 |
| RO-02 | 窗口倒角黑色/不透明 | 实际3.41 FlView默认黑底；原代码仅GTK RGBA/GL alpha，window_manager只改CSS | 主/子窗口补透明FlView底面，dlsym兼容88旧3.24接口缺失；最终ARGB角像素待验 |
| RO-03 | 要求默认真实H264/H265硬编 | ARM构建未含hwcodec；厂商VENC及FFmpeg库要求GLIBC2.33/2.34，Ubuntu20不能加载；默认开关语义本已启用 | 独立2.35加载路径已实测通过；真正硬编仍BLOCK，继续接口/关键帧/会话，不把软件x264/x265或注册名称计为硬编 |
| VK-01 | 秒表不顺滑/后台占用 | 10ms Timer整页setState，100刻度重画且不受TickerMode抑制 | Linux vsync/局部更新/静态刻度缓存完成；旧实现负控与13项组件测试通过；最终包帧/CPU待验 |
| VK-02 | 点击页面被旧设置切回 | 迟到持久化设置覆盖真实用户选择 | 旧失败/修后真实MainShell Widget对照通过，独立分支6e6bccd1…；最终包待验 |
| VK-03 | 低内存/响应与高CPU | 757 G6单核等效CPU中位14.5071%，755为14.3008%，未过≤5% | FAIL；不得除以8或用编译提速冒充运行优化，需最终包同场景复测 |
| VK-04 | 最新主线/应用中心/完整功能 | 新main新增账号SSE/侧栏等运行时变化，现757不是最新完整main；按钮20次响应、真实安装更新等缺完整证据 | 保留原完整目标，不能以本次秒表测试结束全功能验收 |
| REL-01 | 双架构商城/Common | 原记录Linux单URL，当前App91仍x64 452；新453双架构未正式发布 | 未发布；必须同App身份兼容分发，禁ARM覆盖x64 |

不恢复用户已暂停/取消的Apple工作。历史报告中的“当前”以原日期与精确SHA理解，不覆盖本表新事实。

## 本次验收顺序与证据

| 顺序 | 实际动作/断言 | 通过所需证据 | 当前结果 |
|---|---|---|---|
| 1 | 版本/架构/完整包/来源 | source/包/运行ELF+AOT哈希、CLI及version.json一致，非拼包 | 453两架构已有；454待终态 |
| 2 | 中文显示 | 中文应用/关于/设置、亮暗主题、CM；字形不同、粗细真实；仅自有公开区域像素 | 修复前已见方框；FontLoader真实栅格测试与454窗口待验 |
| 3 | 四角透明 | 正常/最大化/恢复，四个自有窗口角的ARGB alpha与内部不透明，子窗口同验；不截桌面再裁剪 | 待454 |
| 4 | 真正硬编 | 兼容库可加载，H264和H265硬件编码器实际初始化并产关键帧；自有远控会话成功解码/画面和输入，记录实际后端，不读取其他人画面 | 当前ABI+模块失败，BLOCK |
| 5 | 秒表 | 开始/暂停/复位/20次计次/全部计次；三尺寸不溢出；可见失焦持续、隐藏不刷新但计时不断、返回准确；至少30秒帧耗时p50/p95/max、20次输入响应、静态缓存真实发挥 | 原失败负控＋13组件PASS；最终包测量未完成 |
| 6 | 界面与键盘/文件 | 自有测试内容，键盘组合键/文件选择/文档按钮及保存关闭，正常前台显示 | 待最新整包，不复读用户正文 |
| 7 | Harness/房间/仿真 | 真实原ID工具调用、扫码Key字段/取消/覆盖保护、房间心跳、原授权设备双向窄调用、退出自身通道 | 原身份与本轮101通道已核，完整功能待补 |
| 8 | 应用中心 | 同ID最新版、缓存状态立即反馈、下载SHA/字节/架构、安装、打开到前台、关闭、升级保原数据；旧有更新新无更新 | 当前通用缺项保留，不计源码回归为按钮PASS |
| 9 | 身份与启动 | 已授权旧版→覆盖新版→启动/原操作，ID/Key/账号/权限无需重置，XDG自启不重复实例 | 保留既有有效证据，仅对新候选补验 |
| 10 | 资源/稳定/日志与交付 | 最终SHA完整家族≥300秒61点、单核等效中位≤5%，20交互p95反馈≤100ms/页面≤300ms；日志脱敏轮转、无持续增长；公开包真实获取安装 | G6仍FAIL，未达发布条件 |

每项只记真实已完成的证据与失败，失败保首证据并修复复验。相同动作合并，已有效证据不重复；用户此次没有要求恢复旧100轮全舰队任务。单元绿测、编译成功、前台出现和上传成功分别记录，不替代最终功能或发布。

## 正在执行的事务

- RemoteOffice454：`kemi-font454-gui-arm64-r5.service`，worker1598781；精确回执`/opt/kemi-remote-linux-20261025/font454-arm64-gui-r5/result.json`。官方环境/协议/冻结桥接已通过，进入真实字形测试，GUI使用Ninja-j8。768MiB MemAvailable和1GiB磁盘保护保持；finally恢复VibeKits757。不得因观察超时重建/重复clean。
- 秒表非交付对照：`stopwatch-frame-contract-r3/result.json`终态passed，13测试exit0；167.018秒包含Flutter编译和测试，不是响应耗时或性能提升百分比。
- 原始日志按普通24小时/错误7天保留，正式脱敏结论与索引长期保存；本表不是所有项目完成的声明。

正式字形测试回执：font454-arm64-gui-r5/result.json 的 font-glyph-testsExit=0、40.226952983秒；WARN缺字体来自预先声明的缺资源负控，随后INFO字体就绪且不同中文词/400与700字重像素均不同。尚待最终454实际窗口，不把栅格夹具当新包截图。

## 2026-10-26 最新真实运行证据

454 GUI已在原101前台运行：PID1608046、出生tick35670024、窗口35651587；完整原生/AOT已实读绑定e8cd3c81…/0bc33e0c…，不是旧包。两次新鲜数字IPC证实旧453 VideoConnCount=0、ScreenCaptureCount=0且无未知TCP后正常退出，保留旧镜像与本地私有配置备份。新旧设备ID、公钥摘要一致，两份授权配置逐字节相同。VibeKits757已恢复PID1601431，不改TCC/凭据或用户配置。

独立四角取样通过“非不透明黑角”断言：窗口深度32，四个12x12角各63个半透明像素，最小alpha上角6/下角7（原有阴影），内部公开工具栏12x12全部alpha255。该结果是实际自有窗口pixmap数值，没有先截桌面再裁剪，也没有拍其他窗口。尚待最大化/恢复和子窗口对应项，不宣称整项全部完成。

实际中文公开条600x40已取得：`font454-toolbar-after-r1/toolbar.png`，3844字节，SHA256 cc09ed5d6c3432fe7759f6a3a8fce5b6de25457ed67501b01b563a9751796d62；只含顶部公开导航，不含设备ID/密码/正文。该图已由执行者实际查看，确认“应用”“关于”为可读中文，非方框；Home/Settings仍为原英文标签，未冒称整页中文翻译完成。只对这块公开导航标显示PASS，设置/CM等剩余项继续验收。

完整GUI构建253.110937831秒、官方准备16.082654549秒、字形测试40.226952983秒，总事务320.720008401秒；GUI Ninja配置j8，Rust原生为已验证e8组件复用，无新Rust编译。当前不是新AppImage或发布证明。

源码同步范围：只将本次已真实验证的Linux字体与透明背景改动纳入RustDesk main；硬编仍BLOCK，秒表最终整包仍待验收，不把这些缺项强行合为产品发布PASS。

### 最大化/恢复已补验

`window454-maxrestore-r1/result.json`已终态PASS：真实标题栏双击使800x600变1848x1253；最大化四角全部144/144 alpha255；再次双击恢复800x600及四角半透明（每角63/144，min6/7）。原指针位置已恢复、PID/窗口不变，没有改系统合成器或电源策略。子窗口、完整88 GUI与硬编仍待。

远程办公字体/透明背景源码已正常快进并独立回读GitHub main `9d2a0cedcf8caf1e43428ba8b8def2bc8cc66951`；只含9个Linux相关源码/资源及对应报告，实际Session标识齐全，保共享HEAD/index；不是最终商城/Common发布。

VibeKits秒表候选隔离源已补齐最新main `3ad01d7459810f352b0e5d75853bbb7c748362bc`相对f0的18个应用/测试/工具变动，无冲突；自有Linux叠加、导航修复与已测秒表字节保留。这一步仅源码准备，不冒称新整包已运行。

## 用户放宽GLIBC后的实际试编译（本节优先于旧加载阻塞描述）

用户明确答复“现在GLIBC也可以 你编译试试 不一定完全按照要求做”。本次允许调整codec进程方案，不把旧2.31基线当永久阻塞，不扩大为替换全机libc或其他平台升级。

`codec-private-glibc235-r1/result.json`真实终态PASS，2.659秒：Ubuntu archive签名验证exit0、包SHA/架构/cohort核验过；ARM C加载测试程序编译exit0/SHA d331b76f30bcd937d85ee55c546d7934db4a95ca0939934cc7a8ee2ade7d750a。同一程序在系统glibc2.31加载libuapi_venc和厂商libavcodec均exit2；经独立glibc2.35 loader加载均exit0。系统getconf前后均2.31，未dpkg安装、未替换系统libc/用户配置；运行时与开发头只提取到本任务私有目录。

这不是硬编PASS：尚无真实编码帧/端到端解码；厂商媒体库接口/结构布局要依据实际导出和匹配头文件验证，不能由文件名直接套系统libavcodec.so.58。继续使用已打通私有运行时路线，不重复要求用户手动升级系统。

最新VibeKits758源码已在原101通过5197文件前置及落盘完整哈希：source758-latest-prepare-r1，173.338秒，冻结main3ad01d7＋完整Linux增量/导航/秒表，路径source-main-3ad01-758。尚未正式编译/部署758；正式构建前再核最新main、资格、环境与空间，不把源码准备记成编译通过。

已创建/验证/发布通用技能linux-desktop-build-acceptance，caucy2026/skills main bf1d7f0d13d1d68edb52ca415068057c98b422e2；团队skills-group README70dac0cbd3943f6b633ff9ea997825f301750ccf已链接。6解析单测＋3真实ARM元数据对照通过，技能校验通过。全球入口已提供参考，不等于所有同事/设备已安装或已读。

完成阶段收尾：三个秒表fixture的build/.dart_tool共12目录，生成物逻辑276408982字节；实际可用2645016576→2921857024字节，54个源/证据/当前程序保护哈希通过，无App停止。原SDK、当前757/454、准备758源、私有codec运行时与原始签名包均保留；不称所有历史缓存已全部清完。


## 2026-10-26 OpenMAX真实硬编关键帧验证

原仿真5713793648新鲜读取`ffmpeg42-khronos-build-r1/result.json`并核systemd单元已退出成功，worker1828487，终态PASS；对应控制端保存`kemi-linux-20261025/ffmpeg42-khronos-build-r1-controller-result.json`。官方FFmpeg4.2.7以匹配厂商ABI的Khronos1.1.2头文件重新编译，make-j8为56.384819822秒，总事务205.125227290秒（含7082文件准备118.051905299秒，不能称完整App编译耗时）。

合成640×480测试真实选择h264_omx，提交8帧、输出8包/22870字节、1关键帧，解码8帧；编码进程实际观察到VENC驱动FD。探针SHA e3ae74a4cda6cf610e018f3bdb8d6f75162e742ed90b240e2fa4202fbf2389f1，静态codec SHA40226dcd41b332bd9e22f7d5357f892e04573e13c9ddce021b46fcb0eee2f6f2。系统库未修改，私有2.35运行时仅用于本任务进程。

旧系统FFmpeg包装器VideoInit失败，与正确ABI同版本重编成功构成负/正对照；实际厂商结构component168字节、GetParameter偏移40。不能仅因库同名便混用头文件。该结果证明H264硬件合成编码可行；H265实际帧、远程办公接入/默认选择、端到端远控及最终包仍未通过。

接入检查另发现ARM正式入口仍未编入hwcodec，原候选枚举仅NV/AMF/VAAPI，不含OMX；hwcodec封装还依赖原配FFmpeg头和avformat，因此不能直接把此次最小4.2静态库覆盖原SDK。下一阶段必须保持隔离和匹配接口，不能仅加编码器名称或开关即宣称启用。


### 758最新运行时差量落盘验证

原仿真5713793648，`source758-runtime-delta-r2/result.json`终态PASS，worker1848615，174.408779146秒；35个声明路径在变更前比对原摘要，变更后完整5225文件均匹配目标清单。冻结main fb4f2d4bdf3745bd0c0494f554cd5d7652b40fbf；本轮资格检查器读取更新main f422c4838c708523f267ffcfb228c919f9d3f4b4仍ELIGIBLE，两者差异仅两份验收文档，无应用运行时变化。

原101候选源码路径仍为`source-main-3ad01-758`（路径保留历史前缀，实际来源以新清单为准）；未停止现用757，未编译、部署或发布758。源码同步后卷可用2758123520字节，MemAvailable3045104KiB；足以开展有界组件回归，但不能据此放宽正式GUI完整构建的原空间门禁。


### 758最新源码52文件回归终态

`regress758-latest-arm64-r1/result.json`终态PASS，worker1853998/出生37037922，systemd原单元inactive/dead且Result=success，52个测试文件exit0，1063.025013001秒。包括秒表、导航、新主线四个结果传输/批量预算文件及原46个Linux回归；四项原生摘要/新鲜摘要/JSON备忘/工具顺序合同也exit0，离线pub和冻结输入检查通过。未停止现用App、没有安装/发布758。

另查全部52份日志：atomic_file_test中1个真实Windows共享语义用例按Platform.isWindows条件跳过，属于Linux不适用项；不把它记为Linux实测或Windows通过。其他日志未见跳过标记。全部文件exit0不代替最终包的真实交互、原账号/授权、空闲CPU与发布验收。

正在按原配FFmpeg7.1重新编译OMX验证库，官方源压缩SHA40973d44970dbc83ef302b0609f2e74982be2d85916dd2ee7472d30678a7abe6，8540源码文件；`kemi-ffmpeg71-khronos-build-r1.service` worker1885766。源码准备限CPU20%/512MiB，实际make配置j8；独立静态库和匹配头文件，不覆盖系统库或原SDK。终态尚待读取，不能沿用4.2探针的PASS冒充7.1。


### 原配FFmpeg7.1硬编验证终态

`ffmpeg71-khronos-build-r1/result.json`终态PASS，worker1885766、原systemd单元inactive/dead且Result=success。8540文件校验/准备142.360220015秒，匹配ABI配置24.057107351秒，真正make-j8为90.241382847秒，私有头/库安装2.013688530秒，总事务265.222929164秒。静态PIC avcodec/avutil/avformat及同版本头文件已生成；没有覆盖系统或原vcpkg SDK。

同一公开OMX接口真实8帧输入/8包输出/1关键帧/8帧解码，观察VENC驱动FD；输出22870字节，SHA67090a4f478144a4baa6cc39d65279b137e68a21f9a7159a1931a02b6a14223f。探针SHA1f96eaab50a50a7f278bcd5dfe69870b42d0f8fd57a54f19650f86090b5d4144，codec静态库SHA85d293e5792e169be9a27a9592868c0361c874047cdd9a826730efd923723e87。最低可用内存2214293504字节、最低可用空间2478170112字节。

隔离源码增加ARM Linux显式完整FFmpeg前缀检查、可选hwcodec构建特性及OMX候选，保持其他端和未选前缀的原ARM路线；shell语法/补丁空白检查通过，尚未原生重编或部署，不能报默认硬编已开启。独立loader对现有454只作依赖列表检查：82项解析无missing，选择私有libc，不执行App入口；不等于真实启动、H265或端到端远控通过。


### H264与HEVC同库真实编码解码均通过

原101仿真新鲜读取 ffmpeg71-hevc-khronos-build-r1/result.json，并确认原unit inactive/dead、Result=success。H264与HEVC分别以640×480合成输入编码8帧、输出8包及1个关键帧、解码8帧，两个测试进程均观察到VENC驱动。H264输出22870字节，HEVC输出7525字节；不据此声称同画质压缩率或实际远控帧率。

HEVC组件角色设置成功，默认输出编码仍为7，实际枚举输出格式为[7,11]。适配保持已验证的IL1.1.2结构ABI，确认设备声明后显式选HEVC编码11。新SDK私有覆盖4处注册/角色/格式/参数集代码，H264同时回归通过。源准备142.357350948秒，make-j8为100.244879682秒，总事务281.265207049秒；运行阶段计时含2秒轮询，不用来推导帧处理速度。codec库SHA395a021f3ca06d2c3e37c1f72ec3bad26e53a7e1fb575aee13f9eb6c27c70b40，HEVC探针SHAade73140436f10ea31cb0f4d6f6193341c50175f92b69bab6e41a38b0e52b4b9，HEVC流SHAfb0c0ef3cd53c0cb60f696244f60db650e15040596f71fc072303e12f02557a5。

保留依赖：新覆盖中的8536个源码文件引用原 ffmpeg71-khronos-build-r1/source，已完整验证SHA；不得整体删除该旧案例目录。新增4处源码与输出在独立案例中，系统库及原SDK未改。

应用状态仍是未集成、未新整包重编/安装或Mac实际连接。ARM-only hevc_omx候选已加入控制端源码，仍保留原关键帧检查。下一阶段必须先在88重新运行正式FRB1.80.1生产者：桥接清单覆盖全部Rust src，lang.rs已改变，不得改旧清单摘要代替真实再生成；新Linux64桥接需校验后传101。

中文ARM合同已实测旧代码3个预期失败、修后6项通过。旧强制英文/隐藏中文逻辑已在控制端修正；实际新包中文、倒角、Mac连接画面/输入和系统占用尚待。用户给定密码只用于正常连接，不写入源、报告或日志。455六路径源差量尚未应用到两台源、未同步主线、未发布。

清理实绩：R1保留集合误用主线字体名，前置失败、实际删除0；R2按远端真实文件名及完整SHA核对后完成571个旧453副本文件删除与已终态454官方flutter clean。副本逻辑448859967字节，卷可用2469208064→3299581952字节（观测值，存在并发）；190个当前454载荷、453完整AppImage、源与工具保护通过。旧755候选与DEB仅做盘点，尚未删除。


### 455桥接闭环与101原生编译已启动

88 的 bridge455-linux64-r1 已真实生产，但旧记录器仅记录3项，漏记 generated_bridge.dart 实际引用的 freezed 文件；原三输出清单保留未修改。修复记录器后，bridge455-linux64-r2 用原正式入口重跑成功：226输入、4输出、33.145184690秒，原Cargo/版本/pubspec/锁恢复。产物TAR 768000字节，SHA9c692cb5ea0d301a5974786f0319538c454bb057057ad61dc589cabe25430fe4。

101 bridge455-arm64-import-prepare-r1 导入原始生产清单及四输出，经原 build-kemi.py linux 的 bridge-only 准备验证全部输入通过，18.077108717秒；未改生产清单摘要。Source455源码六路径已在101应用，88五路径及单独构建脚本修正也已应用；新包尚未安装或发布。

101 kimi-native455-arm64-phased-r1（实际unit名为 kemi-native455-arm64-phased-r1.service）已通过原4GiB准入并真实编译：worker2326698/birth39483935，producer2326766/birth39484158，Cargo配置8；一次新鲜进程树观察见7个rustc与1个cargo，进度持续。最低观测MemAvailable1320738816字节、卷可用3690455040字节，均高于原768MiB/1GiB保护；3秒离散采样不代表连续精确峰值。不得因工具观察超时重启此作业。

为内存已正常退出本任务当前VibeKits757；载体暂退时用已登记同机保存profile remote_1792635358249998只读核原事务，正式构建仍从原仿真5713793648派发。原远程办公454仍保留。Native-only成功后自动保留实际so、官方cargo clean，再建立明确标记的仅GUI输入目录；它不等于有效Cargo缓存、完整GUI或发布通过。finally正常恢复原VibeKits并核身份，未知结果先读原回执。

收尾新增：旧755完整DEB及当前757完整DEB均保留；旧755解包副本经逐文件对照原DEB、无引用验证，连同已终态758测试缓存清理，逻辑954575513字节，观测卷3190157312→4230811648，5225源码保护通过。另清当前454目录对应的重复原始TAR及已终态语言合同测试二进制80867101字节，当前454全部190载荷仍在、453完整AppImage仍在；454旧TAR已不存在，不能再作为可获取输入。旧FFmpeg4.2仅执行官方make clean，保源码与新H264/HEVC SDK，卷最终观测4297928704字节。

用户新增交付要求：两款都须在101正常启动/测试通过；远程办公还需本机Mac反复连接断开、连接耗时/首帧/帧率/后台CPU内存与断开回收记录，再更新Common及KEMI商城；VibeKits更新KEMI商城。旧Apple任务按暂缓不恢复。VibeKits758尚未新整包编译；52文件PASS绑定fb4源码，后续最新main的presence runtime及相应测试改动必须同步、补验后再出包，不转记旧PASS。


### 455原生j8内存保护终态与修复中状态

同一原事务 native455-arm64-phased-r1 已终态失败：worker2326698/出生39483935、producer2326766/出生39484158，460.582355925秒，最小MemAvailable731906048字节触及原768MiB保护；最小卷可用3135983616字节，属于内存边界，不是磁盘或硬编测试失败。无完成新so、GUI、安装或发布；原VibeKits已恢复PID2340715，设备ID/公钥摘要/授权摘要一致。失败target保留，禁止因观察超时或重试重复清理有效依赖。

已读历史真实回执：旧release453-arm64-r1也以8并发触发内存保护；旧r2改Cargo4、GUI8后完成。不能再次把8逻辑核等同于当前内存足以同时编译8个Rust任务。当前只读进程盘点发现原远程办公454主进程RSS约1.34GB，另一个rustdesk进程约0.16GB；角色和连接需先核实，不能据此直接停止进程。新包正常关闭/恢复与构建资源编排须共同验证，RSS含共享页不能直接当可回收物理量。

控制端新增 native455_memory_admission_repair_r1.py，旧真实2,800,070,656字节可用内存会通过旧2GiB准入、被修后j8准入拒绝；4作业3GiB/8作业4GiB边界合同通过，768MiB运行保护未变。该修复目前只完成非交付纯逻辑合同，实际正常回收内存与完整入口尚未复验，不声称可继续正式构建或已修复全部问题。当前不启动任何新的正式重编，先完成复发归因/资格规则核对及资源前置修复；不自行修改资格为eligible。


## 2026-10-27 continuation: actual main integration and x64 build

- Human explicitly restored this session under original gates; official checker ELIGIBLE at ed41fb7949365ba12d6d8f5b47c41f369afcd093.
- Actual Remote Office source integrated to main74b7bb53700b1509191a145beb004268ec33329f; VibeKits source integrated mained41fb7949365ba12d6d8f5b47c41f369afcd093. Both remote refs verified; shared HEAD/index untouched. Earlier264fc6b/f60d668 were source backups only.
- 88 completed old-output cleanup; available3117264896 bytes before new bridge stage. Latest complete453 AppImage ec4cb37d... retained; invalid unaccepted first AppImage and duplicate tar/AppDir outputs retired with frozen manifests. Failure report/hash retained.
- Latest code deltaf9df37e: eleven Rust files applied via original simulator to88/101 with exact before/after SHA checks; no running App replaced.
- 88 bridge455-r3 completed exit0 in102.090109709 seconds;231 inputs/four outputs verified; canonical major inputs restored.
- 88 native455-r1 completed exit0 in324.484970549 seconds, actualj2; ELFx86_64,38327072 bytes, SHA2564fbcc5411705fae41e9cb8e9dde4cd8c2e27794bf6f45f5545db178e6bc27f0b. Native-only is not full App/package acceptance.
- Font source nine files applied on88, existing new native SHA unchanged. GUI455 worker2153234/birth143578349 is in progress; source preparation exit0 and font-glyph tests exit0; GUI Release PID2154256 last observed active. Original runtime guards remain1GiB disk and2GiB combinedRAM+swap for88. No app stopped/installed/published.
- Live public Market recheck: VibeKits app90 remains2684 and RemoteOffice app91 remains452. No storefront update claimed. Public Linux update documentation has single package+OS identity/download URL; internal architecture contract still requires authenticated verification before publishing two architectures to one record.
