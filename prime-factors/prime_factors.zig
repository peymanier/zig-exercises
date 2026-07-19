const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var result = std.ArrayList(u64).empty;
    defer result.deinit(allocator);

    var val = value;
    var i: usize = 2;
    while (val > 0 and i <= val) {
        if (val % i != 0) {
            i += 1;
            continue;
        }

        val /= i;
        try result.append(allocator, i);
    }

    return result.toOwnedSlice(allocator);
}
