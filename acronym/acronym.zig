const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var it = mem.tokenizeAny(u8, words, " -_");
    var result = std.ArrayList(u8).empty;
    defer result.deinit(allocator);

    while (it.next()) |word| {
        try result.append(allocator, std.ascii.toUpper(word[0]));
    }

    return result.toOwnedSlice(allocator);
}
