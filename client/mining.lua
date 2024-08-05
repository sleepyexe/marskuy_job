local function washStone()
    if Mining.SkillCheck.washStone then
        local success = lib.skillCheck(Mining.SkillCheck.washStone, {'e'})
        if not success then
            lib.notify({
                title = 'Skill Check',
                description = 'Gagal',
                type = 'error'
            })
            return
        end
    end

    for k, v in pairs(Mining.Items.washStone.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu tidak memiliki %s'):format(Items[k].label),
                type = 'error'
            })
            return
        end
    end

    if lib.progressCircle({
        duration = 11000,
        position = 'bottom',
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then 
        lib.callback.await('mr_job:washStone', false)
     end
end

local function ambilBatu()
    if Mining.SkillCheck.pickStone then
        local success = lib.skillCheck(Mining.SkillCheck.pickStone, {'e'})
        if not success then
            lib.notify({
                title = 'Skill Check',
                description = 'Gagal',
                type = 'error'
            })
            return
        end
    end
    if lib.progressCircle({
        duration = 3000,
        position = 'bottom',
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = "amb@world_human_hammering@male@base",
            clip = "base"
        },
        prop = {
            model = 'prop_tool_pickaxe',
            bone = 57005,
            pos = vec3(0.09, -0.53, -0.22),
            rot = vec3(252.0, 180.0, 0.0),
        }
    }) then 
        lib.callback.await('mr_job:getStone', false)
     end
end

local function smeltStone()
    for k, v in pairs(Mining.Items.smeltStone.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu tidak memiliki %s'):format(Items[k].label),
                type = 'error'
            })
            return
        end
    end

    if Mining.SkillCheck.smeltStone then
        local success = lib.skillCheck(Mining.SkillCheck.smeltStone, {'e'})
        if not success then
            lib.notify({
                title = 'Skill Check',
                description = 'Gagal',
                type = 'error'
            })
            return
        end
    end

    if lib.progressCircle({
        duration = 11000,
        position = 'bottom',
        label = 'Proses',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then 
        lib.callback.await('mr_job:smeltStone', false)
     end 
end

CreateThread(function ()
    for k, v in pairs(Mining.AmbilBatu) do

        if v.blip then
            v.blip.coords = v.coords
            utils.createBlip(v.blip)
        end

        ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            name = v.name,
            options = {
                {
                    label = v.name,
                    icon = 'fa-regular fa-hand',
                    onSelect = ambilBatu
                }
            }
        })
    end

    for k, v in pairs(Mining.CuciBatu) do
        if v.blip then
            v.blip.coords = v.coords
            utils.createBlip(v.blip)
        end
        ox_target:addSphereZone({
            coords = v.coords,
            radius = v.radius,
            onEnter = function ()
                lib.showTextUI('[ALT] - Cuci Batu')
            end,
            onExit = function ()
                lib.hideTextUI()
            end,
            options = {
                {
                    label = 'Cuci Batu',
                    icon = 'fa-regular fa-hand',
                    onSelect = washStone,
                }
            }
        })
    end

    for k, v in pairs(Mining.Smelting) do
        if v.blip then
            v.blip.coords = v.coords
            utils.createBlip(v.blip)
        end
        ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            name = v.name,
            options = {
                {
                    label = v.name,
                    icon = 'fa-solid fa-hammer',
                    onSelect = smeltStone,
                }
            }
        })
    end
end)