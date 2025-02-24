-- Magic Numbers!
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}
local TEXT_COLOR = {0, 0, 0, 1}
local BUTTON_HEIGHT = 64
local BUTTON_MARGIN = 16
local font = nil

function loadMenu()
    font = love.graphics.newFont("sprites/yoster.ttf", 32)
    -- button menu variables
    menuButtons = {}
    menuVars = {
        BtnOrder = {0, 0},
        BtnX = 0,
        BtnY = 0
    }
    
    -- populate menu buttons
    table.insert(menuButtons, newButton(
        "Say CHEESE!",
        {0, 2},
        function()
            enterGame()
        end,
        menuVars
    ))
    table.insert(menuButtons, newButton(
        "Settings",
        {0, 1},
        function()
            enterSettings()
        end,
        menuVars
    ))
    table.insert(menuButtons, newButton(
        "Exit",
        {0, 0},
        function()
            saveGame()
            love.event.quit(0)
        end,
        menuVars
    ))
end

function updateMenu(dt)
    updateButtons(dt, menuButtons, menuVars)
end

function drawMenu()
    local BUTTON_WIDTH = screenWidth * 1/3 
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #menuButtons

    for i, button in ipairs(menuButtons) do
        local bx = (screenWidth - BUTTON_WIDTH) / 2
        local by = (screenHeight - TOTAL_HEIGHT) / 2 + ((i - 1) * (BUTTON_HEIGHT + BUTTON_MARGIN))

        local color = BUTTON_COLOR
        if button.hot then
            color = HOT_COLOR
        end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill", 
            bx,
            by,
            BUTTON_WIDTH,
            BUTTON_HEIGHT
        )

        love.graphics.setColor(unpack(TEXT_COLOR))
        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)
        love.graphics.print(
            button.text,
            font,
            bx + ((BUTTON_WIDTH - textW)/2),
            by + ((BUTTON_HEIGHT - textH)/2)
        )
    end
end
