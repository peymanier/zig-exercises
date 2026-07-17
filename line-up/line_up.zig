const std = @import("std");
const mem = std.mem;

pub fn format(allocator: mem.Allocator, name: []const u8, number: u10) ![]u8 {
    const suffix = getNumberSuffix(number);
    return try allocator.print("{s}, you are the {d}{s} customer we serve today. Thank you!", .{ name, number, suffix });
}

fn getNumberSuffix(num: u10) []const u8 {
    switch (num % 100) {
        11, 12, 13 => return "th",
        else => {},
    }

    return switch (num % 10) {
        1 => "st",
        2 => "nd",
        3 => "rd",
        else => "th",
    };
}
