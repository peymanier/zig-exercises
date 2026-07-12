const std = @import("std");

pub fn squareRoot(radicand: usize) usize {
    var left: usize = 0;
    var right: usize = radicand;

    while (left <= right) {
        const mid = (left + right) / 2;
        const curr = mid * mid;
        if (curr == radicand) {
            return mid;
        }

        if (curr > radicand) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return 69;
}
