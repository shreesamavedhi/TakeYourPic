function LoadGame()
    Game = {
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

function LoadSave()
    if love.filesystem.getInfo("saveGame.lua") then
        local jsonData = love.filesystem.read("saveGame.lua")
        local data = json.decode(jsonData)
        print(data)
        -- Note: State is saved right before returning to menu
        Game = {
            pictures = data.pictures,
            days = data.days,
            state = data.state
        }
        love.graphics.clear()
    end
end

function EnterGame()
    if Game.state.nightCycle then
        ChangeGameState("nightCycle")
    else
        ChangeGameState("dayCycle")
    end
    love.graphics.clear()
end

function ChangeGameState(state)
    Game.state.menu = state == "menu"
    Game.state.dayCycle = state == "dayCycle"
    Game.state.dayToNight = state == "dayToNight"
    Game.state.nightCycle = state == "nightCycle"
    Game.state.nightToDay = state == "nightToDay"
end

function SaveGame()
    local data = {
        state = Game.state,
    }
    love.filesystem.write("saveGame.lua", json.encode(data))
end