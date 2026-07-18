const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    var result: [10]u8 = undefined;
    var count: usize = 0;
    var i: usize = phrase.len - 1;
    while (i >= 0) {
        const char = phrase[i];
        if (std.ascii.isDigit(char)) {
            count += 1;
            if (count == 11 and char != '1') return null;
            if (count == 10 and char == '0') return null;
            if (count == 10 and char == '1') return null;
            if (count == 7 and char == '0') return null;
            if (count == 7 and char == '1') return null;
            if (count <= 10) {
                result[10 - count] = char;
            }
        }
        if (i == 0) break;
        i -= 1;
    }

    if (count != 10 and count != 11) return null;
    return result;
}
