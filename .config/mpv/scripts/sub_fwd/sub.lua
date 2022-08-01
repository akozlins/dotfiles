--

local mp = require('mp')

local function get_sub_delay(i)
    local sub_delay = mp.get_property_native("sub-delay") or 0
    local sub_visibility = mp.get_property_bool("sub-visibility")
    mp.set_property_bool("sub-visibility", false)
    mp.commandv("no-osd", "sub-step", i)
    local next_sub_delay = mp.get_property_native("sub-delay") or 0
    mp.set_property_number("sub-delay", sub_delay)
    mp.set_property_bool("sub-visibility", sub_visibility)
    if sub_delay > next_sub_delay then 
        return sub_delay - next_sub_delay
    else
        return nil
    end
end

return {
    get_sub_delay = get_sub_delay,
}
