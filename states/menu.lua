-- Magic Numbers!
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}
local TEXT_COLOR = {0, 0, 0, 1}
local BUTTON_HEIGHT = 64
local BUTTON_MARGIN = 16
local MENU_FONT = love.graphics.newFont("sprites/yoster.ttf", 32)

function LoadMenu()
    -- button menu variables
    NewButtonParams("menu")
    -- populate menu buttons
    InsertBntList("menu", "Say CHEESE!", 0, 2, function() EnterGame() end)
    InsertBntList("menu", "Settings", 0, 1, function() EnterSettings() end)
    InsertBntList("menu", "Exit", 0, 0, function() SaveGame() love.event.quit(0) end)
end

function UpdateMenu(dt)
    if Game.settingsState ~= true then
        UpdateButtons(dt, Buttons["menu"].BtnList, Buttons["menu"].BtnVars)
    end
end

function DrawMenu()
    local BUTTON_WIDTH = ScreenWidth * 1/3 
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #Buttons["menu"].BtnList

    for i, button in ipairs(Buttons["menu"].BtnList) do
        local bx = (ScreenWidth - BUTTON_WIDTH) / 2
        local by = (ScreenHeight - TOTAL_HEIGHT) / 2 + ((i - 1) * (BUTTON_HEIGHT + BUTTON_MARGIN))

        local color = BUTTON_COLOR
        if button.hot then
            color = HOT_COLOR
        end
        love.graphics.setColor(table.unpack(color))
        love.graphics.rectangle(
            "fill", 
            bx,
            by,
            BUTTON_WIDTH,
            BUTTON_HEIGHT
        )

        love.graphics.setColor(table.unpack(TEXT_COLOR))
        local textW = MENU_FONT:getWidth(button.text)
        local textH = MENU_FONT:getHeight(button.text)
        love.graphics.print(
            button.text,
            MENU_FONT,
            bx + ((BUTTON_WIDTH - textW)/2),
            by + ((BUTTON_HEIGHT - textH)/2)
        )
    end
end
