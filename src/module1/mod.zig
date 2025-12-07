const std = @import("std");
const submodule = @import("submodule.zig");

/// Compute something
pub fn compute(x: i32) i32 {
    return x * 2 + submodule.helper(x);
}

/// Module-specific function
pub fn process(data: []const u8) !void {
    std.debug.print("Processing: {s}\n", .{data});
}

test "compute" {
    const result = compute(10);
    try std.testing.expectEqual(@as(i32, 40), result);
}

test "submodule" {
    _ = submodule;
}
