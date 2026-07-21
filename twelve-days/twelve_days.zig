const std = @import("std");

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) ![]const u8 {
    var fba = std.heap.FixedBufferAllocator.init(buffer);
    const allocator = fba.allocator();

    var verses_store: std.ArrayList([]const u8) = .empty;
    defer verses_store.deinit(allocator);

    var curr = start_verse;
    while (curr <= end_verse) : (curr += 1) {
        const verse = try getVerse(allocator, curr);
        try verses_store.append(allocator, verse);
    }

    const verses = try verses_store.toOwnedSlice(allocator);
    const result = try std.mem.join(allocator, "", verses);
    return std.mem.print(buffer, "{s}", .{std.mem.trimEnd(u8, result, "\n")});
}

fn getVerse(allocator: std.mem.Allocator, num: u32) ![]const u8 {
    const day = getDay(num);
    const items = try getItems(allocator, num);
    return try allocator.print("On the {[day]s} day of Christmas my true love gave to me: {[items]s}\n", .{ .day = day, .items = items });
}

fn getDay(num: u32) []const u8 {
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

fn getItems(allocator: std.mem.Allocator, num: u32) ![]const u8 {
    if (num == 1) return "a Partridge in a Pear Tree.";

    var items = std.ArrayList([]const u8).empty;
    var curr = num;
    while (curr > 0) : (curr -= 1) {
        const item = getItem(curr);
        try items.append(allocator, item);
    }

    return try std.mem.join(allocator, ", ", try items.toOwnedSlice(allocator));
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
