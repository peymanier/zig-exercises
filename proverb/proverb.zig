const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) mem.Allocator.Error![][]u8 {
    var result = std.ArrayList([]u8).empty;
    errdefer {
        for (result.items) |line| allocator.free(line);
        result.deinit(allocator);
    }

    if (words.len == 0) return result.toOwnedSlice(allocator);

    for (0..words.len - 1) |i| {
        const curr = words[i];
        const next = words[i + 1];

        const line = try allocator.print("For want of a {s} the {s} was lost.\n", .{ curr, next });
        result.append(allocator, line) catch |err| {
            allocator.free(line);
            return err;
        };
    }

    const closing = try allocator.print("And all for the want of a {s}.\n", .{words[0]});
    result.append(allocator, closing) catch |err| {
        allocator.free(closing);
        return err;
    };

    return result.toOwnedSlice(allocator);
}
