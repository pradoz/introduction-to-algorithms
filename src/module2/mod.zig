const std = @import("std");

pub const Config = struct {
    name: []const u8,
    value: i32,
};

pub fn createConfig(name: []const u8, value: i32) Config {
    return Config{
        .name = name,
        .value = value,
    };
}

test "createConfig" {
    const config = createConfig("test", 42);
    try std.testing.expectEqualStrings("test", config.name);
    try std.testing.expectEqual(@as(i32, 42), config.value);
}
