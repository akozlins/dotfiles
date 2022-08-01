--

-- <https://github.com/Ajatt-Tools/sub-transition>

local mp = require('mp')
local msg = require('mp.msg')
local timer = require('timer')
local sub = require('sub')

local speed = 1.0

local function info(message)
    msg.info("(" .. mp.get_property_number("time-pos", 0) .. ") " .. message)
end

local timers = {
    on_sub_start = timer(),
    on_sub_end = timer(),
    on_sub = timer(),
}

local function timers_reset()
    for _, timer in pairs(timers) do
        timer(0, nil)
    end
end

local function check()
    local time_pos = mp.get_property_number("time-pos", 0)

    local sub_delay = sub.get_sub_delay(1)
--    info("sub_delay = " .. (sub_delay or "nil"))
    if not sub_delay then
        timers_reset()
        timers.on_sub(time_pos + 0.5, check)

        if speed > 1 then
            mp.set_property("speed", mp.get_property_number("speed") / speed)
            info("speed = " .. mp.get_property_number("speed"))
            speed = 1
        end

        return
    end

    if mp.get_property_native("sub-end") then
        return
    end

    local time_sub_end = time_pos + 0.1
    local time_sub_start = time_pos + sub_delay - 0.1
    if time_sub_start - time_sub_end < 0.5 then
        return
    end

    timers.on_sub_end(time_sub_end, function()
        info("on_sub_end");
        if speed == 1 then
            speed = 2
            mp.set_property("speed", speed * mp.get_property_number("speed"))
            info("speed = " .. mp.get_property_number("speed"))
        end
    end)
    timers.on_sub_start(time_sub_start, function()
        info("on_sub_start");
        if speed > 1 then
            mp.set_property("speed", mp.get_property_number("speed") / speed)
            info("speed = " .. mp.get_property_number("speed"))
            speed = 1
        end
    end)
end

local main = (function()
    local ok = false

    local function on_file_loaded()
        info("on_file_load")
        if not ok then
            mp.set_property("demuxer-readahead-secs", 120)
            mp.observe_property("sub-end", "number", check)
            ok = true
        end
        check()
    end

    return {
        on_file_loaded = on_file_loaded,
    }
end)()

mp.register_event("file-loaded", main.on_file_loaded)
