const std = @import("std");
const mem = std.mem;

pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var result = std.ArrayList(u8).empty;
    errdefer result.deinit(allocator);

    for (text) |char| {
        try result.append(allocator, cipher(char, shiftKey));
    }

    return result.toOwnedSlice(allocator);
}

fn cipher(c: u8, shiftKey: u5) u8 {
    if (!std.ascii.isAlphabetic(c)) {
        return c;
    }

    if (std.ascii.isLower(c)) {
        return 'a' + ((c - 'a' + shiftKey) % 26);
    }

    return 'A' + ((c - 'A' + shiftKey) % 26);
}
