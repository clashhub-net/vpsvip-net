# Xray 配置指南

## 配置文件位置
- 主配置: `/etc/XrayR/config.yml`
- 日志: `/var/log/XrayR/`

## 常用命令
```bash
# 查看状态
systemctl status XrayR

# 重启
systemctl restart XrayR

# 查看日志
tail -f /var/log/XrayR/access.log
```

## 面板推荐
- [XrayR](https://github.com/XrayR-project/XrayR) - 推荐
- [3x-ui](https://github.com/mhsanaei/3x-ui)
- [X-UI](https://github.com/alaskadrawal/X-ui)

## 协议选择
| 协议 | 速度 | 兼容性 | 推荐场景 |
|------|------|--------|----------|
| VMESS | 快 | 好 | 首选 |
| VLESS | 最快 | 较好 | 高速 |
| Trojan | 快 | 较好 | 敏感线路 |
| Shadowsocks | 快 | 一般 | 备用 |

## 优化建议
1. 开启 BBR 加速
2. 选择合适的中转线路
3. 定期更新规则
