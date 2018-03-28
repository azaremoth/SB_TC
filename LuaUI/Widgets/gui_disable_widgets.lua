
function widget:GetInfo()
    return {
        name    = 'Disable Widgets',
        desc    = 'Disable Widgets not needed for Spring Board',
        author  = 'aZaremoth',
        date    = 'May 2011',
        license = 'GNU GPL v2',
        layer   = 1002, -- must go after initial queue, or depthtest is wrong
        enabled = true,
    }
end

function widget:GameFrame(n)
    if n>1 then
		Spring.SendCommands("luaui disablewidget Chili Integral Menu")
		Spring.SendCommands("luaui disablewidget Chili Resource Bars Classic")
		Spring.SendCommands("luaui disablewidget Chili Pro Console2")
		Spring.SendCommands("luaui disablewidget Chili Selections & CursorTip v2")
		Spring.SendCommands("luaui disablewidget Chili Minimap")		
		Spring.SendCommands("luaui disablewidget Context Menu")		
		
        widgetHandler:RemoveWidget(self)
    end
end

