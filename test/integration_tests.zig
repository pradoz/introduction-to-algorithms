const std = @import("std");
const lib = @import("lib");

test "integration: insertion sort" {
    var arr = [_]i32{ 31, 41, 59, 26, 41, 58 };
    lib.sorting.insertionSort(&arr);

    // verify ascending
    for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
        try std.testing.expect(a <= b);
    }
}

test "integration: sorting with utils" {
    const allocator = std.testing.allocator;

    var arr = [_]i32{ 5, 2, 8, 1, 9 };
    lib.sorting.insertionSort(&arr);

    // format result
    const formatted = try lib.utils.formatString(allocator, "Sorted: [{d}, {d}, {d}, {d}, {d}]", .{ arr[0], arr[1], arr[2], arr[3], arr[4] });
    defer allocator.free(formatted);

    try std.testing.expectEqualStrings("Sorted: [1, 2, 5, 8, 9]", formatted);
}

test "integration: descending sort" {
    var arr = [_]i32{ 3, 7, 4, 1, 5 };
    lib.sorting.insertionSortDescending(&arr);

    // verify descending order
    for (arr[0 .. arr.len - 1], arr[1..]) |a, b| {
        try std.testing.expect(a >= b);
    }
}
