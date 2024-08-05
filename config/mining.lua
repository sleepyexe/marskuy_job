Mining = {}

Mining.Items = {
    pickStone = {
        add = {
            stone = 10,
        }
    },
    washStone = {
        add = {
            washed_stone = 10,
        },
        require = {
            stone = 10, -- cannot be table
        }
    },
    smeltStone = {
        add = {
            diamond = {
                chance = 0.2,
                amount = 1
            },
            blackdiamond = {
                chance = 0.3,
                amount = 1
            },
            copper = {
                chance = 0.5,
                amount = 5,
            },
            iron = {
                chance = 0.5,
                amount = 5,
            },
            gold = {
                chance = 0.5,
                amount = 5,
            }
        },
        require = {
            washed_stone = 5, -- cannot be table
        }
    }
}

-- set ke false untuk matiin skill check
Mining.SkillCheck = {
    washStone = {'easy', 'easy', 'easy'},
    smeltStone = {'easy', 'easy', 'easy'},
    pickStone = {'easy', 'easy', 'easy'},
}

--[[
    Dev Note
    Terkait zona ox_lib
    https://overextended.dev/ox_lib/Modules/Zones/Shared
]]

-- ini zone box
-- untuk bikin zone pake /zone box
Mining.AmbilBatu = {
    {
        blip = {
            label = "Ambil Batu",
            sprite = 527,
            scale = 0.8,
            color = 5,
        },
        name = "Ambil Batu",
        coords = vec3(2983.08, 2750.5, 44.0),
        size = vec3(3.0, 1, 4.0),
        rotation = 25.0,
    },
    {
        blip = {
            label = "Ambil Batu",
            sprite = 527,
            scale = 0.8,
            color = 5,
        },
        name = "Ambil Batu",
        coords = vec3(2998.99, 2750.99, 44.9),
        size = vec3(3.0, 1, 4.0),
        rotation = 50.0,
    },
}

-- Ini zone sphere
-- untuk bikin zone pake /zone sphere
Mining.CuciBatu = {
    {
        blip = {
            label = "Cuci Batu",
            sprite = 527,
            scale = 0.8,
            color = 5,
        },
        name = "Cuci Batu",
        coords = vec3(1179.54, -206.74, 54.0),
        radius = 7.7,
    },
    {
        blip = {
            label = "Cuci Batu",
            sprite = 527,
            scale = 0.8,
            color = 5,
        },
        name = "Cuci Batu",
        coords = vec3(1146.31, -141.55, 55.0),
        radius = 4.0,
    },
}

-- ini zone box
-- untuk bikin zone pake /zone box
Mining.Smelting = {
    {
        blip = {
            label = "Smelting",
            sprite = 527,
            scale = 0.8,
            color = 5,
        },
        name = "Smelting",
        coords = vec3(1086.64, -2003.49, 31.0),
        size = vec3(4.0, 4.0, 4.0),
        rotation = 320.0,
    },
}