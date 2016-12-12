local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 5,
        nav = {fuckeryRate = 0.5},
    },
    {
        activeGames = {"nav", "ventgas"},
        duration = 15,
        nav = {fuckeryRate = 0.01},
    },
    {
        activeGames = {"nav", "ventgas", "spinner"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand", "plumbing"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
    },
    {
        activeGames = {},
        duration = 0,
    },
}

return levelDefinitions
