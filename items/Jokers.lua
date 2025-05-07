-- this file is to explain both some very simple and some advance example of jokers

SMODS.Joker{ -- this is a joker that uses a localization file, you can modify the text that is displayed by this joker in the Localization/en-us.lua
    key = "examplejoker", -- this is the key that we will use to tell the localization what joker to add the text and name to
    pos = {x = 0, y = 0}, -- this is what determines the sprite that the joekr will use from the atlas it is assigned to
    rarity = 1, -- this is what determines the rarity of the joker (1 = common, 2 = uncommon, 3 = rare, and 4 = Legendary)
    atlas = "PLH", -- this is the key that determines what atlas the joker will use, this is the same as the key in the atlas function in main.lua
    config = { extra = {mult = 4} },  -- the config is used to make basic effects for our jokers
    cost = 6, -- this is the cost of the joker in the shop, and its sell value is half of what the cost to buy is, so this joker would sell for 3 dollars
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then -- the context that is used to make the jokers ability trigger after cards have finished scoring
            return {mult = card.ability.extra.mult} -- this is how we make the joker give the mult, you can try replacing mult with other calculation keys which can be found here https://github.com/Steamodded/smods/blob/bb6548eb6741ad10b3e4160dae32305e37055815/src/utils.lua#L1430
        end
    end,
}

SMODS.Joker{
    key = "examplejoker2",
    pos = {x = 0, y = 0},
    rarity = 1,
    atlas = "PLH",
    config = { extra = {mult = 4} },
    cost = 6,
    loc_txt = { -- this is how you can add text to your joker without having a localization file for your mod
        name = "Example Joker 2",
        text = {
            "This is an example joker.",
            "It can be used to demonstrate how to create a joker.",
            "You can customize the text and effects as needed.",
            "this Joker give {C:mult}+#1#{} mult",
            "{C:inactive} this joker uses loc_txt instead of the en-us.lua file"-- the {C:inactive} is what gives the text the transparent gray color and #1# is the first variable that is in the jokers config and the {} ends the colored text without having to start a new line
        }
    },
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {mult = card.ability.extra.mult}
        end
    end,
}

--[[
-- this joker is will not work, it is here for you to try and fix with what you know about with creating simple jokers and how to fix some crashes caused by them
SMODS.Joker{
    key = "examplejoker3",
    pos = {x = 0, y = 0},
    rarity = 1,
    atlas = "PLH",
    config = { extra = {mult = 4} },
    cost = 6,
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return {mult = card.ability.extra.mult}
        end
    end,
}
--]]

SMODS.Joker {
    key = "examplejoker4",
    pos = {x = 0, y = 0},
    rarity = 3,
    atlas = "PLH",
    config = { extra = {X_mult = 2, mult_mod = 0.5} },
    cost = 6,
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.X_mult, center.ability.extra.mult_mod } }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then 
            card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_mod -- this is how we make the jokers Xmult Scale with each scored card
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {Xmult_mod = card.ability.extra.X_mult}
        end
    end,
}

SMODS.Joker {
    key = "examplejoker5",
    pos = {x = 0, y = 0},
    rarity = 2,
    atlas = "PLH",
    config = { extra = {mult = 4} },
    cost = 6,
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card.base.nominal == 2 then -- this is how we make it so then only 2s will trigger this joker if it is scored
                return {mult = card.ability.extra.mult} -- this is where we tell the game what our joker effect will be
            end
        end
    end,
}

SMODS.Joker {
    key = "examplejoker6",
    pos = {x = 0, y = 0},
    rarity = 3,
    atlas = "PLH",
    config = { extra = {mult = 4, chips = 10} },
    cost = 6,
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.mult, center.ability.extra.chips } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card.base.nominal == 2 then -- this is how we make it so then only 2s will trigger this joker if it is scored
                return {mult = card.ability.extra.mult} -- this is where we tell the game what our joker effect will be
            end
            if context.other_card.base.nominal == 7 then
                return {chips = card.ability.extra.chips} -- this is where we tell the game what our joker effect will be
            end
            if context.other_card.base.id == 14 then
                return {mult = card.ability.extra.mult, chips = card.ability.extra.chips} -- this is where we tell the game what our joker effect will be
            end
        end
    end,
}