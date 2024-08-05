Chicken = {}

Chicken.Items = {
    catchChicken = {
        add = {
            alive_chicken = 1,
        }
    },
    cutChicken = {
        add = {
            slaughtered_chicken = 1,
        },
        require = {
            alive_chicken = 1
        }
    },
    packChicken = {
        add = {
            packaged_chicken = 1,
        },
        require = {
            alive_chicken = 1
        }
    }
}

Chicken.Catch = {
    random = false, -- hidupin kalo hoki dapet ayam
    ped = 'a_m_m_farmer_01',
    coords = vec4(2388.5303, 5029.9990, 46.0226, 308.4417),
    radius = 10.0,
}

Chicken.Cut = {
    {
        name = "Potong ayam 1",
        coords = vec3(-95.11, 6207.58, 30.8),
        size = vec3(1.9, 1.0, 1.0),
        rotation = 314.5,
    },
    {
        name = "Potong ayam 2",
        coords = vec3(-99.97, 6202.03, 31.0),
        size = vec3(1, 1.9, 2.0),
        rotation = 315.0,
    },
}

Chicken.Pack = {
    {
        name = "Pack ayam 1",
        coords = vec3(-102.97, 6208.25, 31.0),
        size = vec3(13.5, 1.25, 1.5),
        rotation = 45.0,
        heading = 45.8850
    },
    {
        name = "Pack ayam 2",
        coords = vec3(-104.25, 6209.56, 31.0),
        size = vec3(13.5, 1.25, 1.5),
        rotation = 45.0,
        heading = 223.3217
    },
}
