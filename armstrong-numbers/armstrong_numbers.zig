const std = @import("std");

// pub fn isArmstrongNumber(num: u128) bool {
//     var buf: [40]u8 = undefined;
//     const numstr = std.mem.print(&buf, "{d}", .{num}) catch unreachable;
//     var acc: u128 = 0;
//     for (numstr) |digitstr| {
//         const digit = std.fmt.charToDigit(digitstr, 10) catch unreachable;
//         acc += std.math.pow(u128, digit, numstr.len);
//     }
//
//     return acc == num;
// }

pub fn isArmstrongNumber(num: u128) bool {
    var gpa = std.heap.SafeAllocator.init(std.heap.page_allocator, .{});
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var numbers = std.ArrayList(u128).empty;
    defer numbers.deinit(allocator);

    var n = num;
    while (n > 0) : (n /= 10) {
        const digit = n % 10;
        numbers.append(allocator, digit) catch unreachable;
    }

    var acc: u128 = 0;
    for (numbers.items) |digit| {
        acc += std.math.pow(u128, digit, numbers.items.len);
    }

    return acc == num;
}
