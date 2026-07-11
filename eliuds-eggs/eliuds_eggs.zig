// pub fn eggCount(number: usize) usize {
//     var count: usize = 0;
//     var n = number;
//     while (n > 0) {
//         count += (n % 2);
//         n >>= 1;
//     }
//
//     return count;
// }

pub fn eggCount(number: usize) usize {
    var count: usize = 0;
    var n = number;
    while (n > 0) {
        n &= (n - 1);
        count += 1;
    }

    return count;
}
