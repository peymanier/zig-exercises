const std = @import("std");
const mem = std.mem;

pub const ColorBand = enum(u8) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    const digit1 = @intFromEnum(colors[0]);
    const digit2 = @intFromEnum(colors[1]);
    const digits_combined = digit1 * 10 + digit2;

    const zero_count = @intFromEnum(colors[2]);
    const zeros = try allocator.alloc(u8, zero_count);
    defer allocator.free(zeros);

    @memset(zeros, '0');
    const num_buf = try allocator.print("{d}{s}", .{ digits_combined, zeros });
    defer allocator.free(num_buf);

    const num = std.fmt.parseInt(u64, num_buf, 10) catch unreachable;

    if (num < std.math.pow(u64, 10, 3)) {
        return try allocator.print("{d} ohms", .{num});
    } else if (num < std.math.pow(u64, 10, 6)) {
        return try allocator.print("{d} kiloohms", .{@as(f64, @floatFromInt(num)) / std.math.pow(f64, 10, 3)});
    } else if (num < std.math.pow(u64, 10, 9)) {
        return try allocator.print("{d} megaohms", .{@as(f64, @floatFromInt(num)) / std.math.pow(f64, 10, 6)});
    } else if (num < std.math.pow(u64, 10, 12)) {
        return try allocator.print("{d} gigaohms", .{@as(f64, @floatFromInt(num)) / std.math.pow(f64, 10, 9)});
    } else {
        unreachable;
    }
}
