
------------------------------ Local helper functions-------------------------------------

--- Adjusts the display resolution settings
--- @param plus boolean True to increase resolution, false to decrease
local function editResolutionSettings(plus)
    local currentIndex = 1
    -- Find current resolution index
    for i, res in ipairs(Resolutions) do
        if res[1] == Settings.visual.resolution.width and res[2] == Settings.visual.resolution.height then
            currentIndex = i
            break
        end
    end

    -- Adjust index based on direction
    if plus and currentIndex < #Resolutions then
        currentIndex = currentIndex + 1
    elseif not plus and currentIndex > 1 then
        currentIndex = currentIndex - 1
    end

    -- Update resolution
    Settings.visual.resolution.width = Resolutions[currentIndex][1]
    Settings.visual.resolution.height = Resolutions[currentIndex][2]
    
    -- Apply new resolution
    love.window.setMode(Settings.visual.resolution.width, Settings.visual.resolution.height)
    -- Update screen dimensions
    ScreenWidth = love.graphics.getWidth()
    ScreenHeight = love.graphics.getHeight()
end


local function editDisplaySettings(plus)
    Settings.visual.fullscreen = plus
    love.window.setMode(Settings.visual.resolution.width, Settings.visual.resolution.height, {
        fullscreen = Settings.visual.fullscreen,
        resizable  = true
    })
end

local function editVsyncSettings(plus)
    Settings.visual.vsync = plus
    love.window.setMode(Settings.visual.resolution.width, Settings.visual.resolution.height, {
        vsync = Settings.visual.vsync,
    })
end

local function editBrightnessSettings(plus)
    if plus then
        Settings.visual.brightness = math.min(Settings.visual.brightness + 0.1, 1)
    else
        Settings.visual.brightness = math.max(Settings.visual.brightness - 0.1, 0.5)
    end
end

--- Initializes the list of available display resolutions
local function loadDisplayList()
    Resolutions = {
        [1] = {1280, 720}, -- HD
        [2] = {1920, 1080}, -- Full HD
        [3] = {2560, 1440}, -- 2K
        [4] = {3840, 2160}, -- 4K
    }
end

---------------------------------- Global settings functions----------------------------------

function ExitVisualSettings()
    ChangeSettingsState("menu")
end

function LoadVisualSettings()
    --defaults
    ScreenWidth = love.graphics.getWidth()
    ScreenHeight = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Visual variables
    loadDisplayList()
    Settings.visual = {
        resolution = {
            width = 2646,
            height = 1024,
        },
        fullscreen = false,
        vsync = true,
        brightness = 1,
    }
    
    -- Buttons
    NewButtonParams("visualSettings", function() ExitVisualSettings() end)
    InsertRLBtnList("visualSettings", "Resolution", 0, 4, function() editResolutionSettings(true) end, function() editResolutionSettings(false) end)
    InsertRLBtnList("visualSettings", "Display", 0, 3, function() editDisplaySettings(true) end, function() editDisplaySettings(false) end)
    InsertRLBtnList("visualSettings", "Vsync", 0, 2, function() editVsyncSettings(true) end, function() editVsyncSettings(false) end)
    InsertRLBtnList("visualSettings", "Brightness", 0, 1, function() editBrightnessSettings(true) end, function() editBrightnessSettings(false) end)
    InsertRetBtnList("visualSettings", "Back", 0, 0, function() ExitVisualSettings() end)
end

function UpdateVisualSettings(dt)
    UpdateButtons(dt, "visualSettings")
end

-- draws brightness shader
function DrawVisualSettings()
    -- Draw brightness overlay
    local brightnessValue = 1 - Settings.visual.brightness
    love.graphics.setColor(0, 0, 0, brightnessValue)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
end