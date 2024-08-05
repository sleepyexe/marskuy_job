

lib.callback.register('sr_job:takePetrol', function (playerId)
    for k, v in pairs(Fueler.Items.takePetrol.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)

lib.callback.register('sr_job:processPetrol', function (playerId)
    local punya = {}
    for k, v in pairs(Fueler.Items.processPetrol.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
            })
            return
        else
            punya[k] = v
        end
    end
    for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Fueler.Items.processPetrol.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)

lib.callback.register('sr_job:processRaffin', function (playerId)
    local punya = {}
    for k, v in pairs(Fueler.Items.processPetrol.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
            })
            return
        else
            punya[k] = v
        end
    end

     for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Fueler.Items.processPetrol.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)