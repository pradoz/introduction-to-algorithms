const std = @import("std");

// re-export modules
pub const module1 = @import("module1/mod.zig");
pub const module2 = @import("module2/mod.zig");
pub const utils = @import("utils/mod.zig");

/// main library function
pub fn greet(name: []const u8) void {
    std.debug.print("Hello, {s}!\n", .{name});
}

test "lib tests" {
    // run tests from imported modules
    _ = @import("module1/mod.zig");
    _ = @import("module2/mod.zig");
    _ = @import("utils/mod.zig");
}

test "greet function" {
    greet("Zig");
}
