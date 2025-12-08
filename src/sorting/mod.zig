const std = @import("std");

pub const insertion_sort = @import("insertion_sort.zig");
pub const merge_sort = @import("merge_sort.zig");
// TODO: add more sorting algorithms
// pub const quick_sort = @import("quick_sort.zig");
// pub const heap_sort = @import("heap_sort.zig");

// exported interface
pub const insertionSort = insertion_sort.sort;
pub const insertionSortDescending = insertion_sort.sortDescending;
pub const mergeSort = merge_sort.sort;
pub const mergeSortDescending = merge_sort.sortDescending;

test "sorting module" {
    _ = insertion_sort;
    _ = merge_sort;
}

const allocator = std.testing.allocator;
const original = [_]i32{ 5, -22, 48, 1, 11, 111, 9, -1, 72, 42, 32, 0 };

fn verifyAscending(arr: []const i32) !void {
    for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
        try std.testing.expect(a <= b);
    }
}

fn verifyDescending(arr: []const i32) !void {
    for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
        try std.testing.expect(a >= b);
    }
}

test "insertion sort: bidirectional" {
    const asc = try allocator.dupe(i32, &original);
    const desc = try allocator.dupe(i32, &original);
    defer allocator.free(asc);
    defer allocator.free(desc);

    insertionSort(asc);
    try verifyAscending(asc);

    insertionSortDescending(desc);
    try verifyDescending(desc);

    std.mem.reverse(i32, asc);
    try std.testing.expectEqualSlices(i32, desc, asc);
}

test "merge sort: bidirectional" {
    const asc = try allocator.dupe(i32, &original);
    const desc = try allocator.dupe(i32, &original);
    defer allocator.free(asc);
    defer allocator.free(desc);

    try mergeSort(asc, allocator);
    try verifyAscending(asc);

    try mergeSortDescending(desc, allocator);
    try verifyDescending(desc);

    std.mem.reverse(i32, asc);
    try std.testing.expectEqualSlices(i32, desc, asc);
}
