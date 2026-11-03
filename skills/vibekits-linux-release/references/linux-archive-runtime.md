# Linux 解压后端及测试夹具完整性

## 实证缺口

695原生八文件归档基线32个runner通过、2失败：7-Zip默认路径仅有Mac/Windows，无Linux；包中也缺Linux后端。RAR5不能执行，不是通过了MCP ready检查就代表所有页面可用。部分旧测试提前return也会计入runner通过，不能拿数字证明真实格式覆盖。

修复应保留Mac/Windows原路径和次序，只增加Linux应用私有 `tools/7zip/7zz`。不要从任意工作目录静默加载替代二进制。源码共享文件若有别人未提交改动，隔离叠加后按原基准与最新主线三方合并，不整文件覆盖。

## 官方输入与打包

- [官方发布页](https://www.7-zip.org/download.html)；本次26.04 Linux x64官方资产SHA256 `fc0327ba27e89bd086cf426dff17d77de582953cdbbc10a6576540a06853ffcd`、1576336字节，7zz SHA256 `d1bc79f00e9815b24048ab167690bdd1dbc387de7dbc47e8d75d68689e49cf4f`。这是本次冻结输入，不强制其他平台升级到该版。
- Linux直连官方GitHub超时后，确认原事务终止，在已有Mac正常gh客户端获取同一官方资产并核发布方digest，再经仿真传入。没有换直连SSH、第三方镜像或关闭TLS。
- `tool/package_linux_7zip.py` 固定SHA、ELF架构和版本，只运行i信息、ldd、readelf；要求完整Rar5/Iso/zstd能力和Ubuntu20 ABI，保留License.txt/readme.txt/History.txt及源代码链接。当前官方26.04已在Ubuntu20运行，最高GLIBC2.16；ARM仍须对应架构实际验证。
- stage脚本要求 `VIBEKITS_7ZIP_SOURCE_DIRECTORY`、`EXPECTED_7ZIP_SHA256`、`EXPECTED_7ZIP_VERSION`；依赖审计包含7zz。缺件不能出包。10项合成打包门禁覆盖错误版本/架构/SHA/依赖/ABI、缺许可、不完整格式及现存输出保护。

## 测试源不等于应用资源

`test_data/archives/rarlng.rar` 是项目已跟踪夹具（2193160字节，SHA256 `f737051e98e60cc0921351241ec92b5732c623468f0698fcaf50eb6fb5c57e2d`），但不是Flutter asset。旧冻结工具仅收源码及声明资源，漏掉它，导致修复后两项测试errno2。

`tool/package_linux_frozen_source.py` 现在按存在的两个归档测试消费者，显式要求并包含该夹具；缺失先失败。不要为补一件夹具递归扫入所有test_data或客户文件。新增两项回归在旧逻辑上分别漏包/未阻断失败，修复后共6项通过，其中包含无关数据不得夹带的断言。

## 证明边界

隔离Linux源的五项路径回归保留Mac/Windows行为，并经临时移除Linux路径的负对照检出缺陷。正确夹具补齐后39项归档回归连续三轮通过，含中文/二进制/空文件ZIP/TAR/GZIP及真实7z/ZIP/RAR5往返和选择性解压。ISO/ZSTD本轮只有后端格式能力证明，不冒充文件往返。

这些是组件/Flutter widget资格测试，不是当前695-r2已具备新后端。新源码和后端仍须整合、重建、打包并真实GUI/升级验收后才能发表完整通过结论。保留所有原始失败，区分产品查找缺陷、运行时漏包、夹具运输缺失和自动化问题。
