function loadSettings()
    settings {
        startSettings = false,
        keyBindings = {
            --TODO: empty for now
        },
        displayResolution = {
            -- TODO: default for now
            height = 1024,
            width = 2646
        },
        volumes = {
            -- TODO: default for now
            music = 50,
            sounds = 50
        }
    }
end

function updateSettings(dt)
    
end

function enterSettings()
    game.settingsState = true
end

function drawSettings()
    -- draw over the current screen
    
end