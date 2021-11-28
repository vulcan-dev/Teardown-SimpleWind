ModName = 'simplewind'

#include "scripts/menu.lua"

local function GetWindSpeed()
    local speed
    if windSpeed <= 20 then
        speed = windSpeed / 2
    else
        speed = windSpeed
    end

    return speed
end

function init()
    SetLogLevel(ELogLevels.Error)
    LoadDefaultFilteredKeys()

    AddKeyNE('windEnabled', false)
    AddKeyNE('windEffects', true)
    AddKeyNE('windVolOverride', false)
    AddKeyNE('windVol', 0)
    AddKeyNE('windSpeed', 1)
    AddKeyNE('debug', false)
    AddKeyNE('doRaycast', true)
    AddKeyNE('menuKey', 'J')
    AddKeyNE('direction', windDir['North'])

    windVolume = GetKey('windVol')
    windVolOverride = GetKey('windVolOverride', EDType.Bool)
    windEnabled = GetKey('windEnabled', EDType.Bool)
    windEffects = GetKey('windEffects', EDType.Bool)
    windSpeed = GetKey('windSpeed')
    doRaycasts = GetKey('doRaycast', EDType.Bool)
    debug = GetKey('debug', EDType.Bool)
    currentWindDir = GetKey('direction')
    menuKey = GetKey('menuKey')

    SetLogDebug(debug)

    TColours.SliderBackground = TColours.New('#262626')
    TColours.MenuBackground = TColours.New({38, 38, 38, 155})
end

function tick(dt)
    if PauseMenuButton('Wind Options') then
        windMenu = not windMenu
    end

    if windMenu and InputPressed('downarrow') then
        windMenuDropdown = true
    elseif windMenu and InputPressed('uparrow') then
        windMenuDropdown = false
    end

    if not waitForKey and InputPressed(menuKey) then
        windMenu = not windMenu
    end

    if waitForKey then
        lastKeyPressed = InputLastPressedKey()
        if lastKeyPressed ~= '' and not IsKeyFiltered(lastKeyPressed) then
            waitForKey = false
            menuKey = lastKeyPressed
            SetKey('menuKey', menuKey)
        end

        if InputPressed('esc') then
            waitForKey = false
        end
    end

    if windMenu then
        if not windVolOverride then
            windVolume = windSpeed / 100 / 2
        end
    end

    if windEnabled then
        if not windVolOverride then
            PlayLoop(windSound, GetPlayerTransform().pos, windVolume)
        else
            if windVolume <= 99 then
                PlayLoop(windSound, GetPlayerTransform().pos, tonumber(string.format('0.%d', windVolume)))
            else
                PlayLoop(windSound, GetPlayerTransform().pos, 1)
            end
        end

        local pos = GetPlayerTransform().pos

        local targets = QueryAabbShapes(Vec(pos[1] - targetDist, pos[2] - targetDist, pos[3] -targetDist), Vec(pos[1] + targetDist, pos[2] + targetDist, pos[3] + targetDist))
        for i = 1, #targets do
            local body = GetShapeBody(targets[i])
            local bodyImpulse
            local dir

            if currentWindDir == windDir['North'] then
                bodyImpulse = Vec(0, 0, -GetWindSpeed())
                dir = Vec(0, 0, -raycastDist)
            elseif currentWindDir == windDir['South'] then
                bodyImpulse = Vec(0, 0, GetWindSpeed())
                dir = Vec(0, 0, raycastDist)
            elseif currentWindDir == windDir['East'] then
                bodyImpulse = Vec(GetWindSpeed(), 0, 0)
                dir = Vec(raycastDist, 0, 0)
            elseif currentWindDir == windDir['West'] then
                bodyImpulse = Vec(-GetWindSpeed(), 0, 0)
                dir = Vec(-raycastDist, 0, 0)
            end

            if debug then DrawBodyOutline(body, 0, 1, 1, 1) end
            local playerPos = GetPlayerTransform().pos

            ParticleReset()
            ParticleTile(4)
            ParticleStretch(5)
            ParticleEmissive(10, 0)
            ParticleRadius(0.01)
            ParticleGravity(-2)
            ParticleColor(1, 0.7, 0.3)
            ParticleSticky(0.05)
            ParticleCollide(1, 1, "constant", 0.05)

            if GetWindSpeed() >= 20 and windEffects and playerPos[2] >= 0 then
                if GetTime() > particleSpawnTime then
                    local particleVel
                    if GetWindSpeed() <= 10 then
                        particleVel = Vec(
                            bodyImpulse[1] * 2,
                            0,
                            bodyImpulse[3] * 2
                        )
                    else
                        particleVel = Vec(
                            bodyImpulse[1],
                            0,
                            bodyImpulse[3]
                        )
                    end

                    particleSpawnTime = GetTime() + 0.1
                    SpawnParticle(Vec(
                        math.random(playerPos[1] - particleSpawnPos, playerPos[1] + particleSpawnPos),
                        math.random(playerPos[2], playerPos[2] * 2),
                        math.random(playerPos[3] - particleSpawnPos, playerPos[3] + particleSpawnPos)),

                        particleVel,
                        particleLifetime
                    )
                end
            end

            if doRaycasts then
                if debug then DebugLine(GetBodyTransform(body).pos, VecAdd(GetBodyTransform(body).pos, dir), 1, 1, 1, 1) end
                local hit = QueryRaycast(GetBodyTransform(body).pos, dir, raycastDist)

                if hit then
                    QueryRejectBody(body)
                else
                    ApplyBodyImpulse(body, GetBodyTransform(body).pos, bodyImpulse)
                end
            else
                ApplyBodyImpulse(body, GetBodyTransform(body).pos, bodyImpulse)
            end
        end
    end
end

function draw(dt)
    if windMenu then
        UiPush()
            --[[ Initial Setup ]]--
            UiMakeInteractive()
            UiFont('regular.ttf', 26)
            UiBlur(0.75)
            UiButtonPressColor(1, 1, 1, 1)

            DrawMenu()

            if windMenuDropdown then
                DrawSecondaryMenu()
            end
        UiPop()
    end
end