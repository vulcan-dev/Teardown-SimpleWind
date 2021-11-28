#include "variables.lua"
#include "vk_lib/vk_utils.lua"
#include "vk_lib/vk_ui.lua"

local function SetWindDir(dir)
    for i = 1, #windDir do
        if dir ~= windDir[i] then
            windDir[i] = false
        end
    end

    currentWindDir = windDir[dir]
    SetKey('direction', currentWindDir)
end

function DrawMenu()
    UiPush()
        --[[ Background ]]--
        UiTranslate(UiCenter(), UiMiddle())
        UiAlign('center middle')
        VUIColor(TColours.MenuBackground)
        UiColorFilter(1, 1, 1, 0.5)
        UiRect(uiWidth, uiHeight)
    UiPop()

    VUIColor(TColours.White)
    UiAlign("center middle")

    --[[ Wind Directions Start ]]--
    UiPush()
        if currentWindDir == windDir['North'] then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 80, UiMiddle() - uiHeight / 2 + btnHeight)
        if UiTextButton('North') then
            SetWindDir('North')
        end
    UiPop()

    UiPush()
        if currentWindDir == windDir['South'] then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 80 * 2, UiMiddle() - uiHeight / 2 + btnHeight)
        if UiTextButton('South') then
            SetWindDir('South')
        end
    UiPop()

    UiPush()
        if currentWindDir == windDir['East'] then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 80 * 3, UiMiddle() - uiHeight / 2 + btnHeight)
        if UiTextButton('East') then
            SetWindDir('East')
        end
    UiPop()

    UiPush()
        if currentWindDir == windDir['West'] then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 80 * 4, UiMiddle() - uiHeight / 2 + btnHeight)
        if UiTextButton('West') then
            SetWindDir('West')
        end
    UiPop()
    --[[ Wind Directions End ]]--

    UiPush()
        --[[ Strength Slider Text ]]--
        UiTranslate(UiCenter() - uiWidth / 2 + UiGetTextSize('Strength'), UiMiddle() - 20)
        UiText('Strength')
    UiPop()

    UiPush()
        --[[ Strength Text ]]--
        UiTranslate(UiCenter() - 250 / 2 + windSpeed + UiGetTextSize('Strength') - 10, UiMiddle() - 40)
        UiText(tostring(windSpeed))
    UiPop()

    UiPush()
        --[[ Strength Slider Background ]]--
        UiTranslate(UiCenter() - 250 / 2 + UiGetTextSize('Strength') - 10 + maxSpeed / 2, UiMiddle() - 20)
        VUIColor(TColours.SliderBackground)
        UiRect(maxSpeed, 20)
    UiPop()

    UiPush()
        --[[ Strength Slider ]]--
        UiTranslate(UiCenter() - 250 / 2 + UiGetTextSize('Strength') - 10, UiMiddle() - 20)
        VUIColor(TColours.White)
        windSpeed = math.floor(UiSlider('ui/common/dot.png', 'x', windSpeed, minSpeed, maxSpeed))
        SetKey('windSpeed', windSpeed)
    UiPop()

    UiPush()
        --[[ Debug Button ]]--
        if debug then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 100, UiMiddle() + 20)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Debug', 100, btnHeight) then
            debug = not debug
            SetKey('debug', debug)
            SetLogDebug(debug)
        end
    UiPop()

    UiPush()
        --[[ Enable Button ]]--
        if windEnabled then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() + 5, UiMiddle() + 20)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Enable', 100, btnHeight) then
            windEnabled = not windEnabled
            SetKey('windEnabled', windEnabled)
        end
    UiPop()

    UiPush()
        --[[ Effects Button ]]--
        if windEffects then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() + uiWidth / 2 - 100 + 10, UiMiddle() + 20)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Effects', 100, btnHeight) then
            windEffects = not windEffects
            SetKey('windEffects', windEffects)
        end
    UiPop()

    if not windMenuDropdown then
        UiPush()
            --[[ Close Button ]]--
            UiTranslate(UiCenter(), UiMiddle() + uiHeight / 2 - btnHeight / 2 - 10)
            UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
            if UiTextButton('Close', 150, btnHeight) then
                windMenu = false
            end
        UiPop()

        UiPush()
            UiTranslate(UiCenter(), UiMiddle() + uiHeight / 2 - 4)
            VUIColor(TColours.White)
            VUIButtonHoverColor(TColours.Cyan)
            UiButtonImageBox("MOD/sprites/square.png", 6, 6, 1, 1, 1, 0.5)
            if UiBlankButton(uiWidth, 5.5) then
                windMenuDropdown = true
            end
        UiPop()
    end
end

function DrawSecondaryMenu()
    local uiHeight2 = 100

    --[[ Initial Setup ]]--
    UiPush()
        --[[ Background ]]--
        UiTranslate(UiCenter(), UiMiddle() + uiHeight / 2 + uiHeight2 / 2)
        VUIColor(TColours.MenuBackground)
        UiColorFilter(1, 1, 1, 0.5)
        UiRect(uiWidth, uiHeight / 2)
    UiPop()

    UiPush()
        UiTranslate(UiCenter(), UiMiddle() + uiHeight / 4)
        VUIColor(TColours.White)
        VUIButtonHoverColor(TColours.Cyan)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 1, 1, 1, 0.5)
        if UiBlankButton(uiWidth, 5.5) then
            windMenuDropdown = false
        end
    UiPop()

    UiPush()
        --[[ Raycast Button ]]--
        if doRaycasts then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() - uiWidth / 2 + 100, UiMiddle() + uiHeight2 / 2 + 33)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Raycast', 100, btnHeight) then
            doRaycasts = not doRaycasts
            SetKey('doRaycast', doRaycasts)
        end
    UiPop()

    if not waitForKey then
        UiPush()
            --[[ Key Input Button ]]--
            UiTranslate(UiCenter() + 5, UiMiddle() + uiHeight2 / 2 + 33)
            UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
            if UiTextButton(menuKey, 100, btnHeight) then
                waitForKey = true
            end
        UiPop()
    else
        UiPush()
            --[[ Key Input Button ]]--
            UiTranslate(UiCenter() + 5, UiMiddle() + uiHeight2 / 2 + 33)
            UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
            UiColor(0.8, 0.8, 0.8, 0.2)
            if UiTextButton(menuKey, 100, btnHeight) then
                waitForKey = false
            end
        UiPop()
    end

    UiPush()
        --[[ Sound Button ]]--
        if windVolOverride then VUIColor(TColours.Cyan) end

        UiTranslate(UiCenter() + uiWidth / 2 - 100 + 10, UiMiddle() + uiHeight2 / 2 + 33)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Sound', 100, btnHeight) then
            windVolOverride = not windVolOverride
            SetKey('windVolOverride', windVolOverride)
        end
    UiPop()

    UiPush()
        --[[ Volume Slider Text ]]--
        UiTranslate(UiCenter() - uiWidth / 2 + UiGetTextSize('Volume'), UiMiddle() + uiHeight2 / 2 + 95)
        UiText('Volume')
    UiPop()

    UiPush()
        --[[ Volume Text ]]--
        if windVolOverride then
            UiTranslate(UiCenter() - 250 / 2 + windVolume + UiGetTextSize('Volume') - 10, UiMiddle() + uiHeight2 / 2 + 70)
        else
            UiTranslate(UiCenter() - 250 / 2 + windSpeed / 2 + UiGetTextSize('Volume') - 10, UiMiddle() + uiHeight2 / 2 + 70)
        end
        UiText(tostring(windVolume))
    UiPop()

    UiPush()
        --[[ Volume Slider Background ]]--
        UiTranslate(UiCenter() - 250 / 2 + UiGetTextSize('Volume') - 10 + 100 / 2, UiMiddle() + uiHeight2 / 2 + 95)
        VUIColor(TColours.SliderBackground)
        UiRect(100, 20)
    UiPop()

    UiPush()
        --[[ Volume Slider ]]--
        UiTranslate(UiCenter() - 250 / 2 + UiGetTextSize('Volume') - 10, UiMiddle() + uiHeight2 / 2 + 95)
        VUIColor(TColours.White)
        if windVolOverride then
            windVolume = math.floor(UiSlider('ui/common/dot.png', 'x', windVolume, 0, 100))
            SetKey('windVol', windVolume)
        else
            UiSlider('ui/common/dot.png', 'x', windSpeed / 2 , 0, 100)
        end
    UiPop()

    UiPush()
        --[[ Close Button ]]--
        UiTranslate(UiCenter(), UiMiddle() + uiHeight - btnHeight / 2)
        UiButtonImageBox("MOD/sprites/square.png", 6, 6, 0, 0, 0, 0.5)
        if UiTextButton('Close', 150, btnHeight) then
            windMenu = false
        end
    UiPop()
end