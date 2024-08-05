local points = {}
local entities = {}
local lastCoords = nil
local tpCoords = vec4(2384.0679, 5049.2808, 46.4279, 55.6842)
local chickenCoords = vec4(2377.8777, 5052.7881, 46.4446, 323.0136)
local totalCatch = 0
local isCatching = false

local function catchChicken(entity)
    if lib.progressBar({
        duration = 1500,
        label = 'Catching Chicken',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'random@domestic',
            clip = 'pickup_low'
        }
    }) then 
        if Chicken.Catch.random then
            local chance = math.random(1, 100)
            if chance >= 80 then
                lib.notify({
                    description = 'Ayam terlepas dari tangan kamu'
                })
                return false
            end
        end
        for k, v in pairs(entities) do
            if v == entity then
                utils.deletePed(v)
                table.remove(entities, k)
            end
        end
        totalCatch += 1
        if totalCatch >= 10 then
            isCatching = false
            totalCatch = 0
            if lastCoords then
                DoScreenFadeOut(500)
                Wait(500)
                SetEntityCoordsNoOffset(cache.ped, lastCoords.x, lastCoords.y, lastCoords.z, false, false, true)
                DoScreenFadeIn(500)
            end
        end
        lib.callback.await('sr_job:ayam', false)
    end
end

local function catchThread()
    while isCatching do
        for k, v in pairs(entities) do
            if v and DoesEntityExist(v) then
                local aCoords = GetEntityCoords(v)
                local bCoords = GetEntityCoords(cache.ped)
                utils.drawText3D(aCoords, '[E] - Tangkap Ayam', 1.0, 0)
                if #(aCoords - bCoords) < 2.0 then
                    if IsControlJustReleased(0, 38) then
                        catchChicken(v)
                    end
                end
            end
        end
        Wait(0)
    end
end

local function catchChicken()
    isCatching = true
    lastCoords = GetEntityCoords(cache.ped)
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoordsNoOffset(cache.ped, tpCoords.x, tpCoords.y, tpCoords.z, false, false, true)
    SetEntityHeading(cache.ped, tpCoords.w)
    DoScreenFadeIn(500)
    local opts = {}

    for i = 1, 10 do
        local randX = math.random(1 , 8)
        local randY = math.random(1, 8)
        opts[i] = {
            ped = 'a_c_hen',
            coords = vec4(chickenCoords.x + randX, chickenCoords.y + randY, chickenCoords.z, chickenCoords.w),
        }
    end
    entities = utils.createLocalPed(opts) ---@diagnostic disable-line
    CreateThread(catchThread)
end

local function cutChicken()
    for k, v in pairs(Chicken.Items.cutChicken.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
            })
            return
        end
    end

    if lib.progressCircle({
        duration = 1500,
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
            dict = 'anim@amb@business@coc@coc_unpack_cut_left@',
            clip = 'coke_cut_v1_coccutter'
        },
    }) then 
        lib.callback.await('sr_job:potongAyam', false)
     end

end

local function packChicken(heading)
   for k, v in pairs(Chicken.Items.packChicken.require) do
        if not utils.HasItem(k, v) then
            lib.notify({
                title = 'Inventory',
                description = ('Kamu kekurangan %x %s'):format(v, Items[k].label)
            })
            return
        end
    end
    SetEntityHeading(cache.ped, heading)

    if lib.progressCircle({
        duration = 8000,
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
            dict = 'anim@heists@ornate_bank@grab_cash_heels',
            clip = 'grab',
            flag = 33,
        },
        prop = {
            {
                bone = 57005,
                model = 'prop_cs_clothes_box',
                pos = vec3(0.13, 0.14, 0.09),
                rot = vec3(250.0, -30.0, 0.0)
            },
            {
                bone = 0x49D9,
                model = 'prop_cs_steak',
                pos = vec3(0.15, 0.08, 0.01),
                rot = vec3(0.0, 0.0, 0.0)
            }
        }
    }) then 
        lib.callback.await('sr_job:packAyam', false)
     end
end


CreateThread(function ()
    local ptsAyam = lib.points.new({
        coords = Chicken.Catch.coords,
        distance = Chicken.Catch.radius,
        onEnter = function (self)
            local ped = utils.spawnPed({
                ped = Chicken.Catch.ped,
                coords = Chicken.Catch.coords,
            })
            ox_target:addLocalEntity(ped, {
                {
                    label = 'Mulai nangkap ayam',
                    onSelect = catchChicken
                }
            })
            self.entity = ped
        end,
        onExit = function (self)
            utils.deletePed(self.entity)
            self.entity = nil
        end
    })

    local zone = lib.zones.sphere({
        name = "Cage Ayam",
        coords = vec3(2379.45, 5053.14, 46.0),
        radius = 13.5,
        onExit = function ()
            if not isCatching then return end
            lib.notify({
                description = 'Kamu keluar dari kandang ayam'
            })
            for k, v in pairs(entities) do
                if v then
                    utils.deletePed(v)
                end
            end
            isCatching = false
        end
    })
    points[#points+1] = zone
    points[#points+1] = ptsAyam
    for k, v in pairs(Chicken.Cut) do
        ox_target:addBoxZone({
            name = v.name,
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Cut Chicken',
                    onSelect = cutChicken
                }
            }
        })
    end

    for k, v in pairs(Chicken.Pack) do
        ox_target:addBoxZone({
            name = v.name,
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            options = {
                {
                    label = 'Pack Chicken',
                    onSelect = function ()
                        packChicken(v.heading)
                    end
                }
            }
        })
    end

end)

AddEventHandler('onResourceStop', function (res)
    if res ~= GetCurrentResourceName() then return end
    for k, v in pairs(entities) do 
        if v then
            utils.deletePed(v)
        end
    end
    for k, v in pairs(points) do
        if v then
            if v.entity then
                utils.deletePed(v.entity)
            end
            v:remove()
        end
    end
end)