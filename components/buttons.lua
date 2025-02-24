function loadButtons()
end

function updateButtons(dt, buttons, buttonVars)

    for i, button in ipairs(buttons) do
        button.hot = button.position[1] == buttonVars.BtnOrder[1] and button.position[2] == buttonVars.BtnOrder[2]
        if globalKeys['up'] then 
            btnUp(buttonVars)
            globalKeys['up'] = false
        end
        if globalKeys['down'] then 
            btnDown(buttonVars)
            globalKeys['down'] = false
        end
        if globalKeys['left'] then 
            btnLeft(buttonVars)
            globalKeys['left'] = false
        end
        if globalKeys['right'] then 
            btnRight(buttonVars)
            globalKeys['right'] = false
        end
        if globalKeys['return'] and button.hot then
            button.fn()
            globalKeys['return'] = false
        end
    end
end

function newButton(text, position, fn, buttonVars)
    if buttonVars.BtnX < position[1] then
        buttonVars.BtnX = position[1]
    end
    if buttonVars.BtnY < position[2] then
        buttonVars.BtnY = position[2]
    end
    return {
        position = position,
        text = text,
        fn = fn,
        hot = position == buttonVars.BtnOrder,
    }
end

function btnUp(buttonVars)
    if buttonVars.BtnOrder[2] < buttonVars.BtnY then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] + 1
    end
end

function btnDown(buttonVars)
    if buttonVars.BtnOrder[2] ~= 0 then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] - 1
    end
end

function btnLeft(buttonVars)
    if buttonVars.BtnOrder[1] ~= 0 then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] - 1
    end
end

function btnRight(buttonVars)
    if buttonVars.BtnOrder[1] < buttonVars.BtnX then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] + 1
    end
end
