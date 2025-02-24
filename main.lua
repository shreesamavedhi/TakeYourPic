-- require "objects"
require "components"
require "states"

function love.load()
    --libraries
    cron = require 'libraries/cron/cron'
    anim8 = require 'libraries/anim8/anim8'
    json = require 'libraries/json4lua/json/json'

    --music
    -- mainLoop = love.audio.newSource("music/main.wav", "stream")
    -- goodScoreWav = love.audio.newSource("music/goodScore.wav", "static")
    
    --defaults
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")

    --load all items
    loadGame()
    loadSave()
    loadKeys()
    -- loadBackground()
    loadMenu()
    -- loadPlayer()
end

function love.update(dt)
    -- updateButtons(dt)
    -- updateKeys(dt)
    -- if not mainLoop:isPlaying() then
	-- 	love.audio.play(mainLoop)
	-- end
    if game.state.dayCycle or game.state.nightCycle then
        updatePlayer(dt)
    end
    if game.state.menu then
        updateMenu(dt)
    end
end

function love.draw()
    if game.state.menu then drawMenu() end 
    if game.state.dayCycle then drawDayCycle() end
    if game.state.dayToNight then drawDayToNight() end
    if game.state.nightCycle then drawNightCycle() end
    if game.state.nightToDay then drawNightToDay() end
    if game.settingsState then drawSettings() end
end
