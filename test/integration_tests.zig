const std = @import("std");
const lib = @import("lib");

test "integration: module1 and module2" {
    const result = lib.module1.compute(10);
    const config = lib.module2.createConfig("test", result);

    try std.testing.expectEqual(result, config.value);
}

test "integration: utils with modules" {
    const allocator = std.testing.allocator;

    const value = lib.module1.compute(5);
    const formatted = try lib.utils.formatString(allocator, "Computed: {d}", .{value});
    defer allocator.free(formatted);

    try std.testing.expectEqualStrings("Computed: 25", formatted);
}
