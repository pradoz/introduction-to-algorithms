const std = @import("std");
const lib = @import("lib");

// TODO: add more to this file when we have integratable modules

const allocator = std.testing.allocator;

test "integration: ascending sort" {
    const original = [_]i32{ 31, 41, 59, 26, 41, 58 };

    const verifyAscending = struct {
        fn check(arr: []const i32) !void {
            for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
                try std.testing.expect(a <= b);
            }
        }
    }.check;

    // insertion sort
    var arr = original;
    lib.sorting.insertionSort(&arr);
    try verifyAscending(&arr);

    // merge sort
    arr = original;
    try lib.sorting.mergeSort(&arr, allocator);
    try verifyAscending(&arr);
}

test "integration: descending sort" {
    const original = [_]i32{ 3, 7, 4, 1, 5 };

    const verifyDescending = struct {
        fn check(arr: []const i32) !void {
            for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
                try std.testing.expect(a >= b);
            }
        }
    }.check;

    // insertion sort
    var arr = original;
    lib.sorting.insertionSortDescending(&arr);
    try verifyDescending(&arr);

    // merge sort
    arr = original;
    try lib.sorting.mergeSortDescending(&arr, allocator);
    try verifyDescending(&arr);
}
