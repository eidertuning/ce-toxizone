Config = {}

-- Define toxic zones
Config.ToxicZones = {
    {
        coords = vector3(1645.4067, 3250.5313, 40.4910),
        radius = 100.0,
        minDamage = 5,
        maxDamage = 20,
        permanent = true,
        showBlip = true,
        notifyPlayer = true,
        blip = {
            sprite = 9,
            color = 1,
            scale = 1.0
        },
        prop = 'prop_barrel_02a'  -- aquí puedes especificar tu propio prop
    },
    {
        coords = vector3(2345.67, 2345.67, 2345.67),
        radius = 150.0,
        minDamage = 9,
        maxDamage = 30,
        permanent = false,
        duration = 300,
        showBlip = false,  -- new
        notifyPlayer = true,
        blip = {
            sprite = 310,
            color = 1,
            scale = 1.0
        },
        prop = 'prop_barrel_02a'  -- aquí puedes especificar tu propio prop
    }
}

-- Define new toxic zone creation interval (in seconds)
Config.NewZoneInterval = 600

-- Define protection items
Config.ProtectionItems = {
    ["nbq_suit"] = {
        label = "Traje NBQ",
        maleUniform = {
            outfitData = {
                ["pants"]       ={item=3 ,texture=0},
                ["arms"]        ={item=15 ,texture=0},
                ["t-shirt"]     ={item=15 ,texture=0},
                ["vest"]        ={item=9 ,texture=0},
                ["torso2"]      ={item=11 ,texture=0},
                ["shoes"]       ={item=25 ,texture=0},
                ["decals"]      ={item=0 ,texture=0},
                ["accessory"]   ={item=0 ,texture=0},
                ["bag"]         ={item=0 ,texture=0},
                ["hat"]         ={item=-1 ,texture=-1},
                ["glass"]       ={item=0 ,texture=0},
                ["ear"]         ={item=-1 ,texture=-1},
                ["mask"]        ={item=46 ,texture=0}
            }
        },
        femaleUniform={
            outfitData={
                ["pants"]       ={item=19 ,texture=2},
                ["arms"]        ={item=14 ,texture=0},
                ["t-shirt"]     ={item=15 ,texture=0},
                ["vest"]        ={item=9 ,texture=1},
                ["torso2"]      ={item=11 ,texture=1},
                ["shoes"]       ={item=26 ,texture=0},
                ["decals"]      ={item=0 ,texture=0},
                ["accessory"]   ={item=0 ,texture=0},
                ["bag"]         ={item=0 ,texture=0},
                ["hat"]         ={item=-1 ,texture=-1},
                ["glass"]       ={item=5 ,texture=2},
                ["ear"]         ={item=-1 ,texture=-1},
                ["mask"]        ={item=46 ,texture=0}
            }
        }
    }
}
