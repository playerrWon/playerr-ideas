SMODS.Joker {
    key = "payout",
    pos = {x = 0, y = 0},
    rarity = 3,
    atlas = "PLH",
    config = { extra = { X_mult = 1, mult_mod = 0.1 } },
    cost = 6,
    loc_txt = {
        name = "Payout",
        text = {
            "{C:attention} 7s {} give {C:Mult}x# Mult {} when scored"
            "Increases by {C:Mult}x0.1 {} when {C:attention}Lucky Card {} activates
        } 
    },
    loc_vars = function (self, info_queue, center)
        return { vars = { center.ability.extra.X_mult, center.ability.extra.mult_mod } }
    end,
    calculate = function (self, card, context)
        if context.individual and context.other_card.lucky_trigger then
            card.ability.extra.X_mult = card.ability.extra.X_mult + card.ability.extra.mult_mod
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.nominal == 7 then
                return {xmult = card.ability.extra.X_mult}
            end
        end
    end,
}
