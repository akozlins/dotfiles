
do
    function conky_ip()
        local r = ''
        local f = io.popen('ip -br link show')
        for line in f:lines() do
            if not line:match('^[^ ]+ +UP') then
                goto continue
            end

            local name = line:match('^[^ ]+')
            if not name
               or name == 'lo'
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
