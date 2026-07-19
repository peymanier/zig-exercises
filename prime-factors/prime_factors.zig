const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var result = std.ArrayList(u64).empty;
    defer result.deinit(allocator);

    var n = value;
    while (n % 2 == 0) {
        n /= 2;
        try result.append(allocator, 2);
    }

    var factor: usize = 3;
    while (factor * factor <= n) {
        while (n % factor == 0) {
            try result.append(allocator, factor);
            n /= factor;
        }

        factor += 2;
    }

    if (n > 1) {
        try result.append(allocator, n);
    }

    return result.toOwnedSlice(allocator);
}
