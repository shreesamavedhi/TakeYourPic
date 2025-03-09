--[[
    Button management module
    Handles creation, updating, and navigation of buttons in the UI
]]

----------------------------------- Local helper functions------------------------------------

--- Creates a 2D position mapping for buttons
--- @param buttonVars2D table The button variables table to store positions
--- @param posKey string Key for the position (row or column)
--- @param posVal string Value for the position
local function createBtn2DPos(buttonVars2D, posKey, posVal)
    local min, max
    if buttonVars2D[posKey] == nil then
            min, max = posVal, posVal
    else 
        min = buttonVars2D[posKey][1]
        max = buttonVars2D[posKey][2]
        if tonumber(max) < tonumber(posVal) then
            max = posVal
        end
        if tonumber(min) > tonumber(posVal) then
            min = posVal
        end
    end
    buttonVars2D[posKey] = {min, max}
end

--- Creates a new button instance
--- @param text string Button display text
--- @param position table {x, y} coordinates for the button
--- @param fn function Callback function when button is activated (return key)
--- @param rFn function Callback function when button is activated (right key)
--- @param lFn function Callback function when button is activated (left key)
--- @param buttonVars table Button variables including state
local function newButton(text, position, fn, rFn, lFn, buttonVars)
    createBtn2DPos(buttonVars.BtnR2C, tostring(position[1]), tostring(position[2]))
    createBtn2DPos(buttonVars.BtnC2R, tostring(position[2]), tostring(position[1]))
    return {
        position = position,
        text = text,
        enterFn = fn,
        rightFn = rFn,
        leftFn = lFn,
        hot = position == buttonVars.BtnOrder,
    }
end

--- Unpacks position values for button navigation
--- @param type string Type of position ("R2C" or "C2R")
--- @param buttonVars table Button variables including state
--- @param condition number Index to access (1 for min, 2 for max)
local function unpackPos(type, buttonVars, condition)
    if type == "R2C" then
        return tonumber(buttonVars.BtnR2C[tostring(buttonVars.BtnOrder[1])][condition])
    end
    if type == "C2R" then
        return tonumber(buttonVars.BtnC2R[tostring(buttonVars.BtnOrder[2])][condition])
    end
end

-- Button navigation helper functions
local function btnUp(buttonVars)
    if buttonVars.BtnOrder[2] < unpackPos("R2C", buttonVars, 2) then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] + 1
    end
end

local function btnDown(buttonVars)
    if buttonVars.BtnOrder[2] > unpackPos("R2C", buttonVars, 1) then
        buttonVars.BtnOrder[2] = buttonVars.BtnOrder[2] - 1
    end
end

local function btnRight(buttonVars)
    if buttonVars.BtnOrder[1] < unpackPos("C2R", buttonVars, 2) then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] + 1
    end
end

local function btnLeft(buttonVars)
    if buttonVars.BtnOrder[1] > unpackPos("C2R", buttonVars, 1) then
        buttonVars.BtnOrder[1] = buttonVars.BtnOrder[1] - 1
    end
end

--- Inserts a new button into a named button group
--- @param name string Name of the button group
--- @param text string Button display text
--- @param row number Row position
--- @param col number Column position
--- @param fn function Callback function for enter key
--- @param rFn function Callback function for right key
--- @param lFn function Callback function for left key
local function insertBntList(name, text, row, col, fn, rFn, lFn)
    table.insert(Buttons[name].BtnList, newButton(
        text,
        {row, col},
        fn,
        rFn,
        lFn,
        Buttons[name].BtnVars
    ))
end

------------------------------------ Global Functions-----------------------------------------

--- Creates new button parameters for a named group
--- @param name string Name of the button group
--- @param exitFn function function to exit button group
function NewButtonParams(name, exitFn)
    Buttons[name] = {
        BtnList = {},
        BtnVars = {
            BtnOrder = {0,0},
            BtnC2R = {},
            BtnR2C = {}
        },
        ExitFn = exitFn
    }
end

function InsertRetBtnList(name, text, row, col, fn)
    insertBntList(name, text, row, col, fn, EmptyButtonFunction, EmptyButtonFunction)
end

function InsertRLBtnList(name, text, row, col, rFn, lFn)
    insertBntList(name, text, row, col, EmptyButtonFunction, rFn, lFn)
end

function IsKeyForBtnSelect(checkKey)
    local selectKeys = {
        'up', 'right', 'down', 'left', 'return', 'z', 'escape'
    }
    for _, value in pairs(selectKeys) do
        if value == checkKey then
            return true
        end
    end
    return false
end

function IsBtnSelectState()
    if Game.state.paused or Game.state.menu or IsSettingsState() then
        return true
    end
    return false
end

--- Initializes the global Buttons table
function LoadButtons()
    Buttons = {}
    EmptyButtonFunction = function() end
end

--- Updates button states and handles input
--- @param dt number Delta time
--- @param btnGroup string button group type
function UpdateButtons(dt, btnGroup)
    local buttonList = Buttons[btnGroup].BtnList
    local buttonVars = Buttons[btnGroup].BtnVars
    for _, button in ipairs(buttonList) do
        button.hot = button.position[1] == buttonVars.BtnOrder[1] and button.position[2] == buttonVars.BtnOrder[2]
        if not button.hot then
            goto continue
        end

        if IsKeyPressed('up') then 
            btnUp(buttonVars)
            SetKeyPressOff('up')
        end
        if IsKeyPressed('down') then 
            btnDown(buttonVars)
            SetKeyPressOff('down')
        end
        if IsKeyPressed('left') then
            button.leftFn()
            btnLeft(buttonVars)
            SetKeyPressOff('left')
        end
        if IsKeyPressed('right') then
            button.rightFn()
            btnRight(buttonVars)
            SetKeyPressOff('right')
        end
        -- return and z both trigger enterFn
        if IsKeyPressed('return') then
            button.enterFn()
            SetKeyPressOff('return')
        end
        if IsKeyPressed('z') then
            button.enterFn()
            SetKeyPressOff('z')
        end
        -- Escape triggers exitFn
        if IsKeyPressed('escape') then
            Buttons[btnGroup].ExitFn()
            SetKeyPressOff('escape')
        end

        ::continue::
    end
end
