function LoadKeys()
    GlobalKeys = {
        ['return'] = false,
        ['up'] = false,
        ['down'] = false,
        ['right'] = false,
        ['left'] = false,
    }
    
end

function love.keypressed(key)
    if GlobalKeys[key] ~= nil then
        GlobalKeys[key] = true
    end
end
