# school-op

注意：全部下载好后执行
```terminal
sudo sed -i 's/option rebind_protection 1/option rebind_protection 0/' lede/package/network/services/dnsmasq/files/dhcp.conf
```
# UA2F

“Network”>>“Routing and Redirection”>>"ua2f"

# 其他

关闭autoreboot

# Passwall

```terminal
src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main
src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main
```
