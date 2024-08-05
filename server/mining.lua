lib.callback.register('mr_job:getStone', function(playerId)
    for k, v in pairs(Mining.Items.pickStone.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)

lib.callback.register('mr_job:washStone', function (playerId)
    local punya = {}
    for k, v in pairs(Mining.Items.washStone.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify(playerId, {
                title = 'Inventory',
                description = ('Membutuhkan %sx %s'):format(v, Items[k].label),
                type = 'error'
            })
            return
        else
            punya[k] = v
        end
    end
    for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Mining.Items.washStone.add) do
        local count = type(v) == 'table' and math.random(v[1], v[2]) or v or 1
        if ox_inventory:CanCarryItem(playerId, k, count) then
            ox_inventory:AddItem(playerId, k, count)
        end
    end
end)

lib.callback.register('mr_job:smeltStone', function (playerId)
    local punya = {}
    for k, v in pairs(Mining.Items.smeltStone.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify(playerId, {
                title = 'Inventory',
                description = ('Membutuhkan %sx %s'):format(v, Items[k].label),
                type = 'error'
            })
            return
        else
            punya[k] = v
        end
    end
    for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Mining.Items.smeltStone.add) do
        local chance = math.random()
        if chance <= v.chance then
            local count = type(v.amount) == 'table' and math.random(v.amount[1], v.amount[2]) or v.amount or 1
            if ox_inventory:CanCarryItem(playerId, k, count) then
                ox_inventory:AddItem(playerId, k, count)
            end
        end
    end
end)