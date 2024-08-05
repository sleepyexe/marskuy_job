ox_inventory = exports.ox_inventory
ox_target = exports.ox_target
Items = ox_inventory:Items()

utils = {}

if not IsDuplicityVersion() then
    utils.HasItem = function (items, amount)
        amount = amount or 1
        local count = ox_inventory:Search('count', items)
        if type(items) == 'table' and type(count) == 'table' then
            for _, v in pairs(count) do
                if v < amount then
                    return false
                end
            end
            return true
        end
        return count >= amount
    end

    utils.createBlip = function (data)
        if not data then return end
        if not data.coords then return end
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, data.sprite or 1)
        SetBlipScale(blip, data.scale or 0.8)
        SetBlipColour(blip, data.color or 1)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(data.label or 'Label')
        EndTextCommandSetBlipName(blip)
    
        return blip
    end

    utils.spawnPed = function (data)
        if not data then return end
        if not data.ped then return end
        if not data.coords then return end
        lib.requestModel(data.ped, 60000)
        local ped = CreatePed(5, data.ped, data.coords.x, data.coords.y, data.coords.z-1, data.coords.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        return ped
    end

    utils.deletePed = function (entity, id)
        if not entity or entity == 0 then return end
        if not DoesEntityExist(entity) then return end
        SetEntityAsMissionEntity(entity, false, true)
        DeleteEntity(entity)
        if id then
            ox_target:removeLocalEntity(entity, id)
        end
    end

    utils.createLocalPed = function (data)
        if not data or type(data) ~= 'table' then return end
        data = table.type(data) == 'array' and data or {data}
        local entities = {}
        for i = 1, #data do
            local v = data[i]
            if not v.ped or not v.coords then 
                goto continue
            end
            lib.requestModel(v.ped, 60000)
            local ped = CreatePed(5, v.ped, v.coords.x, v.coords.y, v.coords.z-1, v.coords.w, false, false)
            TaskReactAndFleePed(ped, PlayerPedId())
            SetEntityInvincible(ped, true)
            entities[#entities+1] = ped
            Wait(100)
            ::continue::
        end
        return entities
    end

    utils.drawText3D = function (coords, text, size, font)
        local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
    
        local camCoords = GetFinalRenderedCamCoord()
        local distance = #(vector - camCoords)
    
        if not size then
            size = 1
        end
        if not font then
            font = 0
        end
    
        local scale = (size / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        scale = scale * fov
    
        SetTextScale(0.0, 0.55 * scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        BeginTextCommandDisplayText('STRING')
        SetTextCentre(true)
        AddTextComponentSubstringPlayerName(text)
        SetDrawOrigin(vector.xyz, 0)
        EndTextCommandDisplayText(0.0, 0.0)
        ClearDrawOrigin()
    end

end