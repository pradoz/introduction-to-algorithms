const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // library module
    const lib = b.addStaticLibrary(.{
        .name = "introduction_to_algorithms",
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
        .name = "introduction_to_algorithms",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // link library module to executable
    exe.root_module.addImport("lib", lib_module);

    b.installArtifact(exe);

    // run step
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    // allow argument passing
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // unit tests
    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe_unit_tests.root_module.addImport("lib", lib_module);
    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // integration tests
    const integration_tests = b.addTest(.{
        .root_source_file = b.path("test/integration_tests.zig"),
        .target = target,
        .optimize = optimize,
    });
    integration_tests.root_module.addImport("lib", lib_module);
    const run_integration_tests = b.addRunArtifact(integration_tests);

    // sorting module tests
    const sorting_tests = b.addTest(.{
        .root_source_file = b.path("src/sorting/mod.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_sorting_tests = b.addRunArtifact(sorting_tests);
    const test_sorting_step = b.step("test-sorting", "Run sorting tests");
    test_sorting_step.dependOn(&run_sorting_tests.step);

    // Insertion sort specific
    const insertion_sort_tests = b.addTest(.{
        .root_source_file = b.path("src/sorting/insertion_sort.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_insertion_sort_tests = b.addRunArtifact(insertion_sort_tests);
    const test_insertion_step = b.step("test-insertion", "Run insertion sort tests");
    test_insertion_step.dependOn(&run_insertion_sort_tests.step);

    // main test steps
    const test_step = b.step("test", "Run all tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
    test_step.dependOn(&run_integration_tests.step);
    test_step.dependOn(&run_sorting_tests.step);

    // documentation
    const docs = b.addStaticLibrary(.{
        .name = "introduction_to_algorithms",
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
