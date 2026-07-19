const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    wink,
    double_blink,
    close_your_eyes,
    jump,
};

// An enum `Signal`, needs to be implemented.
pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var result = std.ArrayList(Signal).empty;
    errdefer result.deinit(allocator);

    if (number & 1 == 1) {
        try result.append(allocator, Signal.wink);
    }
    if (number >> 1 & 1 == 1) {
        try result.append(allocator, Signal.double_blink);
    }
    if (number >> 2 & 1 == 1) {
        try result.append(allocator, Signal.close_your_eyes);
    }
    if (number >> 3 & 1 == 1) {
        try result.append(allocator, Signal.jump);
    }

    if (number >> 4 & 1 == 1) {
        std.mem.reverse(Signal, result.items);
    }

    return result.toOwnedSlice(allocator);
}
