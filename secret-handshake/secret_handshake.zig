const std = @import("std");
const mem = std.mem;

const Bits = packed struct(u5) {
    wink: bool,
    double_blink: bool,
    close_your_eyes: bool,
    jump: bool,
    reverse: bool,
};

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

    const bits: Bits = @bitCast(number);

    if (bits.wink) try result.append(allocator, Signal.wink);
    if (bits.double_blink) try result.append(allocator, Signal.double_blink);
    if (bits.close_your_eyes) try result.append(allocator, Signal.close_your_eyes);
    if (bits.jump) try result.append(allocator, Signal.jump);
    if (bits.reverse) std.mem.reverse(Signal, result.items);

    return result.toOwnedSlice(allocator);
}
