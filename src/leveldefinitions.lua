local levelDefinitions = {
    {
        activeGames = {"nav"},
        duration = 15,
        nav = {fuckeryRate = 1.2},
        ventgas = {},
        cutsceneDialogue = {
            'After 20 years captaining your own ship, the SPACEPAL, you may have finally run out of luck.',
            'Like usual, you\'re currently trying to deliver supplies across the galaxy ...',
            'and, like usual, you may not get the job done in time.',
            'SPACEPAL is on it\'s last legs and might not make it.',
            'Your crew is tired of not getting paid and may leave mid-trip.',
            'No matter what, you have to keep the ship moving and complete your deliveries.',
            'If you don\'t, you won\'t have enough money to pay the intergalactic bank and they\'ll repo your beloved pal.',
            'Your autopilot system has shut down! I guess that\'s what happens when you\'re too cheap to give your internal systems any TLC (tender loving care, not the seminal 1990s girls group of Waterfalls and CrazySexyCool fame)',
            'Stay on course by pressing the up and down arrows and making sure your ship stays on its path.',
        },
    },
    {
        activeGames = {"nav", "ventgas"},
        duration = 20,
        nav = {fuckeryRate = 0.3},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10, initialGas = 180, initialWaste = 100},
        cutsceneDialogue = {
            'So, now you have no pilot. Good riddance, I say -- turns out the autopilot was doing most of his work anyway.',
            'After initial analysis I\'ve determined that his main job was to maintain the ship\'s stabilization levels.',
            'You\'ll have to take this on to make sure we get to our next destination. Hold on -- it may be a bumpy ride.',
            'Click on the panel screen where the pilot once was and maintain stabilization levels.',
            'You\'ll have to vent gas to avoid CO2 build up and make sure to get rid of that waste as well. Try not to vent oxygen by accident, or it might get a little hard to breathe in here.'
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner"},
        duration = 30,
        nav = {fuckeryRate = 0.1},
        ventgas = {gasGrowthRate = 20, wasteGrowthRate = 10},
        spinner = {timeToPill = 4},
        cutsceneDialogue = {
            'Doctor: Look Captain, I appreciate you getting us in safely, but during all of that turbulence my life flashed before my eyes ...',
            'Doctor: and, to be honest, I\'m not happy with what I saw. Whatever happened to my childhood dream of becoming a folk musician? When did I decide to throw that all away for a doctor?',
            'Doctor: I\'ve decided that it\'s time to reclaim my life path - if I\'m not going to get paid, I may as well be doing what I love. The Doctor, out..',
            'Whoaaaa, we\'re halfway there ... You get the idea. ',
            'In the words of the late, great Bob Marley: No Pilot or Doctor, No Cry. To keep the ship in the air, you will need to take on the Doctor\'s main responsibility',
            'Click on the panel the doctor occupied and make sure to get rid of the pills as they enter the tube! Click the corresponding pill color on the spinner to sort the pill properly',
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
            'Three deliveries down, one to go... ',
            'I wasn\'t able to fully translate what your Head of Security said right before we docked, so I\'ll just note that it was ... not complimentary.',
            'Suffice it to say she\'s not coming back and you\'ll now need to take on her defense duties to ensure that we arrive at our next destination safely.',
            'Protect the ship by activating missile defense and neutralizing incoming missiles. Click on the panel formally occupied by security and click to fire missiles and destroy incoming bullets!',
        },
    },
    {
        activeGames = {"nav", "ventgas", "spinner", "misslowcommand", "plumbing"},
        duration = 30,
        nav = {fuckeryRate = 0.1},
        ventgas = {gasGrowthRate = 10, wasteGrowthRate = 5},
        spinner = {timeToPill = 6},
        misslowcommand = {speed = 30, timeToMissile = 12},
        plumbing = {fluidRate = 0.10, startBufferFluidRate = 0.03},
        cutsceneDialogue = {
            'Chief Engineer: Now that there are only two of us, we\'ll be splitting this payload 50/50, right? ... WHAT? What do you mean I still only get 10%?? That\'s it, I\'m out of here.',
            'Almost there! As I would be wiped if the ship were to explode, you have my sincere thanks for getting us this far...',
            'Well, you\'ve got 99 problems but a crew ain\'t one. It\'s all up to you, now. In addition to your other work, you\'ll need to take on the Chief Engineer\'s main task of ensuring the pipe system allows for the coolant to flow through.',
            'You\'ll have to move the pipes around to make sure the path connects, and feel free to use the spare pipe.',
        },
    },
    {
        activeGames = {},
        duration = 0,
        ventgas = {},
        cutsceneDialogue = {
            'Alright, we\'re almost in range of our last delivery. Good work. ',
            'Because your whole crew has already left, you don\'t have anything new to do this time around except get SPACEPAL to its final destination.',
            'Congratulations! Thank you for playing.',
        },
    },
}

return levelDefinitions
