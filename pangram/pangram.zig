const std = @import("std");

fn isAlphabetic(char: u8) bool {
    switch (char) {
        'a'...'z', 'A'...'Z' => return true,
        else => return false,
    }
}

pub fn isPangram(str: []const u8) bool {
    var alphabet: [26]bool = @splat(false);
    for (str) |char| {
        if (!isAlphabetic(char)) continue;

        const pos = std.ascii.toLower(char) - 'a';
        alphabet[pos] = true;
    }

    for (alphabet) |a| {
        if (!a) {
            return false;
        }
    }
    return true;
}
