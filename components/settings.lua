-- Magic Numbers!
local HOT_COLOR = {0.8, 0.8, 0.9, 1.0}
local BUTTON_COLOR = {0.4, 0.4, 0.5, 1.0}
local TEXT_COLOR = {0, 0, 0, 1}
local BUTTON_HEIGHT = 30
local BUTTON_MARGIN = 2
local SETTING_FONT = love.graphics.newFont("sprites/yoster.ttf", 12)

function LoadSettings()
    Settings = {
        startSettings = false,
        keyBindings = {
            --TODO: empty for now
        },
        displayResolution = {
            -- TODO: default for now
            width = 2646,
            height = 1024,
        },
        volumes = {
            -- TODO: default for now
            music = 50,
            sounds = 50
        }
    }
    Font = love.graphics.newFont("sprites/yoster.ttf", 32)
    LoadSettingButtons()
    LoadDisplayList()
end

function UpdateSettings(dt)
    UpdateButtons(dt, Buttons["setting"].BtnList, Buttons["setting"].BtnVars)
end

function EnterSettings()
    Game.settingsState = true
end

function ExitSettings()
    Game.settingsState = false
end

function DrawSettings()
    local BUTTON_WIDTH = ScreenWidth * 1/8
    local TOTAL_HEIGHT = (BUTTON_HEIGHT + BUTTON_MARGIN) * #Buttons["setting"].BtnList

    for i, button in ipairs(Buttons["setting"].BtnList) do
        local bx = (ScreenWidth - BUTTON_WIDTH) / 2
        local by = (ScreenHeight - TOTAL_HEIGHT) / 2 + ((i - 1) * (BUTTON_HEIGHT + BUTTON_MARGIN))

        local color = BUTTON_COLOR
        if button.hot then
            color = HOT_COLOR
        end
        love.graphics.setColor(table.unpack(color))
        love.graphics.rectangle(
            "fill", 
            bx,
            by,
            BUTTON_WIDTH,
            BUTTON_HEIGHT
        )

        love.graphics.setColor(table.unpack(TEXT_COLOR))
        local textW = SETTING_FONT:getWidth(button.text)
        local textH = SETTING_FONT:getHeight(button.text)
        love.graphics.print(
            button.text,
            SETTING_FONT,
            bx + ((BUTTON_WIDTH - textW)/2),
            by + ((BUTTON_HEIGHT - textH)/2)
        )
    end
end

function LoadSettingButtons()
    -- button setting variables
    NewButtonParams("setting")
    
    -- populate setting buttons
    InsertBntList("setting", "PlusMusic", 1, 3, function() EditMusicSettings(true) end)
    InsertBntList("setting", "MinusMusic", 0, 3, function() EditMusicSettings(false) end)
    InsertBntList("setting", "PlusSounds", 1, 2, function() EditSoundSettings(true) end)
    InsertBntList("setting", "MinusSounds", 0, 2, function() EditSoundSettings(false) end)
    InsertBntList("setting", "PlusDisplay", 1, 1, function() EditDisplaySettings(true) end)
    InsertBntList("setting", "MinusDisplay", 0, 1, function() EditDisplaySettings(false) end)
    InsertBntList("setting", "Exit", 0, 0, function() ExitSettings() end)
end

function EditMusicSettings(plus)
    if plus and MusicVolume < 1 then
        MusicVolume = MusicVolume + 0.25
    end
end

function EditSoundSettings(plus)
    if plus and SoundVolume < 1 then
        SoundVolume = SoundVolume + 0.25
    end
end

function EditDisplaySettings(plus)

end

function LoadDisplayList()
    DisplayResolutions = {
        [1] = {1280, 720},
        [2] = {1920, 1080},
        [3] = {2560, 1440},
        [4] = {3840, 2160},
    }
end