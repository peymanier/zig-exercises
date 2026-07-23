const std = @import("std");
const mem = std.mem;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result = std.ArrayList(u8).empty;
    defer result.deinit(allocator);

    const group_size = 5;
    var group_count: usize = 0;
    for (s) |c| {
        if (std.ascii.isWhitespace(c) or std.ascii.isPunctuation(c)) {
            continue;
        }

        if (group_count == group_size) {
            try result.append(allocator, ' ');
            group_count = 0;
        }

        if (!std.ascii.isAlphabetic(c)) {
            try result.append(allocator, c);
            group_count += 1;
            continue;
        }

        const char = std.ascii.toLower(c);
        const a_dist = @abs(char - 'a');
        const z_dist = @abs('z' - char);
        if (a_dist <= z_dist) {
            try result.append(allocator, 'z' - a_dist);
        } else {
            try result.append(allocator, 'a' + z_dist);
        }
        group_count += 1;
    }

    return try result.toOwnedSlice(allocator);
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var result = std.ArrayList(u8).empty;
    defer result.deinit(allocator);

    for (s) |c| {
        if (std.ascii.isWhitespace(c)) {
            continue;
        }
        if (!std.ascii.isAlphabetic(c)) {
            try result.append(allocator, c);
            continue;
        }

        const a_dist = @abs(c - 'a');
        const z_dist = @abs('z' - c);
        if (a_dist <= z_dist) {
            try result.append(allocator, 'z' - a_dist);
        } else {
            try result.append(allocator, 'a' + z_dist);
        }
    }

    return try result.toOwnedSlice(allocator);
}
