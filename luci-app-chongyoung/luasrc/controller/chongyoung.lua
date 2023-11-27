--[[
module("luci.controller.chongyoung", package.seeall)

function index()
    entry({"admin", "school", "chongyoung"}, alias("admin", "school", "chongyoung", "settings"), _("飞young"), 100).index = true
    entry({"admin", "school", "chongyoung", "settings"}, cbi("chongyoung"), _("认证设置"), 1)
    entry({"admin", "school", "chongyoung", "passwd"}, cbi("chongyoung2"), _("密码管理"), 2)
    entry({"admin", "school", "chongyoung", "log"}, cbi("chongyoung_log"), _("认证日志"), 3)
end

--]]

-- 导入 LuCI 控制器和包
module("luci.controller.chongyoung", package.seeall)

-- 定义路由器控制器的入口函数
function index()
    -- 配置路由器页面入口，包括别名、标题和权重
    entry({"admin", "network", "chongyoung"}, alias("admin", "network", "chongyoung", "settings"), _("飞young"), 100).index = true
    
    -- 配置认证设置页面入口
    entry({"admin", "network", "chongyoung", "settings"}, cbi("chongyoung"), _("认证设置"), 1)
    
    -- 配置密码管理页面入口
    entry({"admin", "network", "chongyoung", "passwd"}, cbi("chongyoung2"), _("密码管理"), 2)
    
    -- 配置认证日志页面入口
    entry({"admin", "network", "chongyoung", "log"}, cbi("chongyoung_log"), _("认证日志"), 3)
end

