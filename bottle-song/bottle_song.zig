const std = @import("std");

pub fn recite(buffer: []u8, start_count: u32, take_count: u32) ![]const u8 {
    if (take_count < 1) unreachable;

    var pos: usize = 0;
    var taken: u32 = 0;
    var take: u32 = 1;
    while (take <= take_count) : (take += 1) {
        if (taken > 0) {
            @memcpy(buffer[pos..][0..2], "\n\n");
            pos += 2;
        }

        const verse = try take_once(buffer[pos..], start_count - taken);
        pos += verse.len;

        taken += 1;
    }

    return buffer[0..pos];
}

fn take_once(buffer: []u8, start_count: u32) ![]const u8 {
    const template: []const u8 =
        \\{[start]s} green {[start_bottle]s} hanging on the wall,
        \\{[start]s} green {[start_bottle]s} hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be {[left]s} green {[left_bottle]s} hanging on the wall.
    ;
    const args = getPoemArgs(start_count);
    return try std.mem.print(buffer, template, args);
}

const PoemArgs = struct {
    start: []const u8,
    left: []const u8,
    start_bottle: []const u8,
    left_bottle: []const u8,
};

fn getPoemArgs(start_count: u32) PoemArgs {
    var buf: [5]u8 = undefined;
    const start_string = titleCase(&buf, stringFromNumber(start_count));
    const left_string = stringFromNumber(start_count - 1);
    return PoemArgs{
        .start = start_string,
        .left = left_string,
        .start_bottle = if (start_count == 1) "bottle" else "bottles",
        .left_bottle = if (start_count - 1 == 1) "bottle" else "bottles",
    };
}

fn titleCase(buf: []u8, word: []const u8) []const u8 {
    @memcpy(buf[0..word.len], word);
    buf[0] = std.ascii.toUpper(buf[0]);
    return buf[0..word.len];
}

fn stringFromNumber(number: u32) []const u8 {
    return switch (number) {
        0 => "no",
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
