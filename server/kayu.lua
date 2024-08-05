lib.callback.register('sr_job:dapetKayu', function (playerId)
    for k, v in pairs(Lumberjack.Items.ambilKayu.add) do
        if ox_inventory:CanCarryItem(playerId, k, v) then
            ox_inventory:AddItem(playerId, k, v)
        end
    end
end)

lib.callback.register('sr_job:potongKayu', function (playerId)
    local punya = {}
    for k, v in pairs(Lumberjack.Items.potongKayu.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify(playerId, {
                description = ('Kamu kekurangan %sx %s'):format(v, Items[k].label),
            })
            return
        end
        punya[k] = v
    end
    for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Lumberjack.Items.potongKayu.add) do
        if ox_inventory:CanCarryItem(playerId, k, v) then
            ox_inventory:AddItem(playerId, k, v)
        end
    end
end)

lib.callback.register('sr_job:kemasKayu', function (playerId)
    local punya = {}
    for k, v in pairs(Lumberjack.Items.kemasKayu.require) do
        local count = ox_inventory:Search(playerId, 'count', k)
        if count < v then
            lib.notify(playerId, {
                description = ('Kamu kekurangan %sx %s'):format(v, Items[k].label),
            })
            return
        end
        punya[k] = v
    end
    for k, v in pairs(punya) do
        ox_inventory:RemoveItem(playerId, k, v)
    end
    for k, v in pairs(Lumberjack.Items.kemasKayu.add) do
        if ox_inventory:CanCarryItem(playerId, k, v) then
            ox_inventory:AddItem(playerId, k, v)
        end
    end
end)