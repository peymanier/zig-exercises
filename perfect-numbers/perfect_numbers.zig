const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    std.debug.assert(n > 0);
    const aliquot_sum = aliquotSum(n);
    if (aliquot_sum > n) return Classification.abundant;
    if (aliquot_sum < n) return Classification.deficient;
    return Classification.perfect;
}

fn aliquotSum(n: u64) u64 {
    var result: u64 = 0;
    for (1..n / 2 + 1) |i| {
        if (n % i == 0) result += i;
    }
    return result;
}
