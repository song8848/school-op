local fs = require "nixio.fs"
local uci = require "luci.model.uci".cursor()
local conffile = "/etc/config/autoshell"

f = SimpleForm("logview", translate("web抓包认证"), translate([[
在这里粘贴你抓包的curl，系统将自动生成对应请求脚本并实时保持网络在线。
1. 打开 Microsoft Edge 浏览器并导航到需要进行登录的网页（校园网认证页）。
2. 按下 `F12` 键或右键点击页面上的任何元素，然后选择“检查”选项来打开开发者工具。
3. 在开发者工具窗口中，切换到“网络”选项卡。在开发者工具的“网络”选项卡中勾选保留日志。
4. 在浏览器中进行登录操作，填写用户名和密码，并点击登录按钮。
5. 您将看到网页加载过程中的所有网络请求和响应信息。
6. 找到包含登录请求的条目，通常是名为“login”、“signin”或类似的条目（如果找不到就选第一个条目）。右键该条目以复制我们要的 curl（cmd）内容。
将 curl 粘贴到此处，点击下方“保存抓包”，然后就可以点击生成脚本了，创建成功后就可以启动脚本开始认证了。
请注意，Microsoft Edge 开发者工具的界面可能因不同版本而有所不同，但通常您应该能够在“网络”选项卡中找到登录请求并获取相应的 cURL 命令。
记住：在复制curl时不要搞错，一定选择复制curl（cmd），否则脚本可能无法发送正确请求在下面输入框输入“禁用”并保存可以停用认证功能，届时重启后将不再进行自动认证以及网络守护【仍然可以手动认证】。
第一次使用：将 curl 粘贴在下面，依次点击“保存抓包”，“生成脚本”，“开始认证”。详细图文教程：https://docs.qq.com/doc/DWWRCdWxvSUt3TkxT
]]))


f.reset = false
f.submit = translate("保存抓包")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
    local value = fs.readfile(conffile)
    return value or ""
end
function t.write(self, section, value)
    if value then
        fs.writefile(conffile, value)
    end
end

btn_generate = f:field(Button, "generate", "")
btn_generate.inputtitle = "生成脚本"

function btn_generate.write()
    local scriptExist = luci.sys.call("[ -f /etc/autoshell.sh ]") == 0
    if scriptExist then
        luci.http.write('<script>alert("脚本已更新！！");</script>')
        os.execute("sh /etc/autoshells.sh")
    else
        luci.http.write('<script>alert("脚本创建成功！！");</script>')
        os.execute("sh /etc/autoshells.sh")
    end
end

local pid = luci.sys.exec("pgrep -f '/etc/autoshell.sh'")

if pid == "" then
    btn_authenticate = f:field(Button, "authenticate", "")
    btn_authenticate.inputtitle = "开始认证"

    function btn_authenticate.write()
        luci.http.redirect(luci.dispatcher.build_url("admin", "services", "webauto"))
        os.execute("sh /etc/autoshell.sh &")
    end
else
    btn_stop = f:field(Button, "stop", "")
    btn_stop.inputtitle = "停止脚本"

    function btn_stop.write()
        os.execute("killall sh /etc/autoshell.sh")
        luci.http.redirect(luci.dispatcher.build_url("admin", "services", "webauto"))
    end
end

return f
