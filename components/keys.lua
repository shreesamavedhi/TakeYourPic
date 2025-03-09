--[[
    Key input management module
    Handles keyboard input state tracking for the game
]]

--- Initializes the global key state table
--- Keys tracked: return, up, down, right, left
function LoadKeys()
    GlobalKeys = {
        -- Alphabet
        ['a'] = false, ['b'] = false, ['c'] = false, ['d'] = false,
        ['e'] = false, ['f'] = false, ['g'] = false, ['h'] = false,
        ['i'] = false, ['j'] = false, ['k'] = false, ['l'] = false,
        ['m'] = false, ['n'] = false, ['o'] = false, ['p'] = false,
        ['q'] = false, ['r'] = false, ['s'] = false, ['t'] = false,
        ['u'] = false, ['v'] = false, ['w'] = false, ['x'] = false,
        ['y'] = false, ['z'] = false,

        -- Numbers
        ['0'] = false, ['1'] = false, ['2'] = false, ['3'] = false,
        ['4'] = false, ['5'] = false, ['6'] = false, ['7'] = false,
        ['8'] = false, ['9'] = false,

        -- Function keys
        ['f1'] = false, ['f2'] = false, ['f3'] = false, ['f4'] = false,
        ['f5'] = false, ['f6'] = false, ['f7'] = false, ['f8'] = false,
        ['f9'] = false, ['f10'] = false, ['f11'] = false, ['f12'] = false,

        -- Special keys
        ['space'] = false, ['return'] = false, ['escape'] = false,
        ['backspace'] = false, ['tab'] = false, 

        -- Arrow keys
        ['up'] = false, ['down'] = false, ['left'] = false, ['right'] = false,
    }
    KeyPressed = false
    LastKeyPressed = nil
    WaitingForKey = false
    WaitStartTime = 0

    -- Key repeat settings
    KeyRepeatDelay = 0.5  -- Initial delay before key starts repeating (in seconds)
    KeyRepeatInterval = 0.1  -- Interval between key repeats (in seconds)
    KeyHoldTime = {}  -- Track how long each key has been held
end

--- LÖVE2D callback for key press events
--- @param key string The key that was pressed
function love.keypressed(key)
    local isBind, _ = IsKeyBind(key)
    local menuKeys = IsKeyForBtnSelect(key) and IsBtnSelectState()
    local gameKeys = isBind and not IsBtnSelectState()
    local bindKeys = IsBindMode()
    if GlobalKeys[key] ~= nil and (menuKeys or gameKeys or bindKeys) then
        KeyPressed = true -- Used for key binding
        LastKeyPressed = key -- Used for key binding
        GlobalKeys[key] = true -- Track and handle every key press
        KeyHoldTime[key] = 0  -- Initialize hold time when key is pressed
    end
end

--- Clear all key states
function ClearKeyStates()
    KeyPressed = false
    LastKeyPressed = nil
    for key, _ in pairs(GlobalKeys) do
        GlobalKeys[key] = false
        KeyHoldTime[key] = nil
    end
end

function StartWaitingForKey()
    ClearKeyStates()
    WaitingForKey = true
    WaitStartTime = love.timer.getTime()
end

function CheckKeyPress()
    if not WaitingForKey then
        return nil
    end
    
    -- Check for timeout
    if love.timer.getTime() - WaitStartTime >= 5 then
        WaitingForKey = false
        return nil
    end
    
    -- Check if we got a key
    if KeyPressed and LastKeyPressed then
        WaitingForKey = false
        return LastKeyPressed
    end
    
    return false  -- Still waiting
end

-- Check if key has been pressed
function IsKeyPressed(key)
    return GlobalKeys[key]
end

-- Set Key Press to false after event is handled
function SetKeyPressOff(key)
    GlobalKeys[key] = false
end

--- LÖVE2D callback for key release events
function love.keyreleased(key)
    if GlobalKeys[key] ~= nil then
        KeyPressed = false
        KeyHoldTime[key] = nil  -- Clear hold time when key is released
    end
end

--- Update function to handle key repeats
--- @param dt number Delta time since last frame
function UpdateKeys(dt)
    for key, _ in pairs(GlobalKeys) do
        if KeyPressed and LastKeyPressed == key and KeyHoldTime[key] then
            KeyHoldTime[key] = KeyHoldTime[key] + dt
            
            -- Check if we should trigger a key repeat
            if KeyHoldTime[key] >= KeyRepeatDelay then
                local repeatCount = math.floor((KeyHoldTime[key] - KeyRepeatDelay) / KeyRepeatInterval)
                local shouldRepeat = repeatCount > 0 and 
                    (KeyHoldTime[key] - KeyRepeatDelay) % KeyRepeatInterval < dt
                
                if shouldRepeat then
                    GlobalKeys[key] = true
                end
            end
        end
    end
end