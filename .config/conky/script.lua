--

do
    function conky_ip()
        local r = ''
        local f = io.popen('ip -br link show')
        for line in f:lines() do
            -- show links with state UP or UNKNOWN
            if not line:match('^[^ ]+[ ]+U') then
                goto continue
            end

            local name = line:match('^[^ ]+')
            if not name
               or name == 'lo'
               or string.match(name, '^veth')
            then
                goto continue
            end

            local s = conky_parse(string.format("  %s: ${upspeedf %s} KiB / ${downspeedf %s} KiB", name, name, name))
            if string.len(r) > 0 then r = r .. '\n' end
            r = r .. s

            ::continue::
        end
        f:close()
        return r
    end
end
