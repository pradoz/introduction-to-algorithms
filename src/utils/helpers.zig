const std = @import("std");

pub fn clamp(value: i32, min: i32, max: i32) i32 {
    if (value < min) return min;
    if (value > max) return max;
    return value;
}

test "clamp" {
    try std.testing.expectEqual(@as(i32, 5), clamp(3, 5, 10));
    try std.testing.expectEqual(@as(i32, 10), clamp(15, 5, 10));
    try std.testing.expectEqual(@as(i32, 7), clamp(7, 5, 10));
}
