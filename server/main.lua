ESX = exports["es_extended"]:getSharedObject()

local activeZones = {}

Citizen.CreateThread(function()
    for _, zone in pairs(Config.ToxicZones) do
        if zone.permanent then
            table.insert(activeZones, zone)
            TriggerClientEvent('toxiczones:createZone', -1, zone)
            TriggerClientEvent('toxiczones:showAlert', -1)
        end
    end

    while true do
        Citizen.Wait(Config.NewZoneInterval * 1000)

        local newZone = {
            coords = randomCoords(),
            radius = randomRadius(),
            minDamage = randomMinDamage(),
            maxDamage = randomMaxDamage(),
            permanent = false,
            duration = randomDuration(),
            blip = {
                sprite = randomBlipSprite(),
                color = randomBlipColor(),
                scale = randomBlipScale()
            },
            prop = randomProp()
        }

        table.insert(activeZones, newZone)
        TriggerClientEvent('toxiczones:createZone', -1, newZone)
        TriggerClientEvent('toxiczones:showAlert', -1)

        Citizen.Wait(newZone.duration * 1000)

        for i = #activeZones, 1, -1 do
            if activeZones[i] == newZone then
                table.remove(activeZones, i)
                TriggerClientEvent('toxiczones:removeZone', -1, newZone)
                break
            end
        end
    end
end)

function randomCoords()
    -- Generate random coordinates for new toxic zone
end

function randomRadius()
    -- Generate random radius for new toxic zone
end

function randomMinDamage()
    -- Generate random minimum damage for new toxic zone
end

function randomMaxDamage()
    -- Generate random maximum damage for new toxic zone
end

function randomDuration()
    -- Generate random duration for new toxic zone
end

function randomBlipSprite()
    -- Generate random blip sprite for new toxic zone
end

function randomBlipColor()
    -- Generate random blip color for new toxic zone
end

function randomBlipScale()
    -- Generate random blip scale for new toxic zone
end

function randomProp()
    -- Generate random prop for new toxic zone
end

for i, zone in ipairs(Config.ToxicZones) do
    local stashName = 'stash_zone' .. i
    exports.oxmysql:execute('INSERT INTO ox_inventory (name, data) VALUES (?, ?)', {
        stashName,
        json.encode({ slots = 50 })
    })
    zone.stash = stashName
end
 