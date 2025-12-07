const std = @import("std");

pub fn helper(x: i32) i32 {
    return x + 10;
}

test "helper" {
    try std.testing.expectEqual(@as(i32, 15), helper(5));
}
