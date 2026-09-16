# Clash Plus 中国直连规则

为 Clash Plus 配置中国网站和 IP 直连规则，优化国内访问速度。

## 📦 文件说明

- **clash-plus-complete.yaml** - 完整配置（推荐）
  - 包含 44 条抖音相关域名规则
  - 包含 9,647 条中国 IP 段规则
  - 包含常见国内网站直连规则

- **clash-dns-config.yaml** - DNS 优化配置
  - 国内 DNS 优先（阿里云、腾讯）
  - 加速国内域名解析

- **direct-rules.txt** - 域名直连规则源文件
- **cncidr.txt** - 中国 IP 段源文件

## 🚀 使用方法

### 方法一：导入完整配置

1. 下载 `clash-plus-complete.yaml`
2. 在 Clash Plus 中导入配置
3. 切换到该配置并重启 Clash Plus

### 方法二：仅修改 DNS

1. 打开 Clash Plus 配置编辑器
2. 找到 `nameserver:` 部分
3. 改为：
```yaml
nameserver:
  - 223.5.5.5
  - 119.29.29.29
  - "tls://1.1.1.1"
```
4. 保存并重启

## ✅ 优化效果

- ✅ 抖音、B站、微信等国内 APP 直连
- ✅ 国内网站访问速度提升
- ✅ 减少不必要的代理流量
- ✅ DNS 解析更快更准确

## 📊 规则覆盖

- 抖音相关域名：44 条
- 中国 IP 段：9,647 条
- 常见国内网站：数千条

## ⚠️ 注意事项

- 导入新配置后必须重启 Clash Plus
- 确保使用"规则模式"而非"全局模式"
- 大文件（4MB+）导入可能需要等待几秒

## 🔗 数据来源

- IP 段数据：[IPIP.net](https://github.com/17mon/china_ip_list)
- 域名规则：[Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat)

## 📝 更新日期

2026-09-16

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！
