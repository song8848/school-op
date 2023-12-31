local fs = require "nixio.fs"
local uci = require "luci.model.uci".cursor()
local conffile = "/etc/config/userprofile"

f = SimpleForm("logview", translate("密码管理"), translate("填入算号器算出的密码以及账号，https://www.alipan.com/s/9QFvJ5EJzre获取算号器"))
f.reset = false
f.submit = translate("保存参数")

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

return f
