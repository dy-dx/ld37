local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 15,
        nav = {fuckeryRate = 1.2},
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
        duration = 20,
        nav = {fuckeryRate = 0.3},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10, initialGas = 180, initialWaste = 100},
        cutsceneDialogue = {
            'It is the year 02',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner"},
        duration = 30,
        nav = {fuckeryRate = 0.1},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
        spinner = {timeToPill = 4},
        cutsceneDialogue = {
            'It is the year 03',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand"},
        duration = 30,
        nav = {fuckeryRate = 0.14},
        ventgas = {gasGrowthRate = 15, wasteGrowthRate = 8},
        spinner = {timeToPill = 5},
        misslowcommand = {speed = 50, timeToMissile = 6},
        cutsceneDialogue = {
            'It is the year 04',
            'you are the captain',
            'click to start',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand", "plumbing"},
        duration = 30,
        nav = {fuckeryRate = 0.1},
        ventgas = {gasGrowthRate = 10, wasteGrowthRate = 5},
        spinner = {timeToPill = 6},
        misslowcommand = {speed = 30, timeToMissile = 12},
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
