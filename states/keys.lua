
function loadKeys()
    keyFunc =
    {
        ['return'] = function() btnEnter() end,
        ['up'] = function() btnUp() end,
        ['down'] = function() btnDown() end,
        ['left'] = function() btnLeft() end,
        ['right'] = function() btnRight() end,
    }
    buttons = {}
    globalOrder = {0, 0}
    globalEnter = false
end

function updateKeys(dt)
    for i, button in ipairs(buttons) do
        if button.order[1] == globalOrder[1] and button.order[2] == globalOrder[2] then
            button.hot = true
        else
            button.hot = false
        end
    end
    
end

function newButton(text, order, fn)
    return {
        order = order,
        text = text,
        fn = fn,
        hot = order == globalOrder,
    }
end

function love.keypressed(key)
    if keyFunc[key] ~= nil then
        keyFunc[key]()
    end
end

function btnEnter()
    globalEnter = true
end

function btnUp()
    if globalOrder[2] ~= #buttons - 1 then
        globalOrder[2] = globalOrder[2] + 1
    end
end

function btnDown()
    if globalOrder[2] ~= 0 then
        globalOrder[2] = globalOrder[2] - 1
    end
end

function btnLeft()
    if globalOrder[1] ~= 0 then
        globalOrder[1] = globalOrder[1] - 1
    end
end

function btnRight()
    if globalOrder[1] ~= #buttons - 1 then
        globalOrder[1] = globalOrder[1] + 1
    end
end
