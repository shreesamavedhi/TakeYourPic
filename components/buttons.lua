function LoadButtons()
    Buttons = {}
end

function UpdateButtons(dt, buttonList, buttonVars)
    for i, button in ipairs(buttonList) do
        button.hot = button.position[1] == buttonVars.BtnOrder[1] and button.position[2] == buttonVars.BtnOrder[2]
        if GlobalKeys['up'] then 
            BtnUp(buttonVars)
            GlobalKeys['up'] = false
        end
        if GlobalKeys['down'] then 
            BtnDown(buttonVars)
            GlobalKeys['down'] = false
        end
        if GlobalKeys['left'] then 
            BtnLeft(buttonVars)
            GlobalKeys['left'] = false
        end
        if GlobalKeys['right'] then 
            BtnRight(buttonVars)
            GlobalKeys['right'] = false
        end
        if GlobalKeys['return'] and button.hot then
            button.fn()
            GlobalKeys['return'] = false
        end
    end
end

function NewButton(text, position, fn, buttonVars)
    CreateBtn2DPos(buttonVars, tostring(position[1]), tostring(position[2]))
    return {
        position = position,
        text = text,
        fn = fn,
        hot = position == buttonVars.BtnOrder,
    }
end

function NewButtonParams(name)
    Buttons[name] = {
        BtnList = {},
        BtnVars = {
            BtnOrder = {0,0},
            BtnC2R = {},
            BtnR2C = {}
        }
    }
end

function InsertBntList(name, text, row, col, fn)
    table.insert(Buttons[name].BtnList, NewButton(
        text,
        {row, col},
        fn,
        Buttons[name].BtnVars
    ))
end

function CreateBtn2DPos(buttonVars, posX, posY)
    local min, max
    
    -- BtnC2R
    if buttonVars.BtnC2R[posY] == nil then
        min, max = posX, posX
    else 
        min = buttonVars.BtnC2R[posY][1]
        max = buttonVars.BtnC2R[posY][2]
        if buttonVars.BtnC2R[posY][2] < posX then
            max = posX
        end
        if buttonVars.BtnC2R[posY][1] > posX then
            min = posX
        end
    end
    buttonVars.BtnC2R[posY] = {min, max}
    
    -- BtnR2C
    if buttonVars.BtnR2C[posX] == nil then
        min, max = posY, posY
    else
        min = buttonVars.BtnR2C[posX][1]
        max = buttonVars.BtnR2C[posX][2]
        if buttonVars.BtnR2C[posX][2] < posY then
            max = posY
        end
        if buttonVars.BtnR2C[posX][1] > posY then
            min = posY
        end
    end
    buttonVars.BtnR2C[posX] = {min, max}
end

local function unpackPos(type, buttonVars, condition)
    if type == "R2C" then
        return tonumber(buttonVars.BtnR2C[tostring(buttonVars.BtnOrder[1])][condition])
    end
    if type == "C2R" then
        return tonumber(buttonVars.BtnC2R[tostring(buttonVars.BtnOrder[2])][condition])
    end
end

function BtnUp(buttonVars)
    if buttonVars.BtnOrder[2] < unpackPos("R2C", buttonVars, 2) then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] + 1
    end
end

function BtnDown(buttonVars)
    if buttonVars.BtnOrder[2] > unpackPos("R2C", buttonVars, 1) then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] - 1
    end
end

function BtnRight(buttonVars)
    if buttonVars.BtnOrder[1] < unpackPos("C2R", buttonVars, 2) then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] + 1
    end
end

function BtnLeft(buttonVars)
    if buttonVars.BtnOrder[1] > unpackPos("C2R", buttonVars, 1) then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] - 1
    end
end
