-- require "objects"
-- require "components"
require "states"

function love.load()
    --libraries
    cron = require 'libraries/cron/cron'
    anim8 = require 'libraries/anim8/anim8'
    json = require('libraries/json4lua/json/json')

    --music
    -- mainLoop = love.audio.newSource("music/main.wav", "stream")
    -- goodScoreWav = love.audio.newSource("music/goodScore.wav", "static")
    
    --defaults
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest", "nearest")

    --load all items
    startGame()
    -- loadBackground()
    loadMenu()
    -- loadPlayer()
end

function love.update(dt)
    -- if not mainLoop:isPlaying() then
	-- 	love.audio.play(mainLoop)
	-- end
    -- if game.state.running then
    --     updatePlayer(dt)
    -- end
    -- if game.state.shop then
    --     updateShop(dt)
    -- end
end

function love.draw()
    if game.state.menu then
        drawMenu()
    end
    -- if game.state.running then
        
    -- end
end