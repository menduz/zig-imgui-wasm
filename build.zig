const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    // const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const path = comptime thisDir();

    const imguiLib = b.addStaticLibrary(.{
        .name = "imgui",
        .target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
            .cpu_features_add = std.Target.Cpu.Feature.Set.empty,
            .abi = .musl,
        },
        .optimize = optimize,
    });

    {
        imguiLib.addIncludePath(comptime thisDir() ++ "/libs/stb");
        imguiLib.addIncludePath(comptime thisDir() ++ "/libs");

        // imguiLib.linkLibC();
        imguiLib.linkLibCpp();
        imguiLib.linkSystemLibrary("c++");

        // Generate flags.
        var flagContainer = std.ArrayList([]const u8).init(std.heap.page_allocator);
        if (optimize != std.builtin.OptimizeMode.Debug) flagContainer.append("-Os") catch unreachable;
        flagContainer.append("-Wno-return-type-c-linkage") catch unreachable;
        flagContainer.append("-fno-sanitize=undefined") catch unreachable;

        imguiLib.defineCMacro("IMGUI_USE_STB_SPRINTF", "1");
        // Include dirs
        imguiLib.addIncludePath(path ++ "/libs/cimgui/imgui");
        imguiLib.addIncludePath(path ++ "/libs/cimgui");

        // Add C
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/imgui/imgui.cpp", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/imgui/imgui_demo.cpp", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/imgui/imgui_draw.cpp", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/imgui/imgui_tables.cpp", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/imgui/imgui_widgets.cpp", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/cimgui/cimgui.cpp", flagContainer.items);

        imguiLib.addCSourceFile(path ++ "/libs/wasm-std/printf.c", flagContainer.items);
        imguiLib.addCSourceFile(path ++ "/libs/wasm-std/memchr.c", flagContainer.items);
    }

    const lib = b.addSharedLibrary(.{
        .name = "imgui-webgl",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/main.zig" },
        .target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
            .cpu_features_add = std.Target.Cpu.Feature.Set.empty,
            .abi = .musl,
        },
        .optimize = optimize,
    });

    if (lib.optimize == .ReleaseSmall or lib.optimize == .ReleaseFast) lib.strip = true;

    lib.step.dependOn(&imguiLib.step);

    lib.linkLibrary(imguiLib);

    // The following lines enable exporting all internal "extern" functions.
    lib.rdynamic = true;
    lib.dll_export_fns = true;

    // // On the contrary, if exposing only few functions is wanted. We must specify the list of functions manually
    // lib.export_symbol_names = &.{
    //     "render",
    //     "onInit",
    //     "getGlobalInput",
    //     "windowSizeChanged",
    //     "inputCallback",
    //     "mouseWheelCallback",
    //     "mouseCallback",
    //     "mousebuttonCallback",
    //     "cursorCallback",
    //     "charCallback",
    // };

    lib.dwarf_format = std.dwarf.Format.@"32";
    lib.import_symbols = true;

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(lib);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(lib);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    run_cmd.step.dependOn(b.getInstallStep());

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = .{ .cpu_arch = .wasm32, .os_tag = .freestanding },
        .optimize = optimize,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}

fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
