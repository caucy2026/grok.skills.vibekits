# BOT amd64 772 编译与连 101 阻塞（2026-11-03 Asia/Shanghai）

## 授权
- 用户 t30u / parent：最新 vibekits 源码编 amd64；bot 上调试仿针连 101；通过后再同步商场 Linux x86_64（app90）。
- 硬约束：不 SendToAgent；不杀 101 vibekits；连不通不上架。

## 冻结源
- Worktree: `/Volumes/ORICO/kemi-build-cache/vibekits-linux-amd64-772-20261103/source-linux772-amd64-r1`
- Commit: `157bbd7e0479ebc7a0841dee2e284c5e5bf012e0`
- Version: `1.9.0-dev.772+2772`（version_code 2772 > 在架 2684）

## 编译（bot U20 amd64 客机 `vk-u20-amd64-772`）
- Flutter linux --release 成功。
- `build/linux/x64/release/bundle/vibekits` SHA256 `cceacff2b61d3ca2c269b952576a26eb599ec09ca85ddf5f6d6f5c9b08b19fe9`
- `lib/libapp.so` SHA256 `74d8d04e875b7a5ca2f66e09ffbc030e02663ecc3ebcb660de96b44b52897bf2`
- version.json: app_name vibekits / 1.9.0-dev.772 / build_number 2772

## 运行时拼装（冒烟，非正式出包）
- 路径：`/workspace/vk-amd64-772/runtime-772-smoke`
- GUI/AOT：772；harness/relay：商场 684 deb 抽出（relay SHA `1d749b5fe2109e3236eea6cfd461630204eff795a7976518343ceacb5ddad5e6`）
- 标明 provisional：正式商场包仍需 stage-package（匹配 772 relay + readonly marker + ADB + 7zip + Node staging），不能用 684 外壳夹带冒充正式 772。

## Bot 冷启
- 容器：`vk-u20-amd64-772-run`（Ubuntu20, network host, privileged, Xvfb :99）
- 冷启成功：进程存活，tool-bridge 写出，appBuild=2772
- 本地 relay `--vibekits-harness-protocol` → `ok:true, state:idle, simulatorAccessEnabled:false, code:protocol_v3`

## 仿针连 101（失败 / 阻塞点）
- 目标 routingId `7634801763`
- 多次 invoke `vibekits.simulator.connect` 均：
  - `ok:false`
  - `code:HARNESS_REGISTRATION_PENDING`
  - `error:HARNESS_TRANSPORT_HARNESS_REGISTRATION_PENDING: Harness 中继仍在向服务器注册…`
  - `errorContext.state=offline`，本机 ephemeral routingId 例 `9245390203`（未完成服务器注册）
- 连续轮询约 4+ 分钟仍 pending，未进入 connected/sshReady。
- 因此 **未执行** 商场 mutate（按授权：连不通不上架）。

## 对照：Mac 控制端仍可连 101（非本门禁替代）
- Mac invoke connect → connected=true, sshReady=true, hostname=mp730-156, fingerprint SHA256:K5O9KAviudUiaDW02EsnWuq9ZcWg7lO3u3ThNFetP+Y
- ssh_exec（带 routingId）stdout: `mp730-156` / `aarch64`；101 上 vibekits 在跑（观测 PID 例 613777 + harness-relay；本任务未杀未重启）

## 未完成
1. Bot 侧 Harness 服务器注册 / 账号登录（钥匙环/Secret Service 在无头 headless 下不稳定；secret-tool 易卡 prompter）
2. 正式 amd64 `.deb` stage-package（772 一致 relay + ADB + 7zip + readonly marker）；脚本版本常量仍有 683 示例需改成 772
3. CopyFromBox → Mac → kemi-market-publish 更新 app90（version_code>2684）

## 下一步建议
1. 在 bot 桌面/有显示会话中登录与 Mac 同一 KEMI 账号，完成 Harness 注册至非 offline，再重试 connect+ssh_exec。
2. 或提供已验证的 Linux amd64 relay（与 772 冻结一致）+ ADB/7zip 冻结输入，走完整 stage-package 后再验。
3. 注册通过前禁止上架。
