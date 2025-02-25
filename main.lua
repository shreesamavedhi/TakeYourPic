-- require "objects"
require "components"
require "states"

table.unpack = table.unpack or unpack -- 5.1 compatibility

function love.load()
    --libraries
    cron = require 'libraries/cron/cron'
    anim8 = require 'libraries/anim8/anim8'
    json = require 'libraries/json4lua/json/json'

    --music
    LoadMusic()
    
    --defaults
    ScreenWidth = love.graphics.getWidth()
    ScreenHeight = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")

    --load all items
    LoadGame()
    LoadSave()
    LoadKeys()
    -- loadBackground()
    LoadButtons()
    LoadSettings()
    LoadMenu()
    -- loadPlayer()
end

function love.update(dt)
    UpdateMusic(dt)
    if Game.state.dayCycle or Game.state.nightCycle then
        -- UpdatePlayer(dt)
    end
    if Game.state.menu then
        UpdateMenu(dt)
    end
    if Game.settingsState then
        UpdateSettings(dt)
    end
end

function love.draw()
    if Game.state.menu then DrawMenu() end 
    -- if Game.state.dayCycle then DrawDayCycle() end
    -- if Game.state.dayToNight then DrawDayToNight() end
    -- if Game.state.nightCycle then DrawNightCycle() end
    -- if Game.state.nightToDay then DrawNightToDay() end
    if Game.settingsState then DrawSettings() end
end
