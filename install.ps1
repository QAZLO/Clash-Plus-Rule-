# ============================================
# Clash Plus 中国直连规则 - 安装脚本
# 在现有 config.yaml 上打补丁，不覆盖节点
# ============================================

$ErrorActionPreference = 'Stop'

$RepoRaw = 'https://raw.githubusercontent.com/QAZLO/echo-core/main'
$ClashDir = Join-Path $env:APPDATA 'Clash Plus\Clash Plus'
$Config = Join-Path $ClashDir 'config.yaml'

Write-Host ''
Write-Host '====================================' -ForegroundColor Cyan
Write-Host '  Clash Plus 中国直连规则安装器' -ForegroundColor Cyan
Write-Host '====================================' -ForegroundColor Cyan
Write-Host ''

if (-not (Test-Path $Config)) {
    Write-Host "[错误] 找不到配置文件：$Config" -ForegroundColor Red
    Write-Host '请先运行一次 Clash Plus 并导入你的订阅，再执行本脚本。'
    Read-Host '按回车退出'
    exit 1
}

Write-Host "[1/4] 配置文件：$Config"

# ---------- 备份 ----------
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupDir = Join-Path $ClashDir "backup_$stamp"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
Copy-Item $Config (Join-Path $backupDir 'config.yaml.bak')
Write-Host "[2/4] 已备份到：$backupDir" -ForegroundColor Green

$text = Get-Content $Config -Raw -Encoding UTF8

if ($text -match 'cn-ipcidr') {
    Write-Host '[提示] 规则似乎已安装过，将重新写入。' -ForegroundColor Yellow
    $text = $text -replace '(?ms)^# >>> echo-core start.*?^# <<< echo-core end\r?\n', ''
    $text = $text -replace '(?m)^\s*- RULE-SET,cn-(domain|ipcidr),DIRECT.*\r?\n', ''
}

# ---------- 写入 rule-providers ----------
$providers = @"
# >>> echo-core start
rule-providers:
  cn-domain:
    type: http
    behavior: domain
    format: yaml
    url: "$RepoRaw/direct.txt"
    path: ./ruleset/cn-domain.yaml
    interval: 86400
  cn-ipcidr:
    type: http
    behavior: ipcidr
    format: yaml
    url: "$RepoRaw/cncidr.txt"
    path: ./ruleset/cn-ipcidr.yaml
    interval: 86400
# <<< echo-core end
"@

if ($text -match '(?m)^rule-providers:') {
    Write-Host '[提示] 已存在 rule-providers，把新规则集并入其中。' -ForegroundColor Yellow
    $merge = @"
rule-providers:
  cn-domain:
    type: http
    behavior: domain
    format: yaml
    url: "$RepoRaw/direct.txt"
    path: ./ruleset/cn-domain.yaml
    interval: 86400
  cn-ipcidr:
    type: http
    behavior: ipcidr
    format: yaml
    url: "$RepoRaw/cncidr.txt"
    path: ./ruleset/cn-ipcidr.yaml
    interval: 86400
"@
    $text = [regex]::Replace($text, '(?m)^rule-providers:\r?\n', ($merge -replace '^rule-providers:\r?\n', "rule-providers:`r`n"), 1)
} else {
    $text = $providers + "`r`n" + $text
}
Write-Host '[3/4] 已写入 rule-providers（域名 + IP 段）' -ForegroundColor Green

# ---------- 写入 rules ----------
$rulesBlock = @"
  - RULE-SET,cn-domain,DIRECT
  - RULE-SET,cn-ipcidr,DIRECT,no-resolve
"@

if ($text -match '(?m)^rules:') {
    $text = $text -replace '(?m)^rules:\r?\n', "rules:`r`n$rulesBlock`r`n"
    Write-Host '[4/4] 已注入中国直连规则到 rules 列表顶部' -ForegroundColor Green
} else {
    Write-Host '[警告] 未找到 rules: 块，请手动添加规则。' -ForegroundColor Yellow
}

# ---------- 保存 ----------
Set-Content -Path $Config -Value $text -Encoding UTF8 -NoNewline

Write-Host ''
Write-Host '====================================' -ForegroundColor Green
Write-Host '  ✓ 安装成功！' -ForegroundColor Green
Write-Host '====================================' -ForegroundColor Green
Write-Host ''
Write-Host '下一步操作：'
Write-Host '  1. 重启 Clash Plus'
Write-Host '  2. Clash Plus 会自动下载规则文件（cn-domain.yaml, cn-ipcidr.yaml）'
Write-Host '  3. 测试抖音等国内应用'
Write-Host ''
Write-Host "如需恢复原配置，请到：$backupDir"
Write-Host ''
Read-Host '按回车退出'

