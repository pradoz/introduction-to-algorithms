const std = @import("std");
const lib = @import("lib");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Welcome to my project!\n", .{});

    lib.greet("World");

    // Use modules
    const result = lib.module1.compute(42);
    try stdout.print("Result: {d}\n", .{result});
}

test "main tests" {
    _ = @import("lib");
}
