const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var combined = std.AutoHashMap(u32, void).init(allocator);
    defer combined.deinit();

    for (factors) |f| {
        var multiplier: u32 = 1;
        while (f * multiplier < limit) : (multiplier += 1) {
            try combined.put(f * multiplier, {});
        }
    }

    var result: u64 = 0;
    var it = combined.keyIterator();
    while (it.next()) |key| {
        result += key.*;
    }

    return result;
}
