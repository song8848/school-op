m = Map("autoua2f", translate("多设备防检测"))
m.description = translate([[
        <span style="font-family: '微软雅黑'; color: red">任何因自行修改配置导致的无法使用，不包售后</span><br>
	<span style="font-family: '微软雅黑'; color: red">此插件并非适合所有校园网，有多设备检测的才需要开启此插件</span><br>
	<span style="font-family: '微软雅黑'; color: red">校园网建议自行开启“开机自启”并“保存&应用”，连接网络后点击下面测试网址，伪装成功的UA应全是“F”</span><br>
        <span style="font-family: '微软雅黑'; color: red">校园网用户，“DHCP/DNS”里面的选项不要修改，其他设置也不要随意变动！！！</span><br>
        <span style="font-family: '微软雅黑'; color: yellow"><a href="http://ua.233996.xyz/" target="_blank">点击此处跳转到测试网址</a></span>
    ]])

e = m:section(TypedSection, "autoua2f", translate(""))
e.addremove = false
e.anonymous = true

o1 = e:option(Flag, "enabled", translate("启用/开机自启"))
o1.rmempty = false

o2 = e:option(Flag, "handle_fw", translate("自动配置防火墙"), translate("是否自动添加防火墙规则"))
o2.rmempty = false


o3 = e:option(Flag, "handle_intranet", translate("处理内网流量"), translate("是否处理内网流量，如果你的路由器是在内网中，且你想要处理内网中的流量，那么请启用这一选项"))
o3.rmempty = false

o4 = e:option(Flag, "handle_tls", translate("处理443端口流量"), translate("通常来说，流经 443 端口的流量是加密的，因此无需处理"))
o4.rmempty = false

o5 = e:option(Flag, "handle_mmtls", translate("处理微信流量"), translate("微信的流量通常是加密的，因此无需处理，这一规则在启用 nftables 时无效"))
o5.rmempty = false

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/autoua2f start")
end

return m
