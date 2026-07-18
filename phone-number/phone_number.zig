const std = @import("std");

pub fn clean(phrase: []const u8) ?[10]u8 {
    const country_code: usize = 11;
    const area_code: usize = 10;
    const exchange_code: usize = 7;

    var result: [10]u8 = undefined;
    var code: usize = 0;
    var i: usize = phrase.len - 1;
    while (i >= 0) {
        const char = phrase[i];
        if (std.ascii.isDigit(char)) {
            code += 1;
            if (code == country_code and char != '1') return null;
            if (code == area_code) {
                switch (char) {
                    '0', '1' => return null,
                    else => {},
                }
            }
            if (code == exchange_code) {
                switch (char) {
                    '0', '1' => return null,
                    else => {},
                }
            }
            if (code <= 10) {
                result[10 - code] = char;
            }
        }

        if (i == 0) break;
        i -= 1;
    }

    if (code != 10 and code != 11) return null;
    return result;
}
