const std = @import("std");

const Num = struct {
    n: u32,
    is_marked: bool,
};

pub fn primes(buffer: []u32, comptime limit: u12) []u32 {
    var nums: [limit - 1]Num = undefined;
    var i: u32 = 0;
    while (i < nums.len) : (i += 1) {
        nums[i] = Num{ .n = i + 2, .is_marked = false };
    }

    var a: usize = 0;
    while (a < nums.len) : (a += 1) {
        const num = nums[a];
        if (num.is_marked) continue;

        var b = a + num.n;
        while (b < nums.len) : (b += num.n) {
            nums[b].is_marked = true;
        }
    }

    var k: usize = 0;
    for (nums) |num| {
        if (num.is_marked) continue;
        buffer[k] = num.n;
        k += 1;
    }

    return buffer[0..k];
}
