--[[
    Game state management module
    Handles core game state including day/night cycles, picture collection, and save/load functionality
]]

--- Initializes a new game state
--- Sets up default values for game progress tracking
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

--- Loads a previously saved game state from file
--- Uses JSON format for save data persistence
function LoadSave()
    if love.filesystem.getInfo("saveGame.lua") then
        local jsonData = love.filesystem.read("saveGame.lua")
        local data = json.decode(jsonData)
        -- print(data)
        -- Note: State is saved right before returning to menu
        Game = {
            pictures = data.pictures,
            days = data.days,
            state = data.state
        }
        love.graphics.clear()
    end
end

--- Enters the game world from the menu
--- Transitions to either day or night cycle depending on the current game state
function EnterGame()
    if Game.state.nightCycle then
        ChangeGameState("nightCycle")
    else
        ChangeGameState("dayCycle")
    end
    love.graphics.clear()
end

--- Updates the game state to a new state
--- Sets the corresponding state flag to true and all others to false
function ChangeGameState(state)
    Game.state.menu = state == "menu"
    Game.state.dayCycle = state == "dayCycle"
    Game.state.dayToNight = state == "dayToNight"
    Game.state.nightCycle = state == "nightCycle"
    Game.state.nightToDay = state == "nightToDay"
end

--- Saves the current game state to file
--- Uses JSON format for save data persistence
function SaveGame()
    local data = {
        state = Game.state,
    }
    love.filesystem.write("saveGame.lua", json.encode(data))
end