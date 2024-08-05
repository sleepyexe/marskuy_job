lib.callback.register('sr_job:ayam', function (playerId)
    for k, v in pairs(Chicken.Items.catchChicken.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)

lib.callback.register('sr_job:potongAyam', function (playerId)
    local punya = {}

    for k, v in pairs(Chicken.Items.cutChicken.require) do
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

    for k, v in pairs(Chicken.Items.cutChicken.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end

end)

lib.callback.register('sr_job:packAyam', function (playerId)
    local punya = {}

    for k, v in pairs(Chicken.Items.packChicken.require) do
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

    for k, v in pairs(Chicken.Items.packChicken.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)
