const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // library module
    const lib = b.addStaticLibrary(.{
        .name = "algorithms",
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const lib_module = b.addModule("lib", .{
        .root_source_file = b.path("src/lib.zig"),
    });

    // executable
    const exe = b.addExecutable(.{
        .name = "algorithms",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("lib", lib_module);
    b.installArtifact(exe);

    // run step
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // test configuration
    const test_step = b.step("test", "Run all tests");

    // test file configurations
    const test_files = [_]struct {
        path: []const u8,
        step_name: []const u8,
        needs_lib: bool,
    }{
        .{ .path = "src/lib.zig", .step_name = "test-lib", .needs_lib = false },
        .{ .path = "src/main.zig", .step_name = "test-main", .needs_lib = true },
        .{ .path = "src/sorting/mod.zig", .step_name = "test-sorting", .needs_lib = false },
        .{ .path = "src/sorting/insertion_sort.zig", .step_name = "test-insertion", .needs_lib = false },
        .{ .path = "test/integration_tests.zig", .step_name = "test-integration", .needs_lib = true },
    };

    // create test artifacts for each file
    inline for (test_files) |test_file| {
        const t = b.addTest(.{
            .root_source_file = b.path(test_file.path),
            .target = target,
            .optimize = optimize,
        });

        // add lib module import if needed
        if (test_file.needs_lib) {
            t.root_module.addImport("lib", lib_module);
        }

        const run_t = b.addRunArtifact(t);

        // add to main test step
        test_step.dependOn(&run_t.step);

        // individual test step
        const individual_test_step = b.step(test_file.step_name, "Run " ++ test_file.path ++ " tests");
        individual_test_step.dependOn(&run_t.step);
    }

    // documentation
    const docs = b.addStaticLibrary(.{
        .name = "algorithms",
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = .Debug,
    });

    const install_docs = b.addInstallDirectory(.{
        .source_dir = docs.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "docs",
    });

    const docs_step = b.step("docs", "Generate documentation");
    docs_step.dependOn(&install_docs.step);
}
