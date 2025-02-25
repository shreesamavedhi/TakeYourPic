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

--- Adjusts the master volume level
--- @param plus boolean True to increase volume, false to decrease
local function editMasterVolSettings(plus)
    if plus and Settings.volumes.MasterVolume < 1 then
        Settings.volumes.MasterVolume = Settings.volumes.MasterVolume + 0.25
    end
end

--- Adjusts the music volume level
--- @param plus boolean True to increase volume, false to decrease
local function editMusicSettings(plus)
    if plus and Settings.volumes.MusicVolume < 1 then
        Settings.volumes.MusicVolume = Settings.volumes.MusicVolume + 0.25
    end
end

--- Adjusts the sound effects volume level
--- @param plus boolean True to increase volume, false to decrease
local function editSoundSettings(plus)
    if plus and Settings.volumes.SoundVolume < 1 then
        Settings.volumes.SoundVolume = Settings.volumes.SoundVolume + 0.25
    end
end

--- Adjusts the display resolution settings
--- @param plus boolean True to increase resolution, false to decrease
local function editDisplaySettings(plus)
    local currentIndex = 1
    -- Find current resolution index
    for i, res in ipairs(DisplayResolutions) do
        if res[1] == Settings.displayResolution.width and res[2] == Settings.displayResolution.height then
            currentIndex = i
            break
        end
    end

    -- Adjust index based on direction
    if plus and currentIndex < #DisplayResolutions then
        currentIndex = currentIndex + 1
    elseif not plus and currentIndex > 1 then
        currentIndex = currentIndex - 1
    end

    -- Update resolution
    Settings.displayResolution.width = DisplayResolutions[currentIndex][1]
    Settings.displayResolution.height = DisplayResolutions[currentIndex][2]
    
    -- Apply new resolution
    love.window.setMode(Settings.displayResolution.width, Settings.displayResolution.height)
    -- Update screen dimensions
    ScreenWidth = love.graphics.getWidth()
    ScreenHeight = love.graphics.getHeight()
end

--- Creates and configures the settings menu buttons
local function loadSettingButtons()
    -- button setting variables
    NewButtonParams("setting")
    -- populate setting buttons
    InsertBntList("setting", "PlusMaster", 1, 4, function() editMasterVolSettings(true) end)
    InsertBntList("setting", "MinusMaster", 0, 4, function() editMasterVolSettings(false) end)
    InsertBntList("setting", "PlusMusic", 1, 3, function() editMusicSettings(true) end)
    InsertBntList("setting", "MinusMusic", 0, 3, function() editMusicSettings(false) end)
    InsertBntList("setting", "PlusSounds", 1, 2, function() editSoundSettings(true) end)
    InsertBntList("setting", "MinusSounds", 0, 2, function() editSoundSettings(false) end)
    InsertBntList("setting", "PlusDisplay", 1, 1, function() editDisplaySettings(true) end)
    InsertBntList("setting", "MinusDisplay", 0, 1, function() editDisplaySettings(false) end)
    InsertBntList("setting", "Exit", 0, 0, function() ExitSettings() end)
end

---------------------------------- Global settings functions----------------------------------

--- Initializes the global settings table and UI elements
--- Sets up default values for display resolution, volumes, and key bindings
function LoadSettings()
    Settings = {
        startSettings = false,
        keyBindings = {
            --TODO: empty for now
        },
        displayResolution = {
            -- TODO: default for now
            width = 2646,
            height = 1024,
        },
        volumes = {
            -- TODO: default for now
            MasterVolume = 0.5, -- Maximum volume for all sounds
            MusicVolume = 1,
            SoundVolume = 0.75
        }
    }
    Font = love.graphics.newFont("sprites/yoster.ttf", 32)
    loadSettingButtons()
    LoadDisplayList()
end

--- Updates the settings menu state
--- @param dt number Delta time since last update
function UpdateSettings(dt)
    if Settings.startSettings then
        UpdateButtons(dt, Buttons["setting"].BtnList, Buttons["setting"].BtnVars)
    end
end

--- Draws the settings menu interface
--- Renders buttons and current settings values
function DrawSettings()
    local BUTTON_WIDTH = ScreenWidth * 1/8
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #Buttons["setting"].BtnList

    for i, button in ipairs(Buttons["setting"].BtnList) do
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

--- Enters the settings menu state
function EnterSettings()
    Settings.startSettings = true
    Game.settingsState = true
end

--- Exits the settings menu state
function ExitSettings()
    Settings.startSettings = false
    Game.settingsState = false
end

--- Initializes the list of available display resolutions
function LoadDisplayList()
    DisplayResolutions = {
        [1] = {1280, 720}, -- HD
        [2] = {1920, 1080}, -- Full HD
        [3] = {2560, 1440}, -- 2K
        [4] = {3840, 2160}, -- 4K
    }
end