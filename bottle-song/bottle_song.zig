const std = @import("std");

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) ![]const u8 {
    const template: []const u8 =
        \\{s} green bottles hanging on the wall,
        \\{s} green bottles hanging on the wall,
        \\And if {s} green bottle should accidentally fall,
        \\There'll be {s} green bottle hanging on the wall.
    ;
    const args = getPoemArgs(start_bottles, take_down);
    return try std.fmt.bufPrint(buffer, template, args);
}

fn getPoemArgs(start_bottles: u32, take_down: u32) struct { []const u8, []const u8, []const u8, []const u8 } {
    var buf: [5]u8 = undefined;
    const start_string = titleCase(&buf, stringFromNumber(start_bottles));
    const take_down_string = stringFromNumber(take_down);
    const hanging_string = stringFromNumber(start_bottles - take_down);
    return .{ start_string, start_string, take_down_string, hanging_string };
}

fn titleCase(buf: []u8, word: []const u8) []const u8 {
    @memcpy(buf[0..word.len], word);
    buf[0] = std.ascii.toUpper(buf[0]);
    return buf[0..word.len];
}

fn stringFromNumber(number: u32) []const u8 {
    return switch (number) {
        1 => "one",
        2 => "two",
        3 => "three",
        4 => "four",
        5 => "five",
        6 => "six",
        7 => "seven",
        8 => "eight",
        9 => "nine",
        10 => "ten",
        else => unreachable,
    };
}
