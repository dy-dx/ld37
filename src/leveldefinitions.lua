local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 5,
        nav = {fuckeryRate = 0.5},
        ventgas = {},
        cutsceneDialogue = {
            'It is the year blah blah blah',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas"},
        duration = 35,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10, initialGas = 150, initialWaste = 100},
        cutsceneDialogue = {
            'It is the year blah blah blah',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
        cutsceneDialogue = {
            'It is the year blah blah blah',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
        cutsceneDialogue = {
            'It is the year blah blah blah',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand", "plumbing"},
        duration = 30,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
        cutsceneDialogue = {
            'It is the year blah blah blah',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {},
        duration = 0,
        ventgas = {},
        cutsceneDialogue = {
            'you win',
        },
    },
}

return levelDefinitions
