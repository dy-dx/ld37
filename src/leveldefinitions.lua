local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 5,
        nav = {fuckeryRate = 0.5},
        ventgas = {},
        cutsceneDialogue = {
            'testing',
            'After 20 years captaining your own ship, the LEONCAT, you may have finally run out of luck.',
            'Like usual, you\'re currently trying to deliver supplies across the galaxy ...',
            'and, like usual, you may not get the job done in time.',
            'LEONCAT is on it\'s last legs and might not make it.',
            'Your crew is tired of not getting paid and may leave mid-trip.',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas"},
        duration = 35,
        nav = {fuckeryRate = 0.01},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10, initialGas = 150, initialWaste = 100},
        cutsceneDialogue = {
            'It is the year 02',
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
            'It is the year 03',
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
            'It is the year 04',
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
            'It is the year 05',
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
