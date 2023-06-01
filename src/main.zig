const std = @import("std");

const builtin = @import("builtin");
pub const allocator = @import("std").heap.wasm_allocator;

const input = @import("lib/gui/input.zig");
const idl = @import("lib/wasm/idl.zig");
const wasm = @import("lib/wasm/wasm-posix.zig");
const gl = @import("lib/wasm/webgl.zig");
const wb = @import("lib/wasm/wasm-js-buffer.zig");

const ImGuiImplementation = @import("imguiImplementation.zig");
const engine = @import("./modules/engine.zig");

/// A global buffer for wasm that can be used for:
/// Writing to js: In some cases in order to share the same abstraction as desktop code, a growing buffer is useful without needing an allocator. eg. logging.
/// Reading from js: If js needs to return dynamic data, it would need to write to memory which wasm knows about.
/// Using js_buffer_inner directly in std.mem.copy results in llvm error.
/// TODO: Check if new compiler fixes this and then rename js_buffer_inner to js_buffer.
var js_buffer_inner: wb.WasmJsBuffer = undefined;
pub var js_buffer: *wb.WasmJsBuffer = undefined;

/// Custom panic handler which prints given message using configured JS logger
/// To use this handler, add the following line to your **root** source file:
///
/// ```
/// pub const panic = @import("wasmapi").panic;
/// ```
pub fn panic(msg: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    idl.jsPanic(&msg[0], msg.len);
    unreachable;
}

var frame_id: c_uint = 0;

var trianglesProg: c_uint = 0;
var trianglesVao: c_uint = 0;

var quadProg: c_uint = 0;
var quadVao: c_uint = 0;
var quadBuf: c_uint = 0;

pub var global_input: input.FrameInput = .{};
pub export fn getGlobalInput() *anyopaque {
    return &global_input;
}

pub export fn onInit() [*]const u8 {
    wasm.init(allocator);

    js_buffer_inner = wb.WasmJsBuffer.init(allocator);
    js_buffer = &js_buffer_inner;
    js_buffer.ensureNotEmpty();

    gl.setWindowSize(1024, 768);

    wasm.log("running init");

    ImGuiImplementation.init("#version 300 es");

    var io = engine.imgui.igGetIO();
    io.*.IniFilename = null;
    io.*.ConfigFlags |= engine.imgui.ImGuiConfigFlags_DockingEnable;

    input.initImguiKeyMapping();

    return "hola!";
}

var last_input: input.FrameInput = .{};

pub export fn beginFrame(inputData: *const input.FrameInput) void {
    // update input
    var io = engine.imgui.igGetIO();

    last_input = inputData.*;

    io.*.DeltaTime = last_input.delta_time;

    engine.imgui.igNewFrame();
}

pub export fn endFrame() void {
    engine.imgui.igRender();
    var dd = engine.imgui.igGetDrawData();
    ImGuiImplementation.RenderDrawData(dd);
}

// Callbacks
pub export fn windowSizeChanged(newWidth: f32, newHeight: f32, aspectRatio: f32) void {
    gl.glViewport(0, 0, @floatToInt(engine.gl.GLsizei, newWidth), @floatToInt(engine.gl.GLsizei, newHeight));
    var io = engine.imgui.igGetIO();
    io.*.DisplayFramebufferScale = .{ .x = 1.0 / aspectRatio, .y = 1.0 / aspectRatio };
    io.*.DisplaySize = .{ .x = newWidth, .y = newHeight };
}

pub export fn inputCallback(key: c_int, scan: c_int, action: c_int, mods: c_int) void {
    _ = scan;

    var io = engine.imgui.igGetIO();
    var pressed = false;
    if (action == 1) {
        pressed = true;
    }

    // https://developer.mozilla.org/en-US/docs/Web/API/UI_Events/Keyboard_event_code_values
    io.*.KeysDown[@intCast(usize, key)] = pressed;
    io.*.KeyShift = (mods & 8) != 0;
    io.*.KeyAlt = (mods & 2) != 0;
    io.*.KeyCtrl = (mods & 4) != 0;
    io.*.KeySuper = (mods & 1) != 0;
}

pub export fn mouseWheelCallback(x: f32, y: f32) void {
    var io = engine.imgui.igGetIO();
    io.*.MouseWheel = y;
    io.*.MouseWheelH = x;
}

pub export fn mouseCallback(x: f32, y: f32) void {
    var io = engine.imgui.igGetIO();
    io.*.MousePos = .{ .x = x, .y = y };
}

pub export fn mousebuttonCallback(key: c_int, action: c_int) void {
    var io = engine.imgui.igGetIO();
    var pressed = false;
    if (action == 1) {
        pressed = true;
    }
    switch (key) {
        engine.imgui.ImGuiMouseButton_Left => {
            io.*.MouseDown[engine.imgui.ImGuiMouseButton_Left] = pressed;
        },
        engine.imgui.ImGuiMouseButton_Middle => {
            io.*.MouseDown[engine.imgui.ImGuiMouseButton_Middle] = pressed;
        },
        engine.imgui.ImGuiMouseButton_Right => {
            io.*.MouseDown[engine.imgui.ImGuiMouseButton_Right] = pressed;
        },
        else => {},
    }
}

pub export fn cursorCallback(x: f32, y: f32) void {
    var io = engine.imgui.igGetIO();
    io.*.MousePos = .{ .x = x, .y = y };
}

pub export fn charCallback(char: c_ushort) void {
    var io = engine.imgui.igGetIO();
    engine.imgui.ImGuiIO_AddInputCharacterUTF16(io, char);
}

pub export fn onDestroy() void {}
