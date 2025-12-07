const std = @import("std");

/// Introduction to Algorithms - Zig Implementation
pub const version = "0.1.0";

// re-export modules
pub const sorting = @import("sorting/mod.zig");
pub const utils = @import("utils/mod.zig");

// re-export for common operations
pub const insertionSort = sorting.insertionSort;

test "lib tests" {
    // run tests from imported modules
    _ = @import("sorting/mod.zig");
    _ = @import("utils/mod.zig");
}
