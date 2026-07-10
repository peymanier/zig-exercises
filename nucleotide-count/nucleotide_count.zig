const std = @import("std");
pub const NucleotideError = error{Invalid};

pub const Counts = struct {
    a: u32,
    c: u32,
    g: u32,
    t: u32,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var map = std.AutoHashMap(u8, u32).init(std.heap.smp_allocator);
    defer map.deinit();

    for (s) |char| {
        switch (char) {
            'A', 'C', 'G', 'T' => {
                const curr_count = map.get(char) orelse 0;
                map.put(char, curr_count + 1) catch unreachable;
            },
            else => return NucleotideError.Invalid,
        }
    }

    return Counts{
        .a = map.get('A') orelse 0,
        .c = map.get('C') orelse 0,
        .g = map.get('G') orelse 0,
        .t = map.get('T') orelse 0,
    };
}
