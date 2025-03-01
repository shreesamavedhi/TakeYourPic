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
        ['backspace'] = false, ['tab'] = false, ['capslock'] = false,
        ['lshift'] = false, ['rshift'] = false, ['lctrl'] = false,
        ['rctrl'] = false, ['lalt'] = false, ['ralt'] = false,
        ['lgui'] = false, ['rgui'] = false, ['menu'] = false,
        ['`'] = false, ['-'] = false, ['='] = false, ['['] = false,
        [']'] = false, ['\\'] = false, [';'] = false, ['\''] = false,
        [','] = false, ['.'] = false, ['/'] = false,

        -- Arrow keys
        ['up'] = false, ['down'] = false, ['left'] = false, ['right'] = false,

        -- Numpad
        ['kp0'] = false, ['kp1'] = false, ['kp2'] = false, ['kp3'] = false,
        ['kp4'] = false, ['kp5'] = false, ['kp6'] = false, ['kp7'] = false,
        ['kp8'] = false, ['kp9'] = false,
        ['kp.'] = false, ['kp/'] = false, ['kp*'] = false, ['kp-'] = false,
        ['kp+'] = false, ['kpenter'] = false, ['kp='] = false,
    }
end

--- LÖVE2D callback for key press events
--- @param key string The key that was pressed
function love.keypressed(key)
    if GlobalKeys[key] ~= nil then
        GlobalKeys[key] = true
    end
end

-- Check if key has been pressed
function IsKeyPressed(key)
    return GlobalKeys[key]
end

-- Set Key Press to false after event is handled
function SetKeyPressOff(key)
    GlobalKeys[key] = false
end