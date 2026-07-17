const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var acc: usize = 0;
    var i: usize = 0;
    var counter: usize = 0;
    while (i < s.len) : (i += 1) {
        const n = s[i];
        var num: u8 = undefined;
        switch (n) {
            '0'...'9' => {
                num = n - '0';
                counter += 1;
            },
            'X' => {
                if (i != s.len - 1) return false;
                num = 10;
                counter += 1;
            },
            '-' => continue,
            else => return false,
        }
        if (counter > 10) return false;
        acc += num * (11 - counter);
    }

    if (counter != 10) return false;
    return acc % 11 == 0;
}
