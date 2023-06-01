const std = @import("std");

inline fn readFloat32Little(ptr: *[4]u8) f32 {
    return @bitCast(f32, std.mem.readIntLittle(u32, ptr));
}

// Used to read and write to js.
// We have two buffers since it's common to write output while we are reading input from js.
pub const WasmJsBuffer = struct {
    alloc: std.mem.Allocator,
    /// Used to write data to js.
    output_buf: std.ArrayListUnmanaged(u8),
    /// Used to read data from js.
    input_buf: std.ArrayListUnmanaged(u8),

    pub fn init(alloc: std.mem.Allocator) WasmJsBuffer {
        var new = WasmJsBuffer{
            .alloc = alloc,
            .output_buf = .{},
            .input_buf = .{},
        };
        return new;
    }

    pub fn deinit(self: *WasmJsBuffer) void {
        self.output_buf.deinit(self.alloc);
        self.input_buf.deinit(self.alloc);
    }

    pub fn ensureNotEmpty(self: *WasmJsBuffer) void {
        // Ensure buffers have capacity since we will be returning pointers to js.
        self.output_buf.resize(self.alloc, 1) catch unreachable;
        self.input_buf.resize(self.alloc, 1) catch unreachable;
    }

    pub fn getOutputWriter(self: *WasmJsBuffer) std.ArrayListUnmanaged(u8).Writer {
        return self.output_buf.writer(self.alloc);
    }

    // After wasm execution, write the new input buffer ptr/cap and return the output buffer ptr.
    pub fn writeResult(self: *WasmJsBuffer) [*]const u8 {
        const writer = self.output_buf.writer(self.alloc);
        self.output_buf.shrinkRetainingCapacity(0);
        writer.writeIntLittle(u32, @intCast(u32, @ptrToInt(self.input_buf.items.ptr))) catch unreachable;
        writer.writeIntLittle(u32, @intCast(u32, self.input_buf.capacity)) catch unreachable;
        return self.output_buf.items.ptr;
    }

    pub fn appendInt(self: *WasmJsBuffer, comptime T: type, i: T) void {
        const writer = self.output_buf.writer(self.alloc);
        writer.writeIntLittle(T, i) catch unreachable;
    }

    pub fn writeIntAt(self: *WasmJsBuffer, comptime T: type, idx: usize, i: T) void {
        std.mem.writeIntLittle(T, @ptrCast(*[@sizeOf(T)]u8, &self.output_buf[idx]), i);
    }

    pub fn appendF32(self: *WasmJsBuffer, f: f32) void {
        const writer = self.output_buf.writer(self.alloc);
        writer.writeIntLittle(u32, @bitCast(u32, f)) catch unreachable;
    }

    pub fn writeF32At(self: *WasmJsBuffer, idx: usize, f: f32) void {
        std.mem.writeIntLittle(u32, @ptrCast(*[4]u8, &self.output_buf[idx]), @bitCast(u32, f));
    }

    pub fn readIntAt(self: *WasmJsBuffer, comptime T: type, idx: usize) T {
        return std.mem.readInt(T, @ptrCast(*[@sizeOf(T)]u8, &self.input_buf.items[idx]));
    }

    pub fn readF32At(self: *WasmJsBuffer, idx: usize) f32 {
        return readFloat32Little(@ptrCast(*[4]u8, &self.input_buf.items[idx]));
    }

    pub fn clearOutputWithSize(self: *WasmJsBuffer, size: usize) void {
        self.output_buf.clearRetainingCapacity();
        self.output_buf.resize(size, self.alloc) catch unreachable;
    }

    pub fn clearOutput(self: *WasmJsBuffer) void {
        self.output_buf.clearRetainingCapacity();
    }

    pub fn getOutputPtr(self: *WasmJsBuffer) [*]const u8 {
        return self.output_buf.items.ptr;
    }
};