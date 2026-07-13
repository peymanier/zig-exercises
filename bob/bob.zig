const std = @import("std");

pub fn response(s: []const u8) []const u8 {
    if (areAllWhitespace(s)) return "Fine. Be that way!";

    if (hasNoAlphabetic(s)) {
        if (hasQuestionMark(s)) return "Sure.";
        return "Whatever.";
    }

    if (areAllUpper(s)) {
        if (hasQuestionMark(s)) return "Calm down, I know what I'm doing!";
        return "Whoa, chill out!";
    }

    if (hasQuestionMark(s)) return "Sure.";

    return "Whatever.";
}

fn areAllUpper(s: []const u8) bool {
    for (s) |char| {
        if (std.ascii.isLower(char)) return false;
    }

    return true;
}

fn hasQuestionMark(s: []const u8) bool {
    if (s.len == 0) return false;

    for (0..s.len) |i| {
        const revi = s.len - 1 - i;
        if (isWhitespaceChar(s[revi])) {
            continue;
        }

        return s[revi] == '?';
    }

    return false;
}

fn areAllWhitespace(s: []const u8) bool {
    for (s) |char| {
        if (!isWhitespaceChar(char)) return false;
    }

    return true;
}

fn isWhitespaceChar(char: u8) bool {
    const whitespace_chars = [_]u8{ ' ', '\t', '\n', '\r' };
    for (whitespace_chars) |wc| {
        if (char == wc) return true;
    }

    return false;
}

fn hasNoAlphabetic(s: []const u8) bool {
    for (s) |char| {
        if (std.ascii.isAlphabetic(char)) return false;
    }

    return true;
}
