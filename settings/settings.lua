--[[
    Game settings module
    Manages game configuration including display, audio, and UI settings.
    Provides functionality for adjusting music volume, sound effects, and display resolution.
]]

---------------------------------- UI Constants--------------------------------------------
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}      -- Color for highlighted UI elements
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}    -- Default button color
local TEXT_COLOR = {0, 0, 0, 1}              -- Default text color
local BUTTON_HEIGHT = 30                      -- Height of UI buttons
local BUTTON_MARGIN = 2                       -- Margin between UI elements
local SETTING_FONT = love.graphics.newFont("sprites/yoster.ttf", 12)  -- Font for settings UI

------------------------------ Local helper functions-------------------------------------

--- Creates and configures the settings menu buttons
local function loadSettingButtons()
    -- button setting variables
    NewButtonParams("setting", function() ExitSettings() end)
    -- populate setting buttons
    InsertRetBtnList("setting", "Audio", 0, 3, function() ChangeSettingsState("audio") end)
    InsertRetBtnList("setting", "Visual", 0, 2, function() ChangeSettingsState("visual") end)
    InsertRetBtnList("setting", "Controls", 0, 1, function() ChangeSettingsState("control") end)
    InsertRetBtnList("setting", "Back", 0, 0, function() ExitSettings() end)
end

---------------------------------- Global settings functions----------------------------------

--- Enters the settings menu state
function EnterSettings()
    Settings.state.menu = true
    Game.state.paused = true
end

--- Exits the settings menu state
function ExitSettings()
    Settings.state.menu = false
    Game.state.paused = false
end

--- Updates the settings state to a new state
--- Sets the corresponding state flag to true and all others to false
function ChangeSettingsState(state)
    Settings.state.menu = state == "menu"
    Settings.state.audio = state == "audio"
    Settings.state.visual = state == "visual"
    Settings.state.control = state == "control"
end

--- Initializes the global settings table and UI elements
--- Sets up default values for display resolution, volumes, and key bindings
function LoadSettings()
    Settings = {
        state = {
            ["menu"] = false,
            ["audio"] = false,
            ["control"] = false,
            ["visual"] = false
        }
    }
    loadSettingButtons()
    LoadAudioSettings()
    LoadVisualSettings()
    LoadControlSettings()
end

--- Updates the settings menu state
--- @param dt number Delta time since last update
function UpdateSettings(dt)
    if Settings.state.menu then
        UpdateButtons(dt, "setting")
    end
    if Settings.state.audio then
        UpdateAudioSettings(dt)
    end
    if Settings.state.visual then
        UpdateVisualSettings(dt)
    end
    if Settings.state.control then
        UpdateControlSettings(dt)
    end
end

--- Draws the settings menu interface
--- Renders buttons and current settings values
--- @param btnClass string Temporary var to draw settings for each type
function DrawSettings(btnClass)
    local BUTTON_WIDTH = ScreenWidth * 1/8
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #Buttons[btnClass].BtnList

    for i, button in ipairs(Buttons[btnClass].BtnList) do
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
        local textW = SETTING_FONT:getWidth(button.text)
        local textH = SETTING_FONT:getHeight(button.text)
        love.graphics.print(
            button.text,
            SETTING_FONT,
            bx + ((BUTTON_WIDTH - textW)/2),
            by + ((BUTTON_HEIGHT - textH)/2)
        )
    end
end