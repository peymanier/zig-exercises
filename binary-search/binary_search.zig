// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    if (items.len == 0) return null;

    var left: usize = 0;
    var right = items.len - 1;

    while (left <= right) {
        const mid = (left + right) / 2;
        const curr = items[mid];
        if (target == curr) return mid;

        if (target > curr) {
            left = mid + 1;
        } else {
            if (mid == 0) break;
            right = mid - 1;
        }
    }

    return null;
}
