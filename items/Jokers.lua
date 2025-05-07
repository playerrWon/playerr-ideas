SMODS.Joker{
    key = "lucky7s",
    pos = {x = 0, y = 0},
    rarity = 3,
    atlas = "PLH",
    config = { extra = { X_mult = 1, mult_mod = 0.1 } },
    cost = 6,
    loc_txt = {
        name = "Lucky 7s",
        text = {
            "can't bother to work out text"
        }
    },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
         if context.other_card.lucky_trigger and not context.blueprint then
            return { Xmult_mod = card.ability.extra.X_mult }
        end
        end
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 7) then
            return {
                x_mult = card.ability.extra.X_mult
            }
        end
    end

}
