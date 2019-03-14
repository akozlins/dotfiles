
do
    function conky_ip()
        local r = ''
        local f = io.popen('ip link show up')
        for line in f:lines() do
            local name = line:match("^[0-9]+: ([^:]+):")
            if name and not ( name == 'lo' ) then
                local s = conky_parse(string.format("  %s: ${upspeedf %s} KiB / ${downspeedf %s} KiB", name, name, name))
                if string.len(r) > 0 then r = r .. '\n' end
                r = r .. s
            end
        end
        f:close()
        return r
    end

end
