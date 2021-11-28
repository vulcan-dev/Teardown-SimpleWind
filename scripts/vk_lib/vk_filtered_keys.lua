local filteredKeys = {}

function LoadDefaultFilteredKeys()
    filteredKeys = {
        esc     = true,
        lmb     = true,
        mmb     = true,
        rmb     = true,
        space   = true,
        any     = true,
        tab     = true,
        ctrl    = true,
        W       = true,
        A       = true,
        S       = true,
        D       = true,
        E       = true,
        F       = true,
    }
end

function AddFilteredKey(key)
    filteredKeys[key] = true
end

function RemoveFilteredKey(key)
    filteredKeys[key] = false
end

function IsKeyFiltered(key)
    if not filteredKeys[key] then return false end
    return true
end