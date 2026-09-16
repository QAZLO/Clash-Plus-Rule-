# Clash Plus 中国直连规则 - 订阅配置

本仓库提供两种使用方式：**一键安装**和**手动配置**

---

## 📦 方式一：一键安装（推荐）

### 下载步骤

1. 点击右上角绿色按钮 **Code** → **Download ZIP**
2. 解压到任意文件夹
3. 双击运行 **install.bat**
4. 重启 Clash Plus

### 功能说明

- ✅ 自动备份原配置
- ✅ 在现有配置上打补丁（不覆盖节点）
- ✅ 使用 rule-providers 自动更新规则
- ✅ 支持卸载恢复（运行 uninstall.bat）

---

## 🔧 方式二：手动配置

如果不想用脚本，可以手动编辑配置文件：

### 步骤

1. 打开 Clash Plus 配置文件（`%APPDATA%\Clash Plus\Clash Plus\config.yaml`）
2. 在文件顶部添加 rule-providers：

```yaml
rule-providers:
  cn-domain:
    type: http
    behavior: domain
    format: yaml
    url: "https://raw.githubusercontent.com/QAZLO/echo-core/main/direct.txt"
    path: ./ruleset/cn-domain.yaml
    interval: 86400

  cn-ipcidr:
    type: http
    behavior: ipcidr
    format: yaml
    url: "https://raw.githubusercontent.com/QAZLO/echo-core/main/cncidr.txt"
    path: ./ruleset/cn-ipcidr.yaml
    interval: 86400
```

3. 在 `rules:` 列表最前面添加：

```yaml
rules:
  - RULE-SET,cn-domain,DIRECT
  - RULE-SET,cn-ipcidr,DIRECT,no-resolve
  # 你原有的规则接在这里
```

4. 保存并重启 Clash Plus

---

## ⚙️ 规则特性

### DNS 优化

- **国内 DNS**：阿里云（223.5.5.5）、腾讯（119.29.29.29）
- **国外 DNS**：Cloudflare（1.1.1.1）
- **防止 DNS 污染**

### 直连规则

- **9,647 条**中国 IP 段（CIDR）
- **常用国内域名**直连规则
- **抖音、B站、微信**等应用优化

### 自动更新

- 规则文件每 24 小时自动更新一次
- 无需手动维护规则列表

---

## 🧪 测试是否生效

安装后测试：

1. **打开抖音** - 应该正常加载
2. **访问 Google** - 应该通过代理访问
3. **访问百度** - 应该直连

如有问题，查看 Clash Plus 日志：
- 设置 → 日志级别 → Info
- 观察请求是否按规则匹配

---

## 📂 文件说明

| 文件 | 说明 |
|------|------|
| install.bat | 一键安装启动器 |
| install.ps1 | PowerShell 安装脚本（核心逻辑） |
| uninstall.bat | 卸载恢复脚本 |
| snippet-rule-providers.yaml | 手动配置代码片段 |
| cncidr.txt | 中国 IP 段列表（9,647 条） |
| direct-rules.txt | 国内域名直连规则 |
| clash-dns-config.yaml | DNS 配置模板 |

---

## 🛠️ 常见问题

### 1. 安装后节点丢失了？

本安装器不会覆盖节点配置，只在现有配置上添加规则。如果节点丢失：
- 运行 **uninstall.bat** 恢复备份
- 检查备份文件夹：`%APPDATA%\Clash Plus\Clash Plus\backup_*`

### 2. 规则文件下载失败？

GitHub Raw 在国内可能被墙，解决方法：
- 先连接 VPN，再重启 Clash Plus 让它下载规则文件
- 或使用手动配置方式，下载规则文件后放到本地

### 3. 安装后抖音还是慢？

- 确认已重启 Clash Plus
- 检查 Clash Plus 是否连接成功
- 查看日志确认规则是否生效

### 4. 想恢复原配置？

- 运行 **uninstall.bat**
- 或手动到 `%APPDATA%\Clash Plus\Clash Plus\backup_*` 文件夹找备份

### 5. 规则多久更新一次？

- 规则文件每 24 小时自动更新（interval: 86400 秒）
- 手动强制更新：删除 `ruleset` 文件夹后重启 Clash Plus

---

## 📜 许可

MIT License - 自由使用、修改、分发

---

## 🙏 贡献

欢迎提交 Issue 和 Pull Request！

如果这个项目帮到了你，请点个 ⭐ Star 支持一下！
