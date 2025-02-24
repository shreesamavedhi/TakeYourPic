
function loadKeys()
    globalKeys = {
        ['return'] = false,
        ['up'] = false,
        ['down'] = false,
        ['right'] = false,
        ['left'] = false,
    }
    
end

function love.keypressed(key)
    if globalKeys[key] ~= nil then
        globalKeys[key] = true
    end
end
