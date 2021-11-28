#include "vk_utils.lua"

local function HexToRGB(hex)
    local colour = {}
    hex = hex:gsub('#', '')

    table.insert(colour, tonumber('0x' .. hex:sub(1,2)))
    table.insert(colour, tonumber('0x' .. hex:sub(3,4)))
    table.insert(colour, tonumber('0x' .. hex:sub(5,6)))

    return colour
end

local function RGBToSomething(rgb)
    for k, v in pairs(rgb) do
        if rgb[k] > 1 and rgb[k] <= 255 then
            rgb[k] = v / 255
        end
    end

    return rgb
end

TColours = {
    White = { 1, 1, 1, 1 },
    Black = { 0, 0, 0, 1 },
    Red = { 1, 0, 0, 1 },
    Green = { 0, 1, 0, 1 },
    Blue = { 0, 0, 1, 0 },

    Cyan = { 0, 1, 1, 1 },

    ---```lua
    -----Examples
    ---TColours.New({255, 0, 0})
    ---TColours.New({1, 0, 0})
    ---TColours.New('#ff0000')
    ---```
    ---@param colour any
    ---@return table
    New = function(colour)
        if type(colour) == 'table' then
            return RGBToSomething(colour)
        elseif type(colour) == 'string' then
            return RGBToSomething(HexToRGB(colour))
        else
            return colour
        end
    end
}

local function GetColour(colour, alpha)
    alpha = alpha or colour[4]
    colour[4] = alpha
    return unpack(colour)
end

function VUIColor(colour, alpha)
    UiColor(GetColour(colour, alpha))
end

function VUIButtonHoverColor(colour, alpha)
    UiButtonHoverColor(GetColour(colour, alpha))
end

function VUIColorFilter(colour, alpha)
    UiColorFilter(GetColour(colour, alpha))
end