# 云电脑（Grok Bot box）部署 Vibekits 控制器

**gork.bot协助开发** · 包只从本仓 Releases 取（见 [`PACKAGES.md`](PACKAGES.md) / [`../packages/CURRENT.json`](../packages/CURRENT.json)）。

仿真协议与 invoke **权威**在 [caucy2026/skills …/vibekits-remote-simulator](https://github.com/caucy2026/skills/tree/main/vibekits-remote-simulator)；本页只写**云机怎么把控制器跑起来**。

## 目标形态

| 项 | 建议 |
|---|---|
| 宿主机 | Grok Bot box（linux x86_64） |
| 客机 | Docker `ubuntu:20.04` amd64，`sleep infinity` 常驻 |
| 显示 | Xvfb `:99`（1280×800×24） |
| 包 | Release 上的 `VibeKits-*-linux-amd64.deb` 或统一 tar 内 amd64 |
| 会合 | ABCD hosts 钉死；`simulatorAccessEnabled=true`；`protocol_v4` |

## 步骤摘要

1. **下包并核 SHA**（导读 §3）。
2. **起容器**（示例，按环境改名与挂载）：

```bash
CTR=vk-u20-amd64-controller
sudo docker run -d --name "$CTR" --network host \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$PWD/vk-data:/vk" \
  ubuntu:20.04 sleep infinity
sudo docker exec "$CTR" bash -lc 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl xvfb libsecret-1-0 openssh-client python3'
```

3. **钉 ABCD**（宿主机 `/etc/hosts` **和** 容器各一份；或 `docker run --add-host=…`）：

```text
119.96.24.110 kemi-chat1.newlinksz.com kemi-chat.newlinksz.com
171.43.138.47 kemi.newlinksz.com
159.27.117.207 kemi-sh1.newlinksz.com
172.188.240.186 kemi-sg1.newlinksz.com
```

验收：`getent hosts kemi-chat1.newlinksz.com` ≠ `198.18.0.1`。

4. **安装 amd64 deb 到容器**（或解压到 `/vk/runtime`）：

```bash
sudo docker cp ./VibeKits-*-linux-amd64.deb "$CTR":/tmp/vk.deb
sudo docker exec "$CTR" bash -lc 'apt-get install -y /tmp/vk.deb || dpkg -i /tmp/vk.deb'
# 若用解压 runtime：保证 vibekits 与 vibekits-harness-relay 同目录，必要时 LD_LIBRARY_PATH=<runtime>/lib
```

5. **启动**

```bash
sudo docker exec -d "$CTR" bash -lc 'Xvfb :99 -screen 0 1280x800x24 -ac >/vk/xvfb.log 2>&1'
sudo docker exec -d "$CTR" bash -lc 'export DISPLAY=:99 HOME=/vk/home VIBEKITS_DATA_HOME=/vk/home/VibekitsData LIBGL_ALWAYS_SOFTWARE=1; mkdir -p "$VIBEKITS_DATA_HOME"; vibekits >/vk/vibekits-run.log 2>&1'
# 等 tool-bridge.json 出现后：
sudo docker exec "$CTR" bash -lc 'vibekits-harness-relay --vibekits-harness-simulator-access true; vibekits-harness-relay --vibekits-harness-status; vibekits-harness-relay --vibekits-harness-protocol'
```

二进制名以包内为准（有的 runtime 在 `/opt/vibekits/`）。

6. **实活注册**  
   状态 `registered` **且** 对 ABCD 有 ESTAB / `request_pk`。虚报则只重启容器内 vibekits+relay（`bot-kemi-box` §6.8），保持同一控制器 ID 与公钥 digest；变了要目标重同意。

7. **tool-bridge**  
   读 `$VIBEKITS_DATA_HOME/Mcp/tool-bridge.json` → `endpoint` + `token`。  
   Invoke 必须用字段 **`toolId`**。示例见 `bot-kemi-box` §6.11。

## 与正式包边界

Docker / 解压 runtime 只做**控制器通路**。商场上架包另线（app90 统一 tar；arm64 独立 `com.caucy.vibekits.arm64`）。

## 故障

见 `bot-kemi-box` §6.9 与 caucy2026/skills `channel-recovery.md` raw。
