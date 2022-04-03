--

debug_print("window_class = " .. get_window_class())

if ( get_window_class() == "Claws-mail" ) then
    set_window_workspace(get_workspace_count())
end

if ( get_window_class() == "easyeffects" ) then
    set_window_workspace(get_workspace_count())
end

if ( get_window_class() == "Xreader" ) then
    local x, y, w, h = get_monitor_geometry()
    debug_print("set_window_size")
--    set_window_size(w*2/3, h*2/3)
    xywh(w*1/6, h*1/6, w*2/3, h*2/3)
end
