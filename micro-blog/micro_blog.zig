const std = @import("std");

pub fn truncate(phrase: []const u8) []const u8 {
    const view = std.unicode.Utf8View.init(phrase) catch unreachable;
    var it = view.iterator();

    var i: usize = 0;
    var count: usize = 0;
    while (it.nextCodepointSlice()) |char| {
        i += char.len;
        count += 1;
        if (count == 5) break;
    }

    return phrase[0..i];
}
