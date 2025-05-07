-- this file is an example of what is generally in a main lua file 

-- the SMODS functions such as SMODS.Joker are also case sensitive, so if you use SMODS.joker instead of SMODS.Joker the joker you coded will not appear in the game, the same goes for any other SMODS method

if not ExampleMod then -- this is used to make sure that the mod is not loaded multiple times, and it is used to make sure that the mod is not loaded in a different order than it should be
    ExampleMod = {}
end

ExampleMod = {
    show_options_button = true,
}

ExampleMod = SMODS.current_mod
ExampleMod_config = ExampleMod.config -- this is the config file that is used to store the mods settings, and it is used to make sure that the mods config is loaded correctly
ExampleMod.enabled = copy_table(ExampleMod_config) -- this is the current state of the mods settings, and it is used to make sure that the mods config settings are saved

-- to make your config actually register and work you will need to add the lines 3, 4, and 5 to your mod, and you can replace the ExampleMod with your mods name

-- When making a Sprite For Balatro you need to have a 1x and a 2x file, because the 1x is used for no pixel art smothing, and 2x is used for pixel art smothing
SMODS.Atlas({
    object_type = "Atlas",
    key = "PLH", -- this is what you put in your atlas in your joker, consumable, or any other modded item, an example of this can be found in Items/Jokers.lua on line 8
    path = "placeholders.png",-- this is the name of the file that your sprites will use from your assets folder
    px = 71,
    py = 95,-- the standard 1x size of any joker or consumable is 71x95
})
-- do note that the key and path of an atlas is case sensitive, so make sure you are using the correct capitalization


-- this is where we will register other files from within this mods folder such as stuff from our Items folder, tho if you don't want to load that file you can comment it out by adding "--" aty the start of the line
-- when setting the files path you need to make sure that you are using the correct capitalization, because if you don't, your mod will crash on linux platforms
assert(SMODS.load_file("Items/Jokers.lua"))()
assert(SMODS.load_file("Items/Consumables.lua"))() -- this is where you will find how you can make a custom consumable type or just create a consumable of a pre-existing type
assert(SMODS.load_file("Items/Misc.lua"))()
assert(SMODS.load_file("Lib/Utility.lua"))() -- this is the file where we add the code to initialize the config menu and other utility functions