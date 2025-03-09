---------------------------------- Global settings functions----------------------------------

--- Enters the paused game state
function EnterPaused()
    Settings.state.paused = true
end

--- Exits the paused game state
function ExitPaused()
    Settings.state.paused = false
end

function LoadPaused()
    -- button pause variables
    NewButtonParams("paused", function() ExitPaused() end)
    -- populate pause buttons
    InsertRetBtnList("paused", "Resume", 0, 2, function() ExitPaused() end)
    InsertRetBtnList("paused", "Settings", 0, 2, function() EnterSettings() end)
    InsertRetBtnList("paused", "Exit to Title", 0, 1, function() ExitPaused() SaveGame() EnterMenu() end)
    InsertRetBtnList("menu", "Quit Game", 0, 0, function() ExitPaused() SaveGame() love.event.quit(0) end)
end

function UpdatePaused()
end

function DrawPaused()
end