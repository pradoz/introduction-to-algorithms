const std = @import("std");

// insertion sort
//   sorts an array in-place in ascending order
//
// time: O(n^2) worst case, O(n) best case
// space: O(1)
pub fn sort(arr: []i32) void {
    // pseudocode:
    // for j = 2 to A.length
    //     key = A[j]
    //     // insert A[j] into the sorted sequence A[1..j-1]
    //     i = j - 1
    //     while i > 0 and A[i] > key
    //         A[i + 1] = A[i]
    //         i = i - 1
    //      A[i + 1] = key

    if (arr.len < 2) {
        return;
    }

    for (1..arr.len) |j| {
        const key: i32 = arr[j];
        var i: usize = j;

        while (i > 0 and arr[i - 1] > key) {
            arr[i] = arr[i - 1];
            i -= 1;
        }
        arr[i] = key;
    }
}

pub fn sortDescending(arr: []i32) void {
    if (arr.len < 2) {
        return;
    }

    for (1..arr.len) |j| {
        const key: i32 = arr[j];
        var i: usize = j;

        while (i > 0 and arr[i - 1] < key) {
            arr[i] = arr[i - 1];
            i -= 1;
        }
        arr[i] = key;
    }
}

test "insertion sort - empty array" {
    var arr: [0]i32 = .{};
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 0), arr.len);
}

test "insertion sort - single element" {
    var arr: [1]i32 = .{5};
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 1), arr.len);
    try std.testing.expectEqualSlices(i32, &[1]i32{5}, &arr);
}

test "insertion sort - two elements" {
    var arr = [2]i32{ 5, 2 };
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 2), arr.len);
    try std.testing.expectEqualSlices(i32, &[2]i32{ 2, 5 }, &arr);
}

test "insertion sort - already sorted" {
    var arr = [_]i32{ 1, 2, 3 };
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 3), arr.len);
    try std.testing.expectEqualSlices(i32, &[3]i32{ 1, 2, 3 }, &arr);
}

test "insertion sort - reverse sorted" {
    var arr = [_]i32{ 3, 2, 1 };
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 3), arr.len);
    try std.testing.expectEqualSlices(i32, &[3]i32{ 1, 2, 3 }, &arr);
}

test "insertion sort - random order" {
    var arr = [_]i32{ 3, 9, 0, 5, 1 };
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 5), arr.len);
    try std.testing.expectEqualSlices(i32, &[5]i32{ 0, 1, 3, 5, 9 }, &arr);
}

test "insertion sort - negative numbers" {
    var arr = [_]i32{ -5, 0, 1, -2, -99 };
    sort(&arr);
    try std.testing.expectEqual(@as(usize, 5), arr.len);
    try std.testing.expectEqualSlices(i32, &[5]i32{ -99, -5, -2, 0, 1 }, &arr);
}

test "insertion sort - descending, two elements" {
    var arr = [_]i32{ 2, 5 };
    sortDescending(&arr);
    try std.testing.expectEqual(@as(usize, 2), arr.len);
    try std.testing.expectEqualSlices(i32, &[2]i32{ 5, 2 }, &arr);
}

test "insertion sort - descending, random order" {
    var arr = [_]i32{ 3, 9, 0, 5, 1 };
    sortDescending(&arr);
    try std.testing.expectEqual(@as(usize, 5), arr.len);
    try std.testing.expectEqualSlices(i32, &[5]i32{ 9, 5, 3, 1, 0 }, &arr);
}
