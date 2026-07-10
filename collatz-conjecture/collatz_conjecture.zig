// Please implement the `ComputationError.IllegalArgument` error.
pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) anyerror!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    var count: usize = 0;
    var n = number;
    while (true) {
        if (n < 1) @panic("should not happen");
        if (n == 1) return count;

        if (n % 2 == 0) n /= 2 else n = n * 3 + 1;
        count += 1;
    }
}
