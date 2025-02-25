--[[
    Button management module
    Handles creation, updating, and navigation of buttons in the UI
]]

-- Local helper functions

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
        if buttonVars2D[posKey][2] < posVal then
            max = posVal
        end
        if buttonVars2D[posKey][1] > posVal then
            min = posVal
        end
    end
    buttonVars2D[posKey] = {min, max}
end

--- Creates a new button instance
--- @param text string Button display text
--- @param position table {x, y} coordinates for the button
--- @param fn function Callback function when button is activated
--- @param buttonVars table Button variables including state
local function newButton(text, position, fn, buttonVars)
    createBtn2DPos(buttonVars.BtnR2C, tostring(position[1]), tostring(position[2]))
    createBtn2DPos(buttonVars.BtnC2R, tostring(position[2]), tostring(position[1]))
    return {
        position = position,
        text = text,
        fn = fn,
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

-- Global Functions

--- Initializes the global Buttons table
function LoadButtons()
    Buttons = {}
end

--- Updates button states and handles input
--- @param dt number Delta time
--- @param buttonList table List of buttons to update
--- @param buttonVars table Button variables including state
function UpdateButtons(dt, buttonList, buttonVars)
    for i, button in ipairs(buttonList) do
        button.hot = button.position[1] == buttonVars.BtnOrder[1] and button.position[2] == buttonVars.BtnOrder[2]
        if GlobalKeys['up'] then 
            btnUp(buttonVars)
            GlobalKeys['up'] = false
        end
        if GlobalKeys['down'] then 
            btnDown(buttonVars)
            GlobalKeys['down'] = false
        end
        if GlobalKeys['left'] then 
            btnLeft(buttonVars)
            GlobalKeys['left'] = false
        end
        if GlobalKeys['right'] then 
            btnRight(buttonVars)
            GlobalKeys['right'] = false
        end
        if GlobalKeys['return'] and button.hot then
            button.fn()
            GlobalKeys['return'] = false
        end
    end
end

--- Creates new button parameters for a named group
--- @param name string Name of the button group
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

--- Inserts a new button into a named button group
--- @param name string Name of the button group
--- @param text string Button display text
--- @param row number Row position
--- @param col number Column position
--- @param fn function Callback function
function InsertBntList(name, text, row, col, fn)
    table.insert(Buttons[name].BtnList, newButton(
        text,
        {row, col},
        fn,
        Buttons[name].BtnVars
    ))
end
