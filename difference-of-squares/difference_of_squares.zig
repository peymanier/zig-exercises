const std = @import("std");

pub fn squareOfSum(number: usize) usize {
    var acc: usize = 0;
    for (0..number + 1) |i| {
        acc += i;
    }

    return std.math.pow(usize, acc, 2);
}

pub fn sumOfSquares(number: usize) usize {
    var acc: usize = 0;
    for (0..number + 1) |i| {
        acc += std.math.pow(usize, i, 2);
    }

    return acc;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}
