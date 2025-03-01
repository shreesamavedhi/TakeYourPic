
------------------------------ Local helper functions-------------------------------------

local function editMasterVolume(plus)
    if plus then
        Settings.audio.master = math.min(Settings.audio.master + 0.1, 1)
    else
        Settings.audio.master = math.max(Settings.audio.master - 0.1, 0)
    end
    love.audio.setVolume(Settings.audio.master)
end

local function editMusicVolume(plus)
    if plus then
        Settings.audio.music = math.min(Settings.audio.music + 0.1, 1)
    else
        Settings.audio.music = math.max(Settings.audio.music - 0.1, 0)
    end
    -- Update music volume here
end

local function editSoundVolume(plus)
    if plus then
        Settings.audio.sound = math.min(Settings.audio.sound + 0.1, 1)
    else
        Settings.audio.sound = math.max(Settings.audio.sound - 0.1, 0)
    end
    -- Update sound effects volume here
end

---------------------------------- Global settings functions----------------------------------

function ExitAudioSettings()
    ChangeSettingsState("menu")
end

function LoadAudioSettings()
    Settings.audio = {
        -- TODO: default for now
        master = 0.5, -- Maximum volume for all sounds
        music = 1,
        sound = 0.75
    }
    NewButtonParams("audioSettings", function() ExitAudioSettings() end)
    InsertRLBtnList("audioSettings", "Master Volume", 0, 3, function() editMasterVolume(true) end, function() editMasterVolume(false) end)
    InsertRLBtnList("audioSettings", "Music Volume", 0, 2, function() editMusicVolume(true) end, function() editMusicVolume(false) end)
    InsertRLBtnList("audioSettings", "SFX Volume", 0, 1, function() editSoundVolume(true) end, function() editSoundVolume(false) end)
    InsertRetBtnList("audioSettings", "Back", 0, 0, function() ExitAudioSettings() end)
end

function UpdateAudioSettings(dt)
    UpdateButtons(dt, "audioSettings")
end

function DrawAudioSettings()
end