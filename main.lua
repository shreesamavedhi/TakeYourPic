-- require "objects"
require "settings"
require "components"
require "states"

table.unpack = table.unpack or unpack -- 5.1 compatibility

function love.load()
    --libraries
    Cron = require 'libraries/cron/cron'
    Anim8 = require 'libraries/anim8/anim8'
    Json = require 'libraries/json4lua/json/json'

    --user inputs
    LoadKeys()
    LoadButtons()

    --interactive menus
    LoadSettings()
    LoadMenu()

    --music
    LoadMusic()

    --game
    LoadGame()
    LoadSave()
    -- loadBackground()
    -- loadPlayer()
end

function love.update(dt)
    if Game.state.dayCycle or Game.state.nightCycle then
        -- UpdatePlayer(dt)
    end
    UpdateMusic(dt)
    UpdateMenu(dt)
    UpdateSettings(dt)
    
end

function love.draw()
    if Game.state.menu then DrawMenu() end 
    -- if Game.state.dayCycle then DrawDayCycle() end
    -- if Game.state.dayToNight then DrawDayToNight() end
    -- if Game.state.nightCycle then DrawNightCycle() end
    -- if Game.state.nightToDay then DrawNightToDay() end
    if Settings.state.menu then DrawSettings("setting") end
    if Settings.state.audio then DrawSettings("audioSettings") end
    if Settings.state.visual then DrawSettings("visualSettings") end
    if Settings.state.control then DrawSettings("controlSettings") end
    DrawVisualSettings()
end
