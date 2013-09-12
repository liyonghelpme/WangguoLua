-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    ---------------
    require "Global.INCLUDE"
    require "MyDia.MainDialog"
    require "MyDia.AllHeroes"
    require "MyDia.AllLevel"
    require "MyDia.AllUser"
    require "MyDia.AllFriend"
    require 'MyDia.Formation'
    
    global.director:runWithScene(mainScene())
end

xpcall(main, __G__TRACKBACK__)
