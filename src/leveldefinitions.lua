local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 5,
        nav = {fuckeryRate = 0.5},
        ventgas = {},
    },
    {
        activeGames = {"nav", "ventgas"},
        duration = 35,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10, initialGas = 150, initialWaste = 100},
    },
    {
        activeGames = {"nav", "ventgas", "spinner"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand", "plumbing"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
    },
    {
        activeGames = {},
        duration = 0,
        ventgas = {},
    },
}

return levelDefinitions
