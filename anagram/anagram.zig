const std = @import("std");
const mem = std.mem;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var word_hash_map = std.AutoHashMap(u8, u16).init(allocator);
    defer word_hash_map.deinit();

    for (word) |char| {
        const c = std.ascii.toLower(char);
        const curr = word_hash_map.get(c) orelse 0;
        try word_hash_map.put(c, 1 + curr);
    }

    var bufset = std.BufSet.init(allocator);
    errdefer bufset.deinit();

    for (candidates) |candidate| {
        if (std.ascii.eqlIgnoreCase(word, candidate)) continue;

        var candidate_hash_map = std.AutoHashMap(u8, u16).init(allocator);
        defer candidate_hash_map.deinit();

        for (candidate) |char| {
            const c = std.ascii.toLower(char);
            const curr = candidate_hash_map.get(c) orelse 0;
            try candidate_hash_map.put(c, 1 + curr);
        }

        if (hashMapsEqual(&word_hash_map, &candidate_hash_map)) {
            try bufset.insert(candidate);
        }
    }

    return bufset;
}

fn hashMapsEqual(a: *const std.AutoHashMap(u8, u16), b: *const std.AutoHashMap(u8, u16)) bool {
    if (a.count() != b.count()) return false;

    var it = a.iterator();
    while (it.next()) |entry| {
        const key = entry.key_ptr.*;
        if (a.get(key) != b.get(key)) return false;
    }

    return true;
}
