const std = @import("std");
const helpers = @import("helpers.zig");

pub const Helpers = helpers;

/// Utility function
pub fn formatString(allocator: std.mem.Allocator, comptime fmt: []const u8, args: anytype) ![]u8 {
    return try std.fmt.allocPrint(allocator, fmt, args);
}

test "formatString" {
    const allocator = std.testing.allocator;
    const result = try formatString(allocator, "Value: {d}", .{42});
    defer allocator.free(result);

    try std.testing.expectEqualStrings("Value: 42", result);
}

test "helpers" {
    _ = helpers;
}
