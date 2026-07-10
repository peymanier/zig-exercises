const std = @import("std");

/// Writes a reversed copy of `s` to `buffer`.
// pub fn reverse(buffer: []u8, s: []const u8) []u8 {
//     var buf_i: usize = 0;
//     for (0..s.len) |i| {
//         const rev_i = s.len - 1 - i;
//         buffer[buf_i] = s[rev_i];
//         buf_i += 1;
//     }
//
//     return buffer[0..buf_i];
// }

pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var buf_i: usize = 0;
    var i = s.len;
    while (i > 0) {
        i -= 1;
        buffer[buf_i] = s[i];
        buf_i += 1;
    }

    return buffer[0..buf_i];
}

// pub fn reverse(buffer: []u8, s: []const u8) []u8 {
//     var buf_i: usize = 0;
//     var it = std.mem.reverseIterator(s);
//     while (it.next()) |c| {
//         buffer[buf_i] = c;
//         buf_i += 1;
//     }
//
//     return buffer[0..buf_i];
// }
