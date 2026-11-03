# Linux ADB 漏包与永久门禁

## 为什么编译绿但运行不全

695的303项回归和Release编译通过，真实 `vibekits.system.capability_check` 却返回ready=false：264个可执行工具均有handler、Schema完整，但9个ADB工具所需的应用私有 `tools/adb/adb` 未打包。目标系统也无adb，不能依赖开发机PATH或把目录有定义当作可用。Mac既有打包路线已保留ADB与NOTICE/版本元数据，Linux路线漏掉这一段。

## 构建输入与验证

- 官方来源：[Platform-Tools发布说明](https://developer.android.com/tools/releases/platform-tools)，[Linux下载](https://dl.google.com/android/repository/platform-tools-latest-linux.zip)。latest URL可变，必须另记录下载包及adb字节SHA256，不能把URL当冻结版本。
- 2026-10-18实测amd64输入37.0.1：ZIP SHA256 `d230f13842f60f782a8645f9c813f8f845bf36089ea7289f28c48f17979313f1`；adb SHA256 `a902be8f45c6c62e76c9efaf6947a0fa747c9cabd89a2ac8e0d16ecb30b3ed01`。这是本次证据，不强制以后永远用同一版。
- 保留原组件 `NOTICE.txt`、`source.properties` 和随附lib64库及其许可。只取ADB所需组件，不为此安装或修改系统SDK，不调用fastboot、adb root或改设备授权。
- 采用项目 `tool/package_linux_adb.py`，参数source-dir/destination/arch/sha256。目标须不存在，先验证输入、ELF64小端架构和固定SHA，再执行复制后的 `adb version`、全部附带ELF的ldd/readelf；不启动server。所有依赖必须可解析，最高GLIBC要求不能超过Ubuntu20的2.31。
- 实测本次adb自身最高GLIBC2.16，连同libc++.so最高2.17，Ubuntu20可运行。amd64二进制不能复制给arm64；ARM必须提供对应架构的兼容输入并重新验证，不伪造ARM PASS。
- 包依赖审计须含ADB及随附so，而非只审GUI/relay/Node。脚本 `tool/skills/vibekits-linux-release/scripts/stage-package.sh` 要求环境变量 `VIBEKITS_ADB_SOURCE_DIRECTORY`、`EXPECTED_ADB_SHA256`，缺失直接失败。

## 回归与交付

`python3 -B tool/test_package_linux_adb.py` 的13项合成回归覆盖缺件/NOTICE/版本、错误SHA/主程序和库架构、库依赖、ABI过高、现存目标保护等；本次Mac与Ubuntu20 Python3.8均通过。伪ELF仅进入模拟runner，不能执行。

另在Ubuntu20用真实官方输入运行helper通过。695包装修正版另存为 `...adb-runtime-r2.deb`，原包保留，GUI/AOT哈希不变；最终DEB284282120字节，SHA256 `ef019b4560d67509302638100087e874f4d0daace4d686813cacf816a4325afe`，独立下载和版本资源校验通过。它仍需新包实际启动、能力自检、真实ADB工具和其他完整门禁，不因补文件或ready=true就称全部功能/商城发布通过。

后续r2隔离启动成功，原设备ID/native公钥摘要连续；真实能力自检ready=true，305定义/264可执行，missingHandlers、invalidSchemas、missingRuntimes均为空。生产 `vibekits.adb.list_devices` 实际返回adbVersion1.0.41、devices=[]，证明执行器已能启动，不证明9个工具对真实Android设备逐项通过。正式覆盖安装及完整GUI仍有缺项。

同版本包装修订的启动日志也要独立命名。曾因继续用旧launch695.log导致FileExistsError，旧候选已正常退出但新候选未启动；不能归为产品启动崩溃。先确认原worker终止、两个候选均未运行，再用独立恢复事务启动r2并核身份，失败恢复原695。日志/回执必须在stop之前预备，stop之后所有步骤置于恢复保护内。

尚未对外发布的包装修正可保留同一GUI版本并区分不可变包装修订及哈希；已发布包不得以同版本不同字节静默替换。任何重打包不得篡改原已验证包、运行中bundle或用户数据。
