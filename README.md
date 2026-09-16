# Clash Plus 中国直连规则配置

针对 Clash Plus 优化的中国大陆地区 IP 和域名直连规则，解决开启代理后国内网站访问缓慢的问题。

## ✨ 功能特点

- 包含 **9,647 条**中国 IP 段（CIDR）规则
- **抖音专用直连规则**（解决海外 CDN 问题）
- 常用国内域名直连规则
- 使用 **rule-providers** 自动更新规则
- 安装脚本**不覆盖节点配置**，安全可靠

## 🚀 快速开始

### 一键安装（推荐）

1. 下载本仓库：**Code** → **Download ZIP**
2. 解压后运行 **install.bat**
3. 重启 Clash Plus

### 手动配置

复制 [snippet-rule-providers.yaml](snippet-rule-providers.yaml) 中的代码片段，粘贴到你的 `config.yaml`

详细教程见 → [INSTALL.md](INSTALL.md)

## 📂 文件说明

| 文件 | 说明 |
|------|------|
| [install.bat](install.bat) | 一键安装启动器 |
| [install.ps1](install.ps1) | PowerShell 安装脚本（核心逻辑） |
| [uninstall.bat](uninstall.bat) | 卸载恢复脚本 |
| [INSTALL.md](INSTALL.md) | 详细安装教程 |
| [snippet-rule-providers.yaml](snippet-rule-providers.yaml) | 手动配置代码片段 |
| [douyin-direct.yaml](douyin-direct.yaml) | 抖音专用 YAML 直连规则 |
| [cncidr.txt](cncidr.txt) | 中国 IP 段列表（9,647 条） |
| [direct-rules.txt](direct-rules.txt) | 国内域名直连规则 |
| [clash-dns-config.yaml](clash-dns-config.yaml) | DNS 配置模板 |

## 🛠️ 适用场景

- ✅ 开启 VPN 后抖音、B站加载慢
- ✅ 国内网站访问延迟高
- ✅ 微信、QQ 等应用连接不稳定
- ✅ 需要精细化分流控制

## 🔒 安全说明

- ✅ **不覆盖节点配置** - 只在现有配置上打补丁
- ✅ **自动备份** - 每次安装前自动备份原配置
- ✅ **可随时恢复** - 运行 uninstall.bat 即可恢复

## 📜 许可

MIT License

---

⭐ 如果这个项目帮到了你，欢迎 Star 支持！
