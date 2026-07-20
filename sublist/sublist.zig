const std = @import("std");

pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (areEqualSlices(list_one, list_two)) return .equal;
    if (isSublist(list_one, list_two)) return .sublist;
    if (isSublist(list_two, list_one)) return .superlist;
    return .unequal;
}

fn areEqualSlices(one: []const i32, two: []const i32) bool {
    if (one.len != two.len) return false;

    for (0..one.len) |i| {
        if (one[i] != two[i]) return false;
    }

    return true;
}

fn isSublist(small: []const i32, big: []const i32) bool {
    if (small.len == 0) return true;
    if (small.len > big.len) return false;

    for (0..big.len) |b| {
        if (big[b] == small[0] and startswith(big[b + 1 ..], small[1..])) return true;
    }

    return false;
}

fn startswith(big: []const i32, small: []const i32) bool {
    if (small.len == 0) return true;
    if (small.len > big.len) return false;

    for (0..small.len) |i| {
        if (big[i] != small[i]) return false;
    }

    return true;
}
