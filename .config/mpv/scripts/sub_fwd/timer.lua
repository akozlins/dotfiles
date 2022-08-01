--

local mp = require('mp')

local function timer()
    local init

    local time_pos = 0
    local callback = nil

    local on_time_pos = function(_, time)
        if not time or time < time_pos then
            return
        end

        local callback_ = callback
        init(0, nil)
        if callback_ then
            callback_()
        end
    end

    init = function(time_pos_, callback_)
        mp.unobserve_property(on_time_pos)
        time_pos = time_pos_
        callback = callback_
        if callback then
            mp.observe_property("time-pos", "number", on_time_pos)
        end
    end

    return init
end

return timer
