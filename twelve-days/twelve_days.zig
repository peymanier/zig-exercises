const std = @import("std");

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var pos: usize = 0;

    var curr = start_verse;
    while (curr <= end_verse) : (curr += 1) {
        if (curr > start_verse) {
            const nl = try std.mem.print(buffer[pos..], "\n", .{});
            pos += nl.len;
        }

        const verse = try writeVerse(buffer[pos..], curr);
        pos += verse.len;
    }

    return buffer[0..pos];
}

fn writeVerse(buffer: []u8, num: u32) ![]const u8 {
    var items_buf: [320]u8 = undefined;

    const items = try writeItems(&items_buf, num);
    return try std.mem.print(
        buffer,
        "On the {[ordinal]s} day of Christmas my true love gave to me: {[items]s}",
        .{ .ordinal = getOrdinal(num), .items = items },
    );
}

fn writeItems(buffer: []u8, num: u32) ![]const u8 {
    if (num == 1) return "a Partridge in a Pear Tree.";

    var pos: usize = 0;
    var curr = num;

    while (curr >= 1) : (curr -= 1) {
        if (curr < num) {
            const sep = try std.mem.print(buffer[pos..], ", ", .{});
            pos += sep.len;
        }

        const item = try std.mem.print(buffer[pos..], "{s}", .{getItem(curr)});
        pos += item.len;

        if (curr == 1) break;
    }

    return buffer[0..pos];
}

fn getItem(num: u32) []const u8 {
    return switch (num) {
        1 => "and a Partridge in a Pear Tree.",
        2 => "two Turtle Doves",
        3 => "three French Hens",
        4 => "four Calling Birds",
        5 => "five Gold Rings",
        6 => "six Geese-a-Laying",
        7 => "seven Swans-a-Swimming",
        8 => "eight Maids-a-Milking",
        9 => "nine Ladies Dancing",
        10 => "ten Lords-a-Leaping",
        11 => "eleven Pipers Piping",
        12 => "twelve Drummers Drumming",
        else => unreachable,
    };
}

fn getOrdinal(num: u32) []const u8 {
    return switch (num) {
        1 => "first",
        2 => "second",
        3 => "third",
        4 => "fourth",
        5 => "fifth",
        6 => "sixth",
        7 => "seventh",
        8 => "eighth",
        9 => "ninth",
        10 => "tenth",
        11 => "eleventh",
        12 => "twelfth",
        else => unreachable,
    };
}
