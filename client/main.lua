local ESX = exports["es_extended"]:getSharedObject()

local isProtected = false

for i, zone in ipairs(Config.ToxicZones) do
    TriggerEvent('toxiczones:createZone', zone)
else
    TriggerEvent('toxiczones:removeZone', zone)

end

RegisterNetEvent('toxiczones:createZone')
AddEventHandler('toxiczones:createZone', function(zone)
    if zone.showBlip and zone.blip then
        local blip = AddBlipForCoord(zone.coords.x, zone.coords.y, zone.coords.z)

        SetBlipSprite(blip, zone.blip.sprite)
        SetBlipColour(blip, zone.blip.color)
        SetBlipScale(blip, zone.blip.scale)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Zona Tóxica")
        EndTextCommandSetBlipName(blip)
    end

    if Config.showProp and zone.prop then
        local prop = CreateObject(GetHashKey(zone.prop), zone.coords.x, zone.coords.y, zone.coords.z - 1.0, true, true, true)
        SetEntityHeading(prop, 0.0)
        PlaceObjectOnGroundProperly(prop)
    end
end)


RegisterNetEvent('toxiczones:removeZone')
AddEventHandler('toxiczones:removeZone', function(zone)
    -- Remove blip and prop from toxic zone
end)

RegisterNetEvent('toxiczones:showAlert')
AddEventHandler('toxiczones:showAlert', function(zone)
    if zone.notifyPlayer then
        lib.notify({
            id = 'new_toxic_zone',
            title = 'Nueva zona tóxica',
            description = 'Se ha detectado una nueva zona tóxica!',
            position = 'top',
            style = {
                backgroundColor = '#C53030',
                color = '#FFFFFF'
            },
            icon = 'ban',
            iconColor = '#FFFFFF'
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, zone in pairs(Config.ToxicZones) do
            local distance = #(playerCoords - zone.coords)

            if distance < zone.radius and not isProtected then
                local damageAmount = math.floor((1 - distance / zone.radius) * (zone.maxDamage - zone.minDamage) + zone.minDamage)

                if GetEntityHealth(playerPed) > damageAmount then
                    ApplyDamageToPed(playerPed, damageAmount, false)
                end

                if zone.notifyPlayer then
                    lib.notify({
                        id = 'toxicity_damage',
                        title = 'Daño por toxicidad',
                        description = 'Estás recibiendo daño por la toxicidad!',
                        position = 'top',
                        style = {
                            backgroundColor = '#C53030',
                            color = '#FFFFFF'
                        },
                        icon = 'ban',
                        iconColor = '#FFFFFF'
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('toxiczones:useProtectionItem')
AddEventHandler('toxiczones:useProtectionItem', function(itemName)
    local playerPed = PlayerPedId()
    local protectionItem = Config.ProtectionItems[itemName]

    if protectionItem then
        -- Remove protection item from player inventory
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if IsPedMale(playerPed) then
                TriggerEvent('skinchanger:loadClothes', skin, protectionItem.maleUniform.outfitData)
            else
                TriggerEvent('skinchanger:loadClothes', skin, protectionItem.femaleUniform.outfitData)
            end
        end)

        isProtected = true

        lib.notify({
            id = 'protection_used',
            title = 'Protección activada',
            description = 'Has usado ' .. protectionItem.label .. '. Ahora estás protegido de la toxicidad.',
            position = 'top',
            style = {
                backgroundColor = '#30C56D',
                color = '#FFFFFF'
            },
            icon = 'shield-alt',
            iconColor = '#FFFFFF'
        })
    else
        lib.notify({
            id = 'protection_not_found',
            title = 'Artículo no encontrado',
            description = 'No se encontró ' .. itemName .. ' en tu inventario.',
            position = 'top',
            style = {
                backgroundColor = '#C53030',
                color = '#FFFFFF'
            },
            icon = 'times',
            iconColor = '#FFFFFF'
        })
    end
end)

--ESX.RegisterUsableItem('nbq_suit', function(source)
--    local xPlayer = ESX.GetPlayerFromId(source)
--
--    if xPlayer then
--        TriggerClientEvent('nbq_suit:use', source)
--
--        xPlayer.removeInventoryItem('nbq_suit', 1)
--    else
--        print('No se pudo obtener xPlayer para el ID de origen: ' .. tostring(source))
--    end
--end)
