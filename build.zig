const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "Anitya",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);

    const step_run = b.step("run", "Run the executable");
    const run_exe = b.addRunArtifact(exe);

    if (b.args) |args| {
        run_exe.addArgs(args);
    }

    step_run.dependOn(&run_exe.step);
    run_exe.step.dependOn(b.getInstallStep());
}
