-- Magic Numbers!
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}
local TEXT_COLOR = {0, 0, 0, 1}
local BUTTON_HEIGHT = 64
local BUTTON_MARGIN = 16
local font = nil

function loadMenu()
    font = love.graphics.newFont("sprites/yoster.ttf", 32)
    table.insert(buttons, newButton(
        "Say CHEESE!",
        {0, 2},
        function()
            -- enterGame()
        end
    ))
    table.insert(buttons, newButton(
        "Settings",
        {0, 1},
        function()
            -- settings()
        end
    ))
    table.insert(buttons, newButton(
        "Exit",
        {0, 0},
        function()
            love.event.quit(0)
        end
    ))
end

function updateMenu(dt)
    for i, button in ipairs(buttons) do
        if globalEnter and button.hot then
            button.fn()
        end
    end
end

function drawMenu()
    local BUTTON_WIDTH = screenWidth * 1/3 
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #buttons

    for i, button in ipairs(buttons) do
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
