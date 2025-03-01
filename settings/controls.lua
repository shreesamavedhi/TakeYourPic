
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
            lock = "c",
            dash = "leftShift"
        }
    }
    NewButtonParams("controlSettings", function() ExitControlSettings() end)
    InsertRetBtnList("controlSettings", "Back", 0, 0, function() ExitControlSettings() end)
end

function UpdateControlSettings(dt)
    UpdateButtons(dt, "controlSettings")
end

function DrawControlSettings()
end