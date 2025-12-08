const std = @import("std");

/// Merge Sort
/// Divide-and-conquer array into halves, recursively sort them, then merge
///
/// Time: O(n log n) all cases
/// Space: O(n) - requires auxilary array for merging
///
/// Pseudocode:
/// MERGE-SORT(A, p, r)
/// if p < r
///     q = floor[(p + r) / 2]
///     MERGE-SORT(A, p, q)
///     MERGE-SORT(A, q + 1, r)
///     MERGE(A, p, q, r)
///
/// MERGE(A, p, q, r)
/// n1 = q - p + 1
/// n2 = r - q
/// let L[1..n1 + 1] and R[1..n2 + 1] be new arrays
/// for i = 1 to n1
///     L[i] = A[p + i - 1]
/// for j = 1 to n2
///     Rji] = A[q + j]
///
/// L[n1 + 1] = infinity
/// R[n2 + 1] = infinity
///
/// i = 1
/// j = 1
///
/// for k = p to r
///     if L[i] ≤ R[j]
///         A[k] = L[i]
///         i = i + 1
///     else A[k] = R[j]
///         j = j + 1
pub fn sort(arr: []i32, allocator: std.mem.Allocator) !void {
    if (arr.len < 2) return;
    try mergeSort(arr, 0, arr.len - 1, allocator);
}

pub fn sortDescending(arr: []i32, allocator: std.mem.Allocator) !void {
    if (arr.len < 2) return;
    try mergeSortDescending(arr, 0, arr.len - 1, allocator);
}

fn merge(arr: []i32, p: usize, q: usize, r: usize, allocator: std.mem.Allocator) !void {
    const n1 = q - p + 1;
    const n2 = r - q;

    var left = try allocator.alloc(i32, n1 + 1);
    defer allocator.free(left);

    var right = try allocator.alloc(i32, n2 + 1);
    defer allocator.free(right);

    for (0..n1) |i| {
        left[i] = arr[p + i];
    }
    for (0..n2) |j| {
        right[j] = arr[q + j + 1];
    }

    left[n1] = std.math.maxInt(i32);
    right[n2] = std.math.maxInt(i32);

    var i: usize = 0;
    var j: usize = 0;

    for (p..r + 1) |k| {
        if (left[i] <= right[j]) {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
    }
}

fn mergeDescending(arr: []i32, p: usize, q: usize, r: usize, allocator: std.mem.Allocator) !void {
    const n1 = q - p + 1;
    const n2 = r - q;

    var left = try allocator.alloc(i32, n1 + 1);
    defer allocator.free(left);

    var right = try allocator.alloc(i32, n2 + 1);
    defer allocator.free(right);

    for (0..n1) |i| {
        left[i] = arr[p + i];
    }
    for (0..n2) |j| {
        right[j] = arr[q + j + 1];
    }

    left[n1] = std.math.minInt(i32);
    right[n2] = std.math.minInt(i32);

    var i: usize = 0;
    var j: usize = 0;

    for (p..r + 1) |k| {
        if (left[i] >= right[j]) {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
    }
}

/// Recursive helper function
fn mergeSort(arr: []i32, p: usize, r: usize, allocator: std.mem.Allocator) !void {
    if (p < r) {
        const q = (p + r) / 2;
        try mergeSort(arr, p, q, allocator);
        try mergeSort(arr, q + 1, r, allocator);
        try merge(arr, p, q, r, allocator);
    }
}

/// Recursive helper function
fn mergeSortDescending(arr: []i32, p: usize, r: usize, allocator: std.mem.Allocator) !void {
    if (p < r) {
        const q = (p + r) / 2;
        try mergeSortDescending(arr, p, q, allocator);
        try mergeSortDescending(arr, q + 1, r, allocator);
        try mergeDescending(arr, p, q, r, allocator);
    }
}

test "merge sort - empty array" {
    const allocator = std.testing.allocator;
    var arr: [0]i32 = .{};
    try sort(&arr, allocator);
    try std.testing.expectEqual(@as(usize, 0), arr.len);
}

test "merge sort - single element" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{5};
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{5}, &arr);
}

test "merge sort - two elements" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 5, 2 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 2, 5 }, &arr);
}

test "merge sort - already sorted" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 1, 2, 3, 4, 5 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 1, 2, 3, 4, 5 }, &arr);
}

test "merge sort - reverse sorted" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 5, 4, 3, 2, 1 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 1, 2, 3, 4, 5 }, &arr);
}

test "merge sort - random order" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 3, 1, 4, 1, 5, 9, 2, 6 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 1, 1, 2, 3, 4, 5, 6, 9 }, &arr);
}

test "merge sort - duplicates" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 3, 3, 1, 1, 2, 2 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 1, 1, 2, 2, 3, 3 }, &arr);
}

test "merge sort - negative numbers" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ -5, 2, -3, 0, 1 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ -5, -3, 0, 1, 2 }, &arr);
}

test "merge sort - large array" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 38, 27, 43, 3, 9, 82, 10 };
    try sort(&arr, allocator);
    try std.testing.expectEqualSlices(i32, &[_]i32{ 3, 9, 10, 27, 38, 43, 82 }, &arr);
}

test "merge sort - descending, two elements" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 2, 5 };
    try sortDescending(&arr, allocator);
    try std.testing.expectEqual(@as(usize, 2), arr.len);
    try std.testing.expectEqualSlices(i32, &[2]i32{ 5, 2 }, &arr);
}

test "merge sort - descending, random order" {
    const allocator = std.testing.allocator;
    var arr = [_]i32{ 3, 9, 0, 5, 1 };
    try sortDescending(&arr, allocator);
    try std.testing.expectEqual(@as(usize, 5), arr.len);
    try std.testing.expectEqualSlices(i32, &[5]i32{ 9, 5, 3, 1, 0 }, &arr);
}
