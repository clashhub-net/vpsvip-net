#!/bin/bash
# VPS 代理一键安装脚本
# 支持: Ubuntu 20.04+ / Debian 11+ / CentOS 8+

set -e

echo "===== VPS 代理一键安装 ====="

# 安装 Docker
if ! command -v docker &> /dev/null; then
    echo "[1/4] 安装 Docker..."
    curl -sSL https://get.docker.com | sh
    systemctl enable docker
    systemctl start docker
else
    echo "[1/4] Docker 已安装"
fi

# 安装 Xray
echo "[2/4] 安装 Xray..."
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh) install

# 配置示例
echo "[3/4] 配置 Xray..."
cat > /etc/XrayR/config.yml << 'EOF'
Log:
  Level: info
  AccessPath: /var/log/XrayR/access.log
  ErrorPath: /var/log/XrayR/error.log
DnsConfigPath: 
  Enable: false
  Listen: 0.0.0.0
  Port: 53
  Domains: []
  DefaultTTL: 3600
InboundConfig:
  Listen: 0.0.0.0
  Port: 62789
  Protocol: dokodemo-door
  StreamSettings:
    network: tcp
OutboundConfig:
  Tag: direct
  Protocol: freedom
  StreamSettings: {}
Route:
  Rules:
    - Type: field
      InboundTag:
        - API
      OutboundTag: API
API:
  Tag: API
  Services:
    - HandlerService
    - LoggerService
    - StatsService
    - ChannalService
Stats: {}
Policy:
  System:
    StatsInboundUplink: true
    StatsInboundDownlink: true
    StatsOutboundUplink: true
    StatsOutboundDownlink: true
EOF

# 启动服务
echo "[4/4] 启动 Xray..."
systemctl enable XrayR
systemctl restart XrayR

echo "===== 安装完成 ====="
echo "请在面板中添加节点配置"
echo "面板地址: http://你的IP:62789"
