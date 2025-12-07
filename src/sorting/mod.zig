const std = @import("std");

pub const insertion_sort = @import("insertion_sort.zig");
// TODO: add more sorting algorithms
// pub const merge_sort = @import("merge_sort.zig");
// pub const quick_sort = @import("quick_sort.zig");
// pub const heap_sort = @import("heap_sort.zig");

// exported interface
pub const insertionSort = insertion_sort.sort;
pub const insertionSortDescending = insertion_sort.sortDescending;

test "sorting module" {
    _ = insertion_sort;
}

test "integration: bidirectional sorting" {
    const allocator = std.testing.allocator;
    const original = [_]i32{ 5, 2, 8, 1, 9 };

    // insertion sort
    const asc = try allocator.dupe(i32, &original);
    defer allocator.free(asc);
    insertionSort(asc);

    const desc = try allocator.dupe(i32, &original);
    defer allocator.free(desc);
    insertionSortDescending(desc);

    std.mem.reverse(i32, asc);
    try std.testing.expectEqualSlices(i32, desc, asc);

    // TODO: add more sorting algorithms
}
