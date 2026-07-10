const std = @import("std");
const ascii = std.ascii;

pub fn isIsogram(str: []const u8) bool {
    var alphabet: [26]u2 = @splat(0);

    for (str) |char| {
        if (!ascii.isAlphabetic(char)) continue;

        const pos = ascii.toLower(char) - 'a';
        alphabet[pos] += 1;
        if (alphabet[pos] > 1) {
            return false;
        }
    }

    return true;
}
