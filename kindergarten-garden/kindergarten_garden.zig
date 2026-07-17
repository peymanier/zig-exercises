const std = @import("std");

pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

const students = [_][]const u8{ "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry" };

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    var it = std.mem.tokenizeScalar(u8, diagram, '\n');
    var result: [4]Plant = undefined;
    const student_pos = find_student(student).?;
    var i: usize = 0;
    while (it.next()) |entry| {
        result[i] = plantFromChar(entry[student_pos * 2]).?;
        i += 1;
        result[i] = plantFromChar(entry[student_pos * 2 + 1]).?;
        i += 1;
    }

    return result;
}

fn find_student(student: []const u8) ?usize {
    for (students, 0..) |name, i| {
        if (std.mem.eql(u8, student, name)) return i;
    }

    return null;
}

fn plantFromChar(c: u8) ?Plant {
    return switch (std.ascii.toLower(c)) {
        'c' => .clover,
        'g' => .grass,
        'r' => .radishes,
        'v' => .violets,
        else => null,
    };
}
