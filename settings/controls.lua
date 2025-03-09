
------------------------------ Local helper functions-------------------------------------

local function resetDefaults()
    local defaults = {
        moveUp = "up",
        moveDown = "down",
        moveLeft = "left",
        moveRight = "right",
        jump = "space",
        shoot = "x",
        switchCamera = "tab",
        backpack = "b",
        lock = "c",
        dash = "leftShift"
    }
    Settings.control.keyBindings = defaults
end

local function newKeyBind(key)
    Settings.control.bindKey = key
    StartWaitingForKey()
end

---------------------------------- Global settings functions----------------------------------

function ExitControlSettings()
    ChangeSettingsState("menu")
end

function LoadControlSettings()
    Settings.control = {
        -- this is mapped from action -> key
        keyBindings = {
            moveUp = "up",
            moveDown = "down",
            moveLeft = "left",
            moveRight = "right",
            jump = "space",
            shoot = "x",
            switchCamera = "tab",
            backpack = "b",
            lock = "c",
            dash = "leftShift"
        },
        bindKey = nil
    }
    -- button control variables
    NewButtonParams("controlSettings", function() ExitControlSettings() end)
    -- populate control buttons
    InsertRetBtnList("controlSettings", "Move Up", 0, 10, function() newKeyBind("moveUp") end)
    InsertRetBtnList("controlSettings", "Move Down", 0, 9, function() newKeyBind("moveDown") end)
    InsertRetBtnList("controlSettings", "Move Left", 0, 8, function() newKeyBind("moveLeft") end)
    InsertRetBtnList("controlSettings", "Move Right", 0, 7, function() newKeyBind("moveRight") end)
    InsertRetBtnList("controlSettings", "Jump", 0, 6, function() newKeyBind("jump") end)
    InsertRetBtnList("controlSettings", "Shoot", 0, 5, function() newKeyBind("shoot") end)
    InsertRetBtnList("controlSettings", "Lock", 0, 4, function() newKeyBind("lock") end)
    InsertRetBtnList("controlSettings", "Dash", 0, 3, function() newKeyBind("dash") end)
    InsertRetBtnList("controlSettings", "Switch Camera", 0, 2, function() newKeyBind("switchCamera") end)
    InsertRetBtnList("controlSettings", "Backpack", 0, 1, function() newKeyBind("backpack") end)
    InsertRetBtnList("controlSettings", "Reset Defaults", 1, 0, function() resetDefaults() end)
    InsertRetBtnList("controlSettings", "Done", 0, 0, function() ExitControlSettings() end)
end

function IsBindMode()
    if Settings.control.bindKey ~= nil then
        return true
    end
    return false
end

function IsKeyBind(bind)
    for k, v in pairs(Settings.control.keyBindings) do
        if v == bind then
            return true, k
        end
    end
    return false, nil
end

function IsKeyBindPressed(keyBind)
    return IsKeyPressed(Settings.control.keyBindings[keyBind])
end

function UpdateKeyBind(dt)
    local result = CheckKeyPress()
    if result == false or result == nil then
        return 
    end
    local alreadyBound, otherKey = IsKeyBind(result)
    if alreadyBound then
        Settings.control.keyBindings[otherKey] = nil
    end
    Settings.control.keyBindings[Settings.control.bindKey] = result
    Settings.control.bindKey = nil
end

function UpdateControlSettings(dt)
    if IsBindMode() then
        UpdateKeyBind(dt)
    else
        UpdateButtons(dt, "controlSettings")
    end
end

function DrawControlSettings()
end
