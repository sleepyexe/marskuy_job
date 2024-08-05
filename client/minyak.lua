local function takePetrol()
    if lib.progressCircle({
        duration = 11000,
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then 
        lib.callback.await('sr_job:takePetrol', false)
    end
end

local function proccessPetrol()
    for k, v in pairs(Fueler.Items.processPetrol.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
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
            move = true,
            combat = true
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then
        lib.callback.await('sr_job:processPetrol', false)
    end
end

local function proccessRaffin()
    for k, v in pairs(Fueler.Items.processPetrol.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
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
            move = true,
            combat = true
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then
        lib.callback.await('sr_job:processRaffin', false)
    end
end

CreateThread(function ()
    for k, v in pairs(Fueler.TakePetrol) do
        ox_target:addBoxZone({
            name = v.name,
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Take Petrol',
                    onSelect = function ()
                        takePetrol()
                    end
                }
            }
        })
    end

    for k, v in pairs(Fueler.ProccessPetrol) do
        ox_target:addBoxZone({
            name = v.name,
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Proccess Petrol',
                    onSelect = function ()
                        proccessPetrol()
                    end
                }
            }
        })
    end

    for k, v in pairs(Fueler.ProccessRaffin) do
        ox_target:addBoxZone({
            name = v.name,
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Proccess Raffin',
                    onSelect = function ()
                        proccessRaffin()
                    end
                }
            }
        })
    end
end)