local function ambilKayu()
    if lib.progressCircle({
        duration = 3000,
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'melee@hatchet@streamed_core',
            clip = 'plyr_rear_takedown_b'
        },
    }) then
        lib.callback.await('sr_job:dapetKayu', false)
    end

end

local function potongKayu()
    for k, v in pairs(Lumberjack.Items.potongKayu.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                description = ('Kamu kekurangan %sx %s'):format(v, Items[k].label),
            })
            return
        end
    end

    if lib.progressCircle({
        duration = 11000,
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then
        lib.callback.await('sr_job:potongKayu', false)
    end

end

local function kemasKayu()
    for k, v in pairs(Lumberjack.Items.kemasKayu.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                description = ('Kamu kekurangan %sx %s'):format(v, Items[k].label),
            })
            return
        end
    end

    if lib.progressCircle({
        duration = 11000,
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then print('KELAR') 
        lib.callback.await('sr_job:kemasKayu', false)
    end

end

CreateThread(function ()
    for k, v in pairs(Lumberjack.AmbilKayu) do
        ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Ambil Kayu',
                    onSelect = ambilKayu
                }
            }
        })
    end

    for k, v in pairs(Lumberjack.PotongKayu) do
        ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Potong Kayu',
                    onSelect = potongKayu
                }
            }
        })
    end

    for k, v in pairs(Lumberjack.KemasKayu) do
        ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Kemas Kayu',
                    onSelect = kemasKayu
                }
            }
        })
    end
end)