windDir = {
    ['North'] = 1,
    ['South'] = 2,
    ['East']  = 3,
    ['West']  = 4
}

waitForKey = false

windMenu = false
windMenuDropdown = false

uiWidth = 400
uiHeight = 200

btnWidth = 100
btnHeight = 40

particleLifetime = 4
particleSpawnTime = 0
particleSpawnPos = 10

windSound = LoadLoop('MOD/snd/wind-1.ogg')

targetDist = 50
raycastDist = 10

minSpeed = 0
maxSpeed = 200