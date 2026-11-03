# Linux 浏览器控制：已验证路线与失败边界

当 Firefox 的 AT-SPI 写值返回成功但 DOM 未变化、或 X11 连续 Unicode 输入丢字时，不再把返回 ok 当成输入通过。2026-10-18 在 Ubuntu20 amd64 / Firefox136.0 上，Mozilla 官方 Marionette 客户端3.7.1已完成三轮中文、emoji、大小写、前后空格、多行、按钮点击与文件选择验收。

## 使用范围

- 仅在已有明确授权的目标机和自有测试浏览器配置中使用；不能借此绕过此前对其他浏览器/profile、截图、密码或安全确认的工具拒绝。
- 不附加默认用户 profile，不读取或复制 Cookie、密码、历史。保留 TLS 验证，不接受证书警告；MFA、账号验证和平台强制确认仍按其边界处理。
- 正式编译/更新仍走既有 VibeKits 仿真通道。本机代理可用已授权本地执行工具；控制端用 simulator.ssh_exec 执行目标机脚本，不改成直接 LAN SSH。
- 这是已验证的专用浏览器操作路线，不是“通用 AT-SPI 输入已修复”或全部网站/全部应用通过；不用于替换 Apple 的 Chrome niu 发布路线。

## 执行

1. 确认已有 Firefox 的真实版本、当前登录图形会话与任务目录。DISPLAY、XAUTHORITY取当前已核验会话；不要照抄另一设备的用户或路径。
2. 客户端只安装到自有任务目录，不改系统 Python。先检查现有安装；需要时使用 Mozilla 官方 PyPI marionette-driver==3.7.1，显式公开源、清除私有额外镜像参数，不记录镜像凭据。不要覆盖在用的依赖目录。
3. 运行随技能提供的 scripts/firefox_dom_acceptance.py，使用新的明确 run-id：

```sh
python3 scripts/firefox_dom_acceptance.py \
  --task-root "$BROWSER_TASK_ROOT" \
  --driver-dir "$BROWSER_DRIVER_DIR" \
  --run-id "$BROWSER_RUN_ID" \
  --display "$BROWSER_DISPLAY" \
  --xauthority "$BROWSER_XAUTHORITY"
```

远程单文件传输时，把 assets/firefox-dom-acceptance.html 和 assets/browser-upload-fixture.txt 一起上传，并传 --fixture 和 --upload 的返回路径。脚本校验精确夹具哈希，不能用客户文件替代。

脚本新建0700私有 profile、让内核分配临时端口，以自有 Firefox PID 的 FD/监听表证明仅 loopback；连接后再核 moz:processID 和 acceptInsecureCerts=false。只操作 content，不用 chrome 上下文。

## 判定与恢复

- 先真实点击合成 submit 负对照，确认 DOM 计数变1，再重载归零。随后三轮按精确值比较输入与 DOM 按钮回显，验证多行没有意外提交；最后选择46字节合成文件并核文件名/大小。
- Marionette 脚本沙箱不一定能读页面自定义 window 属性。曾把 None 当成产品输入失败；计数应由 DOM 可观测，且必须有真实提交负对照，不删断言来“通过”。
- 结果在任务子目录 browser-dom-<run-id>/result.json。只有 state=passed、三轮断言、文件选择、ownedBrowserExited 和 temporaryListenerClosed 全部满足才通过。
- 超时先查同一 driver/browser PID 与回执，不重复启动未知作业。finally 只关闭本脚本创建的浏览器，核监听消失；不得结束其他用户浏览器。原始失败与成功回执分别保留，按项目日志期限清理自有临时 profile/日志。

官方依据：[Marionette介绍](https://firefox-source-docs.mozilla.org/remote/marionette/Intro.html)、[Python客户端](https://firefox-source-docs.mozilla.org/python/marionette_driver.html)、[端口偏好](https://firefox-source-docs.mozilla.org/remote/marionette/Prefs.html)。其他Firefox版本必须重新执行同一验收，不转借136的结果。
