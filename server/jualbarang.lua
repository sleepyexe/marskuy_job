lib.callback.register('sr_job:jualBarang', function (playerId, item, amount, price)
    local jumlah = ox_inventory:Search(playerId, 'count', item)
    if jumlah < amount then
        lib.notify(playerId, {
            description = ('Kamu kekurangan %sx %s'):format(amount - jumlah, Items[item].label),
        })
        return
    end
    local total = amount * price
    if ox_inventory:RemoveItem(playerId, item, amount) then
        lib.notify(playerId, {
            description = ('Kamu menjual %sx %s'):format(amount, Items[item].label),
            amount = total,
        })
        ox_inventory:AddItem(playerId, 'money', total)
    end
end)