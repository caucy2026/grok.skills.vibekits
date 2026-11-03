# 已证实 Linux 构建/验收教训

- 全窗口 GtkOverlay/GtkFixed 截获 Flutter 事件：负对照点击0，原生兄弟布局点击1。不能只看窗口存在。
- 官方 SDK WebKit 资源需完整兼容转换；曾只有1字正文/超时，后来2前端资源及72客户端 bundle 转换后正式 UI 正常。
- capability_check 空断言来自 lan_stream_receiver 缺少 usage contract。用既有 catalog completeness 测试先失败后通过，不能重装系统掩盖。
- CMake 默认 install prefix 在插件 project() 前确定，否则新构建会意外尝试 /usr/local。
- 短而不平衡的 unified patch 曾 fuzz 放错构造字段；使用平衡上下文和 --fuzz=0，编译测试必须在部署前。
- Flutter tester localhost 被继承 HTTP(S)_PROXY 影响；只在测试命令去掉代理，不能改全局网络。
- ARM LLVM LTO 被内核 OOM 杀死与 x64 虚拟内存上限导致 LLVM OOM 是不同证据；不混称超时。只在自有构建环境调整资源，结束后清理自有临时 swap 时先核无使用。
- dpkg-shlibdeps 发现手写依赖漏 libxcb-randr0/libsodium/libssl/libpulse 等；最终包依赖必须由实际 ELF 推导。元数据修复后验证 data payload 不变，重新记最终包哈希。
- ARM64 最新 metadata-only 修正版683：281558736字节，SHA256 106168b3bb51751681786d03c5ce86c6c93b4f2c30d103d51410ff64568860d7；尚未 ARM 实机功能验收，不是已发布证明。
- 历史682阶段曾出现GUI常量681与候选包名不一致；必须核最终生成资源和正式运行路径，不能从文件名判断已升级。该阶段的GTK焦点猜测不是已证实根因。

## GUI新目录的原始依赖输入必须先于生命周期动作

761与764两次配置失败来自相同遗漏：仅复制GUI wrapper，未复用原生输入供应准入；有效的 mimalloc2.1.2 原归档仍可获取，新目录却在线下载成0字节。配置前失败不算j8成功，也不因网络触发就忽略执行者遗漏。

复用实际 `tool/linux_media_native_input_preflight.py`，真实插件声明及原归档双摘要通过后才允许退出旧App；配置回调再经同一guard。实际producer需要可执行的旧入口负控和输入坏/缺负控，而非仅写“已准备”。保留首败，拒绝覆盖未知目标；先验完整修复与真实非交付复验不自动恢复已暂停资格。具体版本、源路径、原归档与回执按当次项目记录核对，不把本次机器或路径写成通用限制。

## 共享Dart更新不等于Linux原生平台已移植

741的649项Dart回归与Release均通过，但新账号链所需的signClientAccountChallenge、accountNativeChannel、accountAccess没有完整进入Linux平台通道及包内原生服务；规范Rust主线当时也只为macOS/Windows编译相关处理器。基础MCP计算/仿真可用不能证明该链可用。6个Mac专属跳过与2个缺隔离native/hbbv夹具的跳过分开记录，后两项不能默认为Linux通过。

- 新增平台调用同时核Dart方法、平台真实处理器、最终边车已编译协议及真实caller授权，不只同步UI或沿用旧ELF。项目tool/verify_linux_account_bridge_contract.py先检缺，传明确arch；正例仅表示STATIC_CONTRACT_PRESENT_RUNTIME_REQUIRED，不表示运行/发布PASS。
- 原生wire缺夹具要补真实隔离链，不把mock MethodChannel成功或skip计入功能通过。协议字符串不存在可证明缺件；存在仍须实际dispatch/身份/授权/TLS正负控。
- 沿Mac/Windows已验证的请求标签、JSON字符串封装及有限超时移植。不得为Linux只放开cfg而省略原始GUI身份、本人确认、租约/nonce/Origin检查或重发未知结果；不借其他App身份、不重置ID/Keyring。
- Native源码先核规范仓库与monorepo布局。遗留client checkout的origin/master不代表公司main；可复用现有backup远端，但先核其确为caucy2026/rust-desk，再冻结main/client，不改同事HEAD/index。

## Ubuntu20 控制与安装回归

- Flutter应用卡片的鼠标InkWell不保证Linux AT-SPI公开可执行动作。卡片显式声明button/onTap及enabled，原鼠标行为保留；回归实际执行SemanticsAction.tap打开详情，再验证鼠标操作。仅Widget测试通过不代表重建GUI已公开正确状态。
- 只需控件标识、角色或焦点时使用本运行版明确支持的metadataOnly，不向旧版伪传参数。WebKit子节点visible/showing可能在GTK祖先隐藏后仍为true；不能单凭子节点状态认定遮挡，更不能因此读取正文或换截图绕过拒绝。
- Ubuntu20实机的true在/bin/true，macOS测试路径/usr/bin/true不能直接照抄。为目标平台选择真实程序，不创建系统链接、不安装替代程序、不跳过失败断言。测试SemanticsHandle使用try/finally及时释放，addTearDown可能晚于Flutter的句柄验证。
- ELF依赖审计不覆盖命令行子程序。gio归属libglib2.0-bin，xdg-open归属xdg-utils；Ubuntu包需声明实际所需运行依赖并核最终Depends，不能以开发机预装为兼容通过。
- 依赖遗漏曾在版本/ELF审计都过后复发：只写教训不够，必须同时修实际控制字段生成器和最终DEB独立检查器。使用`../scripts/verify-package-runtime-deps.py`，原坏包必须失败，库包`libglib2.0-0`、可选替代或宿主已有命令不能替代必需CLI包声明；新包尚未重打/真机复验时不得写修复交付完成。
- 固定SDK使用flutter --no-version-check，避免offline pub任务仍进入无关SDK标签检查。只处理已核对的可选检查子事务，不把停止整个Flutter进程或重启构建当恢复。
- 当前版或本机高于商城版时下载禁用是防重复/防降级，不为测试卸载、改登记或降级。隔离dataHome可验证真实AppImage落盘、权限、登记与失败回滚；若launch回调为替身，明确不算真实启动或正式覆盖升级通过。

## 构建控制入口与观测边界（754案例）

- 维护器按“导入后main()”调用时，CLI式顶层exec会在资格步骤前提前执行测试，并在后续调用时缺少main。生成控制脚本应显式导出main、只在__main__入口执行；用实际导入正例及旧控制负例验证没有I/O/启动副作用，单纯compile语法通过不覆盖这个接口合同。保留原终态及失败回执，不能修改在途控制文件或复发未知事务。案例见项目LINUX754_PREPARATION_20261024.md及test_linux754_control_import_20261024.py。
- 新内核单元需实际读取其cgroup和内存限制，再跑原编译器同字节/同PID/错误传播及无作用域负控；旧资格文件或环境标志不是新单元资格。仅源码未变、测试集合完整且全部通过、前次事务终态及恢复明确时，才可复用单位证据，记录原回执/源码清单SHA及“未重新执行”；不能把复用当新包UI通过。
- 构建前差少量内存时，先查真实占用与已有授权。若临时退出空闲软件中心等UI，须核无窗口/安装任务/锁、正常退出并在finally按原模式恢复，不杀安装后台或停他人服务，不改变系统性能策略；这只为构建腾资源，不得计作App性能改善。
- 严格空闲采样在窗口内不查询目标状态；可在控制端计时并处理其他设备，结束后再读同一事务。采样器静态的“无调用”字段不是控制端审计，若存在只读SSH观察应如实注明边界，不宣称完全无观察开销。输入空闲验证、CPU范围及最终功能结果仍分开判定。
