--

local mp = require('mp')
local msg = require('mp.msg')
local sub = require('sub')

local speed = 1.0
local time_sub_start = nil
local time_sub_end = 0

local function info(message)
    msg.info("(" .. mp.get_property_number("time-pos", 0) .. ") " .. message)
end

local function on_sub_end(_, sub_end)
    local sub_delay = sub.get_sub_delay(1)
--    info("sub_delay = " .. (sub_delay or "nil"))

    if not sub_end and not sub_delay then
        time_sub_start = nil
        time_sub_end = nil
        return
    end

    time_sub_end = sub_end or 0

    if sub_delay then
        time_sub_start = mp.get_property_number("time-pos") + sub_delay
    end

    info("time_sub_end = " .. (time_sub_end or "nil"))
    info("time_sub_start = " .. (time_sub_start or "nil"))
end

local function on_time_pos(_, time_pos)
    if time_sub_start and time_sub_end and time_sub_end < time_pos and time_pos < time_sub_start then
        if speed == 1 then
            speed = 2
            mp.set_property("speed", speed * mp.get_property_number("speed"))
            info("speed = " .. mp.get_property_number("speed"))
        end
    else
        if speed > 1 then
            mp.set_property("speed", mp.get_property_number("speed") / speed)
            info("speed = " .. mp.get_property_number("speed"))
            speed = 1
        end
    end
end

mp.register_event("file-loaded", function()
    mp.set_property("demuxer-readahead-secs", 120)

    local active = false

    mp.add_key_binding("shift+U", '', function()
        mp.unobserve_property(on_time_pos)
        mp.unobserve_property(on_sub_end)
        active = not active
        if active then
            mp.observe_property("time-pos", "number", on_time_pos)
            mp.observe_property("sub-end", "number", on_sub_end)
        end
    end)
end)
