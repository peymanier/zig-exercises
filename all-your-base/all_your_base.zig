const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base < 2) return ConversionError.InvalidInputBase;
    if (output_base < 2) return ConversionError.InvalidOutputBase;

    var acc: u32 = 0;
    var i: u32 = 0;
    while (i < digits.len) : (i += 1) {
        const digit = digits[digits.len - 1 - i];
        if (digit >= input_base) return ConversionError.InvalidDigit;
        acc += digit * std.math.pow(u32, input_base, i);
    }

    var numbers = std.ArrayList(u32).empty;
    defer numbers.deinit(allocator);

    if (acc == 0) {
        try numbers.append(allocator, 0);
        return try numbers.toOwnedSlice(allocator);
    }

    while (acc > 0) {
        const n = acc % output_base;
        acc /= output_base;
        try numbers.append(allocator, n);
    }

    const result = try numbers.toOwnedSlice(allocator);
    std.mem.reverse(u32, result);
    return result;
}
