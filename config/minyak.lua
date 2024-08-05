Fueler = {}

Fueler.Items = {
    takePetrol = {
        add = {
            petrol = {1, 3}
        }
    },
    processPetrol = {
        add = {
            petrol_raffin = {1, 3}
        },
        require = {
            petrol = 1
        }
    },
    processRaffin = {
        add = {
            essence = {1, 3}
        },
        require = {
            petrol_raffin = 1
        }
    },
}

Fueler.TakePetrol = {
    {
        name = "Take Petrol 1",
        coords = vec3(588.29, 2926.67, 41.0),
        size = vec3(4.25, 5.5, 4.0),
        rotation = 349.5,
    },
    {
        name = "Take petrol 2",
        coords = vec3(617.12, 2854.06, 40.0),
        size = vec3(4.25, 5.5, 4.0),
        rotation = 339.75,
    },
}

Fueler.ProccessPetrol = {
    {
        name = "Proses Petrol",
        coords = vec3(2773.82, 1495.67, 25.75),
        size = vec3(4.0, 10.0, 4.0),
        rotation = 345.0,
    },
}

Fueler.ProccessRaffin = {
    {
        name = "Proses Rafin",
        coords = vec3(2665.5, 1562.86, 26.0),
        size = vec3(12.0, 10.0, 4.0),
        rotation = 5.0,
    },
    
}