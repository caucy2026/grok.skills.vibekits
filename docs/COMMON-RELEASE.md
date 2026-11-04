# Newlink Common 默认发布通道

**gork.bot协助开发** · 同事只看本仓即可发布 Common。脚本与合同以 GitHub raw 为准，禁止把本机绝对路径写进技能互引用。

## Common 与 KD

Common **不是** KEMI 商场（KD）。

| | Common | KD 商场 |
|---|---|---|
| 是什么 | Newlink **屏保固定资源**通道（PAD 客户端拉这六个固定资源） | KEMI 应用商场 |
| 站点 | `https://www.newlinksz.cn/screensaver` | `https://kemi.newlinksz.com/kd/` |
| 本仓入口 | 本文 | [`KEMI-MARKET-101.md`](KEMI-MARKET-101.md) · [`skills/bot-kemi-box/SKILL.md`](../skills/bot-kemi-box/SKILL.md) §10 |

不要把 Common 的六资源更新当成 app 上架，也不要拿 KD 的 Bearer 去登 Common。

## 地址

| 用途 | URL |
|---|---|
| Admin | `https://www.newlinksz.cn/screensaver/main/configPlug/Common` |
| Public | `https://www.newlinksz.cn/screensaver/api/plugData?projectName=Common&name=<resource>` |
| BASE API | `https://www.newlinksz.cn/screensaver` |

BASE 上脚本实际调用（不要手写登录体、不要把口令贴进命令行历史）：

- `POST /web/user/loginIn`
- `GET /config/getWebConfig`
- `POST /web/configPlug/uploadPlug`
- 公开核对：`GET /api/plugData?projectName=Common&name=<resource>`

`<resource>` 用下表第一列的资源名（例如 `KEMI-Linux`），不是文件名。

## 账号

| 项 | 值 |
|---|---|
| 默认用户名 | `common` |
| 用户名覆盖 | 环境变量 `NEWLINK_COMMON_USERNAME`（不设则脚本默认 `common`） |
| 密码 | **只**从两处取：本 bot 的 **Vault**（条目标题常为 `newlinksz.cn`），或当次进程的环境变量 `NEWLINK_COMMON_PASSWORD` |

默认账号名可以写在文档里。密码的值不可以：禁止写入 git、技能、issue、聊天、命令行参数。

历史对照（新同事**不要**假设还能用）：控制机 Mac Keychain 的 service=`KEMI Newlink Common Publisher`、account=`common`。那是旧发布机的钥匙串条目，不是日常宿主。不要用会把口令打到 stdout 的方式去读它，也不要把读到的值记进仓库。

## 权威（caucy2026/skills，raw）

脚本依赖同级目录的 `references/resources.json`（`publish_common.py` 向上一级找 `references/`）。只下载一个 `.py` 不够，按下面三个 URL 落成同一棵临时目录。

```text
https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/scripts/publish_common.py
https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/references/release-contract.md
https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/references/resources.json
```

技能说明：<https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/SKILL.md>

有分歧时以 **release-contract.md** 为准，再回改本文。不要把该技能整份拷进本仓。

## 六资源

下表抄自 [release-contract.md](https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release/references/release-contract.md)（与 `resources.json` 一致）。Record ID 以合同为准，不要另编。

| Resource | Local filename | Record ID |
|---|---|---|
| KEMI-PAD | KEMI-PAD.apk | 6a6d81c09cb89f166dac208c |
| KEMI-macOS | KEMI-macOS.zip | 6a6d81709cb89f166dac208a |
| KEMI-Windows | KEMI-Windows.exe | 6a6d81f89cb89f166dac208e |
| KEMI-Linux | KEMI-Linux.AppImage | 6a6d7358c557f530ffec567f |
| SHA256SUMS | SHA256SUMS.txt | 6a6d74e5c557f530ffec5685 |
| release-manifest | release-manifest.json | 6a6d82359cb89f166dac2093 |

脚本上传前用 Record ID 核对返回的资源名，并且 `projectCode=Common`。对不上就停，不要上传。

顺序（合同）：

1. 全量：四个客户端二进制 → `SHA256SUMS` → `release-manifest` **最后**。
2. 单平台热修：变更的那个二进制 → 含齐四端校验和的 `SHA256SUMS` → `release-manifest` **最后**。
3. 清单是客户端看见新批次的开关。引用文件还没公开一致之前，不要发 `release-manifest`。

完成门槛：后台更新成功；公开 `plugData` 的 version 等于所请求版本；公开 MD5 等于本地 MD5；公开 URL 为 HTTPS 且落在 `cdn.newlink-sz.com/Common/`。stdout 出现 `COMMON_RELEASE=PASS` 才算这轮结束。可选 `--verify-download` 再拉 CDN 字节核对。

## 执行宿主与口令

日常宿主是 **bot 云机或 101**。不把控制机 Mac 当日常执行机。

发布目录里要有上表文件名（热修可只放选中的那几个，加上 `SHA256SUMS.txt` 与 `release-manifest.json`）。机器上要有 `python3` 和 `curl`（脚本用 curl 把文件交到七牛）。

```bash
BASE=https://raw.githubusercontent.com/caucy2026/skills/main/newlink-common-release
ROOT=$(mktemp -d /tmp/newlink-common-release.XXXXXX)
mkdir -p "$ROOT/scripts" "$ROOT/references"
curl -fsSL "$BASE/scripts/publish_common.py" -o "$ROOT/scripts/publish_common.py"
curl -fsSL "$BASE/references/resources.json" -o "$ROOT/references/resources.json"
curl -fsSL "$BASE/references/release-contract.md" -o "$ROOT/references/release-contract.md"

# 口令只进当前进程。从 Vault（条目标题常为 newlinksz.cn）读出后执行：
#   read -rs NEWLINK_COMMON_PASSWORD
# 不要 echo，不要写进仓库、技能、issue，不要放在命令行参数里。
export NEWLINK_COMMON_USERNAME="${NEWLINK_COMMON_USERNAME:-common}"
export NEWLINK_COMMON_PASSWORD

python3 "$ROOT/scripts/publish_common.py" \
  --version "<version>" \
  --release-dir "<staged-release-dir>" \
  --dry-run

python3 "$ROOT/scripts/publish_common.py" \
  --version "<version>" \
  --release-dir "<staged-release-dir>"
# 热修示例：--items KEMI-Linux,SHA256SUMS,release-manifest
# 脚本会把 release-manifest 强制排到最后。

unset NEWLINK_COMMON_PASSWORD
# 若口令曾落到临时文件（例如 mode 600 的口令文件），用后粉碎，不要只 rm：
#   shred -u -- "$SECRET_FILE"
rm -rf "$ROOT"
```

`read -rs` 之后如果要让子进程看见变量，再 `export NEWLINK_COMMON_PASSWORD`。跑完无论成败都 `unset`。临时文件用 `shred -u`。不要把 Vault 导出物留在云机家目录或 101 的 `/root`。

失败时停在合同的失败处理上：登录失败则什么都别发；二进制已上去但校验和失败则不要发清单；清单失败则客户端仍停在上一完整批，修好后只补清单。公开 version/MD5 不一致时，即使后台页面显示成功也不要报完成。
