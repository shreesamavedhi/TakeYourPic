--[[
    Key input management module
    Handles keyboard input state tracking for the game
]]

--- Initializes the global key state table
--- Keys tracked: return, up, down, right, left
function LoadKeys()
    GlobalKeys = {
        ['return'] = false,
        ['up'] = false,
        ['down'] = false,
        ['right'] = false,
        ['left'] = false,
    }
end

--- LÖVE2D callback for key press events
--- @param key string The key that was pressed
function love.keypressed(key)
    if GlobalKeys[key] ~= nil then
        GlobalKeys[key] = true
    end
end
