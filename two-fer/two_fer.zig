const std = @import("std");

pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    const person_name = name orelse "you";
    return try std.mem.print(buffer, "One for {s}, one for me.", .{person_name});
}
