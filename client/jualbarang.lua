local points = {}


local function jualBarang(items)
    local options = {}
    for k, v in pairs(items) do
        options[#options+1] = {
            title = ('%s - $%s'):format(Items[k] and Items[k].label or 'Invalid Item', lib.math.groupdigits(v)),
            icon = ('nui://ox_inventory/web/images/%s.png'):format(k),
            image = ('nui://ox_inventory/web/images/%s.png'):format(k),
            onSelect = function ()
                if not Items[k] then
                    lib.notify({
                        title = 'Error',
                        description = 'Invalid Item',
                        type = 'error'
                    })
                    return
                end
                local input = lib.inputDialog(('Jual %s'):format(Items[k].label), {
                    { type = 'number', label = 'Jumlah', min = 1, max = ox_inventory:Search('count', k), placeholder = '' },
                })
                if not input then return end
                lib.callback.await('sr_job:jualBarang', false, k, input[1], v)
            end
        }
    end
    lib.registerContext({
        id = 'ctx_jual_beli',
        title = 'Jual Barang',
        options = options,
    })
    lib.showContext('ctx_jual_beli')
end

CreateThread(function ()
    for k, v in pairs(JualBarang.Lokasi) do
        if v.blips then
            v.blips.coords = v.coords
            utils.createBlip(v.blips)
        end
        points[#points+1] = lib.points.new({
            coords = v.coords,
            distance = 20.0,
            onEnter = function (self)
                local ped = utils.spawnPed({
                    ped = v.ped,
                    coords = v.coords,
                })
                ox_target:addLocalEntity(ped, {
                    {
                        label = 'Mulai Jual Barang',
                        onSelect = function ()
                            jualBarang(v.items)
                        end
                    }
                })
            end,
            onExit = function (self)
                utils.deletePed(self.entity)
                self.entity = nil
            end
        })
    end
end)

AddEventHandler('onResourceStop', function (res)
    if res ~= GetCurrentResourceName() then return end
    for k, v in pairs(points) do
        if v then
            if v.entity then
                utils.deletePed(v.entity)
            end
            v:remove()
        end
    end
end)