function loadGame()
    game = {
        days = 0,
        pictures = {},
        state = {
            ["menu"] = true,
            ["dayCycle"] = false,
            ["nightCycle"] = false,
            -- DayToNight and NightToDay are loading/transition scenes
            ["dayToNight"] = false,
            ["nightToDay"] = false,
        },
        settingsState = false
    }
end

function loadSave()
    if love.filesystem.getInfo("saveGame.lua") then
        jsonData = love.filesystem.read("saveGame.lua")
        data = json.decode(jsonData)
        print(data)
        -- Note: State is saved right before returning to menu
        game = {
            pictures = data.pictures,
            days = data.days,
            state = data.state
        }
        love.graphics.clear()
    end
end

function enterGame()
    if game.state.nightCycle then
        changeGameState("nightCycle")
    else
        changeGameState("dayCycle")
    end
    love.graphics.clear()
end

function changeGameState(state)
    game.state.menu = state == "menu"
    game.state.dayCycle = state == "dayCycle"
    game.state.dayCycle = state == "dayToNight"
    game.state.nightCycle = state == "nightCycle"
    game.state.nightCycle = state == "nightToDay"
end

function saveGame()
    data = {
        state = game.state,
    }
    love.filesystem.write("saveGame.lua", json.encode(data))
end