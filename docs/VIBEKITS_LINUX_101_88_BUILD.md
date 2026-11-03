# VibeKits Linux 在 101 和 88 上运行的构建流程

交付一个 `VibeKits-Linux-<版本>.tar.gz`。归档内有一个安装入口和两个同源 DEB。88 是 x86_64，使用 amd64 DEB。101 是 aarch64，使用 arm64 DEB。两台机器安装后都运行 `/opt/vibekits/vibekits`，包名均为 `com.caucy.vibekits`。

## 1. 在 x86_64 主机冻结构建输入

从已核实的 VibeKits 主线取一个完整 Git SHA，建立独立检出，保留共享工作树。两份构建使用同一 Git SHA、版本号、构建号、Flutter 版本、Harness SDK 版本和依赖锁文件。将原生 Relay 的源码 SHA 及各架构工具和二进制哈希写入构建清单。版本同步到隔离源码的 pubspec 和 AppVersion，运行 `node tool/verify_app_version.mjs "$SOURCE"`。

## 2. 从同一台主机调度两份原生构建

- amd64 构建在 x86_64 主机的 Ubuntu 20.04 环境执行。宿主系统不同则使用 Ubuntu 20.04 构建容器或虚拟机，并检查容器内 `uname -m` 返回 `x86_64`。
- arm64 构建优先由 x86_64 主机通过已登记的仿真入口调度到 ARM64 Ubuntu 20.04 构建机。只有这一台 x86_64 物理主机时，可以用 QEMU 系统虚拟机运行完整 ARM64 Ubuntu 20.04 客体，再在客体内执行同样的原生构建。客体内 `uname -m` 必须返回 `aarch64`。QEMU 路线需验证工具链与构建结果，101 的实际功能仍在真机上验收。
- 当前项目 Flutter 3.41.9 的已验证路线是架构对应的原生 Flutter SDK。给 x86_64 SDK 加一个 ARM 编译参数不足以构建完整 Linux 应用。

## 3. 在每种架构内编译和组装

1. 检查目标卷余量及既有构建事务。准备该架构的 Flutter、Rust、CMake/Ninja、GTK3、WebKitGTK、libsecret 和项目要求的媒体依赖，使用现有合格工具链及冻结清单。运行项目的 `tool/linux_media_native_input_preflight.py`，按当前依赖声明校验并准备 mimalloc 等原生归档。
2. 在对应架构的冻结 Relay 源码内，沿已核实的工具链和锁文件执行 `cargo build --locked --release --features flutter,linux-pkg-config --bin vibekits-harness-relay`。配置依赖库和缓存路径时沿用本机已验证的构建入口。记录 Relay 的 ELF 架构、依赖和 SHA-256。
3. 在冻结 VibeKits 源码内运行 `flutter pub get --enforce-lockfile`，再经项目的原生输入准入入口执行 `flutter build linux --release --no-pub --build-name="$VERSION" --build-number="$BUILD"`。产物位于 `build/linux/x64/release/bundle` 或 `build/linux/arm64/release/bundle`。
4. 组装同一版本完整 Harness SDK、WebKit 资源、内置技能和该架构的 Node、Relay、ADB、7-Zip。复用 Linux 发布技能中的 `scripts/stage-package.sh TASK_ROOT SOURCE RELAY`。按脚本准备 Node 与 SDK staging 布局，并传入 `EXPECTED_RELAY_SHA`、`VIBEKITS_ADB_SOURCE_DIRECTORY`、`EXPECTED_ADB_SHA256`、`VIBEKITS_7ZIP_SOURCE_DIRECTORY`、`EXPECTED_7ZIP_SHA256`、`EXPECTED_7ZIP_VERSION`。该技能脚本包含历史版本常量，实际出包须使用本轮冻结版本的包装入口，核对 control 与 Flutter 资源版本一致。
5. 在 staging 中用 `tool/linux_readonly_relay_package.py --bundle BUNDLE --sha256 PIN --stage` 生成只读协议标记，再用同参数的 `--verify` 复核。保持 DEB 包名、安装路径和原应用身份。用 `dpkg-shlibdeps` 生成和审核依赖，检查 Ubuntu 20.04 的 glibc 2.31 基线，以及包内原生组件的架构和运行依赖。
6. 对每个最终 DEB 运行技能中的 `verify-package-version.py FINAL.deb --version VERSION --build CODE --arch amd64`，ARM 传 `arm64`。再运行 `verify-package-runtime-deps.py FINAL.deb`。用 `dpkg-deb -f FINAL.deb Package Version Architecture` 核对包头，并记录最终字节数和 SHA-256。

## 4. 生成同一个交付文件

将两个已核验的 DEB 分别命名为 `vibekits_amd64.deb` 和 `vibekits_arm64.deb`，与下列 `install.sh` 放在同一个交付目录。

```sh
#!/bin/sh
set -eu
cd "$(dirname "$0")"
case "$(uname -m):$(dpkg --print-architecture)" in
  x86_64:amd64) package=vibekits_amd64.deb ;;
  aarch64:arm64) package=vibekits_arm64.deb ;;
  *) echo '不支持当前系统架构或内核与用户空间架构不匹配' >&2; exit 2 ;;
esac
sha256sum -c SHA256SUMS --ignore-missing
sudo apt-get install "./$package"
```

打包机在交付目录中执行以下命令。接收端解压同一份归档后执行 `sh install.sh`。

```sh
sha256sum vibekits_amd64.deb vibekits_arm64.deb > SHA256SUMS
tar -czf "../VibeKits-Linux-${VERSION}.tar.gz" install.sh SHA256SUMS vibekits_amd64.deb vibekits_arm64.deb
sha256sum "../VibeKits-Linux-${VERSION}.tar.gz"
```

## 5. 在 101 和 88 验收同一个交付文件

在两台机器上使用同一归档，核对归档哈希，记录安装脚本选中的 DEB 架构。覆盖安装后确认实际进程路径和对应 ELF 架构，检查原设备 ID、Keyring、权限、房间身份以及真实仿真工具调用。101 额外验证 Mali 秒表和 G6，双机用同一冻结源码做 CPU/GPU 跑分与 clean 构建计时。商城按架构提供相应 DEB 并分别核对下载和自更新。

交付和验收结束后，清理本轮已闲置的生成物，记录删除范围、逻辑字节与目标卷前后可用空间。保留正式包、当前运行输入及仍有恢复用途的回退文件。
