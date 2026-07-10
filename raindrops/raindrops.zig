const std = @import("std");

fn writeBuf(buffer: []u8, i: *usize, str: []const u8) void {
    @memcpy(buffer[i.* .. i.* + str.len], str);
    i.* += str.len;
}

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var i: usize = 0;
    if (n % 3 == 0) {
        writeBuf(buffer, &i, "Pling");
    }
    if (n % 5 == 0) {
        writeBuf(buffer, &i, "Plang");
    }
    if (n % 7 == 0) {
        writeBuf(buffer, &i, "Plong");
    }
    if (i == 0) {
        const s = std.mem.print(buffer, "{d}", .{n}) catch unreachable;
        i = s.len;
    }

    return buffer[0..i];
}
