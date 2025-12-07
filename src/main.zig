const std = @import("std");
const lib = @import("lib");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("=== Sorting Algorithms in Zig ===\n\n", .{});

    try stdout.print("Insertion Sort\n", .{});
    try stdout.print("-" ** 40 ++ "\n", .{});

    var arr = [_]i32{ 5, 2, 4, 6, 1, 3 };

    try stdout.print("Original array: ", .{});
    for (arr) |val| {
        try stdout.print("{d} ", .{val});
    }
    try stdout.print("\n", .{});

    lib.sorting.insertionSort(&arr);

    try stdout.print("Sorted array:   ", .{});
    for (arr) |val| {
        try stdout.print("{d} ", .{val});
    }
    try stdout.print("\n\n", .{});

    var arr2 = [_]i32{ 5, 2, 4, 6, 1, 3 };
    try stdout.print("Descending sort: ", .{});
    lib.sorting.sortDescending(&arr2);
    for (arr2) |val| {
        try stdout.print("{d} ", .{val});
    }
    try stdout.print("\n", .{});
}

test "main tests" {
    _ = @import("lib");
}
