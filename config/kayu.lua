Lumberjack = {}

Lumberjack.Items = {
    ambilKayu = {
        add = {
            wood = 1,
		}
    },
    potongKayu = {
        add = {
            cutted_wood = 1,
        },
        require = {
            wood = 1,
        }
    },
    kemasKayu = {
        add = {
            packaged_plank = 1,
        }, 
        require = {
            cutted_wood = 1,
        }
    }
}


Lumberjack.AmbilKayu = {
    {
        name = "Ambil Kayu",
        coords = vec3(-463.45, 5385.43, 81.0),
        size = vec3(13.0, 20.0, 4.0),
        rotation = 340.0,
    },
    
}

Lumberjack.PotongKayu = {
    {
        name = "Potong Kayu",
        coords = vec3(-594.25, 5329.76, 70.0),
        size = vec3(4.0, 4.0, 4.0),
        rotation = 340.0,
    },
}

Lumberjack.KemasKayu = {
    {
        name = "Kemas kayu",
        coords = vec3(-594.54, 5368.23, 70.0),
        size = vec3(7.0, 5.0, 4.0),
        rotation = 30.0,
    },
    
}