-- gameplay/player_style_profiles.lua
-- Style stats and rarity multipliers for player power, jump, and ability scaling.

local PlayerStyleProfiles = {}

PlayerStyleProfiles.Rarity = {
    Common = { multiplier = 1.0 },
    Rare = { multiplier = 1.12 },
    Legendary = { multiplier = 1.28 },
    Godly = { multiplier = 1.45 },
    Secret = { multiplier = 1.72 },
}

PlayerStyleProfiles.Default = {
    jumpMultiplier = 1.0,
    walkSpeedMultiplier = 1.0,
    spikePowerMultiplier = 1.0,
    blockMultiplier = 1.0,
    ability = "BoomJump",
}

function PlayerStyleProfiles.applyStyle(base, styleName)
    local rarity = PlayerStyleProfiles.Rarity[styleName] or { multiplier = 1.0 }
    local profile = base or PlayerStyleProfiles.Default

    return {
        jumpMultiplier = profile.jumpMultiplier * rarity.multiplier,
        walkSpeedMultiplier = profile.walkSpeedMultiplier * rarity.multiplier,
        spikePowerMultiplier = profile.spikePowerMultiplier * rarity.multiplier,
        blockMultiplier = profile.blockMultiplier * rarity.multiplier,
        ability = profile.ability,
    }
end

return PlayerStyleProfiles
