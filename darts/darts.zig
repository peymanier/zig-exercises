const std = @import("std");

pub const Coordinate = struct {
    x: f64,
    y: f64,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{ .x = x_coord, .y = y_coord };
    }
    pub fn score(self: Coordinate) usize {
        const distance = std.math.sqrt(std.math.pow(f64, self.x, 2) + std.math.pow(f64, self.y, 2));
        return if (distance <= 1) 10 else if (distance <= 5) 5 else if (distance <= 10) 1 else 0;
    }
};
