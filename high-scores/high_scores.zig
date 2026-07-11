const std = @import("std");

pub const HighScores = struct {
    scores: []const i32,
    top: []const i32,

    pub fn init(scores: []const i32) HighScores {
        const allocator = std.testing.allocator;
        const sorted = allocator.dupe(i32, scores) catch unreachable;
        defer allocator.free(sorted);

        var top: [3]i32 = undefined;
        const n = @min(3, sorted.len);
        std.mem.sort(i32, sorted, {}, std.sort.desc(i32));
        @memcpy(top[0..n], sorted[0..n]);
        return HighScores{ .scores = scores, .top = top[0..n] };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        return self.scores[self.scores.len - 1];
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        if (self.scores.len == 0) return null;
        var max = self.scores[0];
        for (self.scores[1..]) |score| {
            if (score > max) max = score;
        }
        return max;
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        return self.top;
    }
};
