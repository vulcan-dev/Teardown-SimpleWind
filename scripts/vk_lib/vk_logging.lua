ELogLevels = {
    Debug = 0,
    Info = 1,
    Warn = 2,
    Error = 3,
}

local LogLevel = ELogLevels.Error
local DebugMode = false

function SetLogLevel(level)
    LogLevel = level
end

function SetLogDebug(value)
    DebugMode = value
end

local function GLog(message, level, ...)
    local output = string.format('%s', string.format(message, ...))
    if LogLevel >= level then DebugPrint(output) end
    output = output .. '\n'
end

-- Debug Log
---```lua
-----Make sure to enable debug mode
---SetLogDebug(true)
---```
---@param message any
---@param ... any
function DLog(message, ...)
    if DebugMode
        then message = tostring(string.format('[DEBUG]: %s', message)) GLog(message, ELogLevels.Debug, ...)
    end
end

-- Info Log
---@param message any
---@param ... any
function ILog(message, ...)
    message = tostring(string.format('[INFO]: %s', message)) GLog(message, ELogLevels.Info, ...)
end

-- Warning Log
---@param message any
---@param ... any
function WLog(message, ...)
    message = tostring(string.format('[WARN]: %s', message)) GLog(message, ELogLevels.Warn, ...)
end

-- Error Log
---@param message any
---@param ... any
function ELog(message, ...)
    message = tostring(string.format('[ERROR]: %s', message)) GLog(message, ELogLevels.Error, ...)
end