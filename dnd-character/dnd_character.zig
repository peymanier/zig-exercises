const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var prng = std.Random.DefaultPrng.init(69);
    const rand = prng.random();

    var rolls: [4]i8 = undefined;
    for (0..rolls.len) |i| {
        rolls[i] = rand.intRangeAtMost(i8, 1, 6);
    }

    var sum: i8 = 0;
    for (rolls) |roll| {
        sum += roll;
    }

    var min: i8 = rolls[0];
    for (rolls[1..]) |roll| {
        if (roll < min) min = roll;
    }

    return sum - min;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        const constitution_modifier = modifier(constitution);
        return Character{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + constitution_modifier,
        };
    }
};
