--[[
    Menu state module
    Handles the main menu interface including button creation, layout, and interaction
]]

-- UI Constants
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}      -- Color for highlighted menu items
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}    -- Default menu button color
local TEXT_COLOR = {0, 0, 0, 1}              -- Menu text color
local BUTTON_HEIGHT = 64                      -- Height of menu buttons
local BUTTON_MARGIN = 16                      -- Margin between menu buttons
local MENU_FONT = love.graphics.newFont("sprites/yoster.ttf", 32)  -- Menu font

--- Initializes the main menu
--- Creates and configures menu buttons with their respective actions
function LoadMenu()
    -- button menu variables
    NewButtonParams("menu", EmptyButtonFunction)
    -- populate menu buttons
    InsertRetBtnList("menu", "Say CHEESE!", 0, 2, function() EnterGame() end)
    InsertRetBtnList("menu", "Settings", 0, 1, function() EnterSettings() end)
    InsertRetBtnList("menu", "Exit", 0, 0, function() SaveGame() love.event.quit(0) end)
end

--- Updates the menu state
--- @param dt number Delta time since last update
function UpdateMenu(dt)
    if Game.state.menu and not Game.state.paused then
        UpdateButtons(dt, "menu")
    end
end

--- Draws the menu interface
--- Renders buttons and handles their visual states
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
