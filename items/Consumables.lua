-- this is an Example file of how to make a tarot, spectal, planet and your own custom consumables for balatro

SMODS.Consumable {
	set = "Tarot", -- this is what you will use to determine what type of consumable this item is, in this case it is a tarot
	name = "example tarot", -- this is the name that will be shown when hovering over the consumable in the collection
	key = "exampletarot", -- this is the key that we will use to tell the localization what consumable to add the text and name to
	pos = { x = 1, y = 2 }, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
  cost=3, -- this is the cost of the consumable in the shop, and its sell value is half of what the cost to buy is, but since its cost is not even we will round it down to 1 dollar
	atlas = "PLH", -- this is the key that determines what atlas the consumable will use, this is the same as the key in the atlas function in main.lua
	can_use = function(self, card) -- this is the function that determines if the consumable can be used or not, in this case it is useable if the number of highlighted cards is greater than or equal to the max_selected value in the config
		return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
	end,
  config = { extra = {max_selected = 3}}, -- this config determines how many cards can be selected when using the consumable, you can change this number to any number you want
	loc_vars = function(self, info_queue, card) -- this is the function that determines what variables will be shown when hovering over the consumable
    if card then
	    return { vars = { card.ability.extra.max_selected } }
    else
	    return { vars = { 0 } }
    end
	end,
	use = function(self, card, area, copier) -- this is the function that is used to make our consumable do its thing in this case we will be using it to change a number of selected cards into Diamonds
        local used_tarot = card or copier
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do -- this is the loop that will change the selected cards into Diamonds, you can change 'Diamonds' to any other suit such as 'Hearts', 'Clubs', or 'Spades'
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() SMODS.change_base(G.hand.highlighted[i],'Diamonds',nil);return true end })) 
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
	end,
}

SMODS.Consumable {
	set = "Spectral", -- this is what you will use to determine what type of consumable this item is, in this case it is a spectral
	name = "example spectral", -- this is the name that will be shown when hovering over the consumable in the collection
	key = "examplespectral", -- this is the key that we will use to tell the localization what consumable to add the text and name to
	pos = { x = 2, y = 2 }, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
  cost = 3, -- this is the cost of the consumable in the shop, and its sell value is half of what the cost to buy is, but since its cost is not even we will round it down to 1 dollar
	hidden = false, -- set to true to hide the item from the collection
	atlas = "PLH", -- this is the key that determines what atlas the consumable will use, this is the same as the key in the atlas function in main.lua
	can_use = function(self, card) -- in this can_use function we just make it return true so then it is always useable
		return true
	end,
  config = { extra = {num_jokers = 3}}, -- this is the config that will be used to determine how many jokers will be created when the consumable is used, you can change this number to any number you want
	loc_vars = function(self, info_queue, card) -- this is the function that determines what variables will be shown when hovering over the consumable
	  info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
	  return { vars = { card.ability.extra.num_jokers } }
	end,
	use = function(self, card, area, copier)
    local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('timpani')
      used_tarot:juice_up(0.3, 0.5)
      return true end }))
    for i=1,card.ability.extra.num_jokers do
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function() -- this is the function that will be used to create the 3 random jokers, you can change the number of jokers by changing the number in this consumables config, which is just above the loc_vars
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "exmp_examplespectral")
        card:set_edition({negative = true}, true)
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
  end
	end,
}

SMODS.Consumable {
    set = 'Planet', -- this is what you will use to determine what type of consumable this item is, in this case it is a planet
    key = 'exampleplanet', -- this is the key that we will use to tell the localization what consumable to add the text and name to
    config = { hand_type = "exmp_Royal_Flush", softlock = true}, -- this is the config that will be used to determine what type of hand this consumable will add a level to, in this case it is a Royal Flush
    pos = {x = 0, y = 2 }, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
    atlas = 'PLH', -- this is the key that determines what atlas the consumable will use, this is the same as the key in the atlas function in main.lua
    cost = 3, -- this is the cost of the consumable in the shop, and its sell value is half of what the cost to buy is, but since its cost is not even we will round it down to 1 dollar
    loc_vars = function(self, info_queue, card) -- this is the function that determines what variables will be shown when hovering over the consumable
        return { vars = { localize("exmp_hand_Royal_Flush"), -- this is the name of the hand that we will be adding a level to
        G.GAME.hands["exmp_Royal_Flush"].level, -- this is the current level of the hand we are upgrading
        G.GAME.hands["exmp_Royal_Flush"].l_chips, -- this is how many chips we are adding to the hand
        G.GAME.hands["exmp_Royal_Flush"].l_mult, -- this is how much mult we are adding to the hand
        } }
    end,
    generate_ui = 0, -- this is the function that will be used to create the ui for the consumable, in this case it is just a simple text box that shows the name of the hand and its level
}

-- here we will make a custom consumable type
if ExampleMod.config.example_config_toggle then -- if this config option is toggled o true, then this consumable will be added to the game, but if its false then it will not show up in the collection
  SMODS.ConsumableType {
    key = "ExampleSet", -- this is the key that we will use to tell the localization what consumable to add the text and name to
    collection_rows = {3,4}, -- this is the number of rows that the consumable will take up in the collection, in this case it is 3 rows and 4 columns
    primary_colour = HEX("FF0000"), -- this is the primary color of the consumable, you can change this to any color you want
    secondary_colour = HEX("00FF00"), -- this is the secondary color of the consumable, you can change this to any color you want
        loc_txt = { -- this is how you can add text to your consumable without having a localization file for your mod
          collection = "example cards",
          label = "example",
          name = "Example Set",
          undiscovered = {
              name = "example not discovered",
              text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does" -- this is the text that will be shown when the consumable is not discovered yet
            }
        },
    },
  }

  SMODS.UndiscoveredSprite {
    key = "exampleconsumable", -- this is the key that we will use to tell the localization what consumable to add the text and name to
    pos = {x = 0, y = 0}, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
    atlas = "PLH", -- this is the key that determines what atlas the consumable will use, this is the same as the key in the atlas function in main.lua
  }
end

if ExampleMod.config.example_config_toggle then -- if this config option is toggled o true, then this consumable will be added to the game, but if its false then it will not show up in the collection
  SMODS.Consumable{
    set = "ExampleSet", -- this is what you will use to determine what type of consumable this item is, in this case it is a example consumable
    name = "example consumable", -- this is the name that will be shown when hovering over the consumable in the collection
    key = "exampleconsume", -- this is the key that we will use to tell the localization what consumable to add the text and name to
    pos = {x = 1, y = 2}, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
    cost = 3, -- this is the cost of the consumable in the shop, and its sell value is half of what the cost to buy is, but since its cost is not even we will round it down to 1 dollar
    atlas = "PLH", -- this is the key that determines what atlas the consumable will use, this is the same as the key in the atlas function in main.lua
    config = { extra = {card_create = 1}}, -- this is the config that will be used to determine how many cards will be created when the consumable is used, you can change this number to any number you want
    loc_vars = function(self, info_queue, card) -- this is the function that determines what variables will be shown when hovering over the consumable
      return { vars = { card.ability.extra.card_create } }
    end,
    can_use = function (self, card)
      return true -- this is the function that determines if the consumable can be used or not, in this case it is useable if the number of highlighted cards is greater than or equal to the max_selected value in the config
    end,
    use = function(self, card, area, copier) -- this is the function that is used to make our consumable do its thing in this case we will be using it to create a number of cards
      local used_tarot = card or copier
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
      for i=1,card.ability.extra.card_create do -- this is the loop that will create the number of cards that we want to create, you can change the number in the config to any number you want
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() -- this is the function that will be used to create the cards
          play_sound('card1')
          local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, nil, "exmp_exampleconsume") -- this is the function that will be used to create the cards, you can change the type of card to any other type such as 'Joker', 'Tarot', or 'Spectral'
          card:set_edition({negative = true}, true) -- sets the created cards edition to negative upon creation
          card:add_to_deck() -- this is what actually adds the card to the deck
          G.consumeables:emplace(card) -- this is what places the created card in the specified area, in this case it is the consumable card area 
          return true end }))
      end
    end,
  }
end