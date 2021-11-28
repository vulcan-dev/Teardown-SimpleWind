#include "vk_filtered_keys.lua"
#include "vk_logging.lua"

EDType = {
    String = 0,
    Int = 1,
    Bool = 2
}

---@param key any
---@param default any
function AddKeyNE(key, default)
    key = 'savegame.mod.' .. ModName .. '.' .. key
    if HasKey(key) then return end

    if type(default) == 'string' then
        SetString(key, default)
    elseif type(default) == 'number' then
        SetInt(key, default)
    elseif type(default) == 'boolean' then
        SetBool(key, default)
    else
        ELog(string.format('{ AddKeyNE } Unimplemented Type [%s]', tostring(type(key))))
    end
end

-- Retrieve a key from the registry
---@param key any
---@return any value
function GetKey(key, dtype)
    dtype = dtype or nil

    key = 'savegame.mod.' .. ModName .. '.' .. key
    if not HasKey(key) then ELog(string.format('{ GetKey } ["%s"] does not exist', key)) return end

    if not dtype then
        local value = GetString(key)
        if tonumber(value) then return tonumber(value) end

        return value
    else
        if dtype == EDType.String then
            return GetString(key)
        elseif dtype == EDType.Int then
            return GetInt(key)
        elseif dtype == EDType.Bool then
            return GetBool(key)
        end
    end
end

-- Set a key in the registry
---@param key any
---@param value any
function SetKey(key, value)
    key = 'savegame.mod.' .. ModName .. '.' .. key
    if not HasKey(key) then ELog(string.format('Key ["%s"] does not exist', key)) return end

    if type(value) == 'string' then
        SetString(key, value)
    elseif type(value) == 'number' then
        SetInt(key, value)
    elseif type(value) == 'boolean' then
        SetBool(key, value)
    else
        ELog(string.format('{ SetKey } Unimplemented Type [%s]', tostring(type(key))))
    end
end