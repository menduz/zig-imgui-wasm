const std = @import("std");
const idl = @import("idl.zig");
const usize_len = @sizeOf(usize);

pub var galloc: std.mem.Allocator = undefined;
var atexits: std.ArrayList(AtExitCallback) = undefined;

const AtExitCallback = struct {
    func: *const fn (ctx: ?*anyopaque) void,
    ctx: ?*anyopaque,
};

pub fn init(alloc: std.mem.Allocator) void {
    galloc = alloc;
    atexits = std.ArrayList(AtExitCallback).init(alloc);
}

pub fn log(text: []const u8) void {
    idl.jsLog(&text[0], text.len);
}

comptime {
    // Conditionally export, or desktop builds will have the wrong malloc.
    @export(c_malloc, .{ .name = "malloc", .linkage = .Strong });
    @export(c_free, .{ .name = "free", .linkage = .Strong });
    @export(c_realloc, .{ .name = "realloc", .linkage = .Strong });
    @export(c_fabs, .{ .name = "fabs", .linkage = .Strong });
    @export(c_sqrt, .{ .name = "sqrt", .linkage = .Strong });
    @export(c_ldexp, .{ .name = "ldexp", .linkage = .Strong });
    @export(c_pow, .{ .name = "pow", .linkage = .Strong });
    @export(c_abs, .{ .name = "abs", .linkage = .Strong });
    // @export(c_memmove, .{ .name = "memmove", .linkage = .Strong });
    // @export(c_memset, .{ .name = "memset", .linkage = .Strong });
    // @export(c_memcpy, .{ .name = "memcpy", .linkage = .Strong });

    // @export(c_strlen, .{ .name = "strlen", .linkage = .Strong });
    @export(strcmp, .{ .name = "strcmp", .linkage = .Strong });
    @export(strncmp, .{ .name = "strncmp", .linkage = .Strong });
    @export(strerror, .{ .name = "strerror", .linkage = .Strong });
    @export(strlen, .{ .name = "strlen", .linkage = .Strong });
    @export(strcpy, .{ .name = "strcpy", .linkage = .Strong });
    @export(strncpy, .{ .name = "strncpy", .linkage = .Strong });
    @export(strcat, .{ .name = "strcat", .linkage = .Strong });
    @export(strncat, .{ .name = "strncat", .linkage = .Strong });

    @export(c_strchr, .{ .name = "strchr", .linkage = .Strong });
    @export(c_atof, .{ .name = "atof", .linkage = .Strong });
    @export(c_atoi, .{ .name = "atoi", .linkage = .Strong });
    @export(c_atoll, .{ .name = "atoll", .linkage = .Strong });
    @export(c_strtol, .{ .name = "strtol", .linkage = .Strong });
    @export(c_longjmp, .{ .name = "longjmp", .linkage = .Strong });
    @export(c_setjmp, .{ .name = "setjmp", .linkage = .Strong });
    @export(c_getenv, .{ .name = "getenv", .linkage = .Strong });
    @export(c_strstr, .{ .name = "strstr", .linkage = .Strong });
    @export(c_qsort, .{ .name = "qsort", .linkage = .Strong });
    @export(c_aligned_alloc, .{ .name = "aligned_alloc", .linkage = .Strong });
    @export(c_memcmp, .{ .name = "memcmp", .linkage = .Strong });
    @export(c_exit, .{ .name = "exit", .linkage = .Strong });
    @export(panic, .{ .name = "panic", .linkage = .Strong });
    @export(cxa_allocate_exception, .{ .name = "__cxa_allocate_exception", .linkage = .Strong });
    @export(cxa_pure_virtual, .{ .name = "__cxa_pure_virtual", .linkage = .Strong });
    @export(c_atexit, .{ .name = "atexit", .linkage = .Strong });
    @export(cxa_atexit, .{ .name = "__cxa_atexit", .linkage = .Strong });
    @export(cxa_throw, .{ .name = "__cxa_throw", .linkage = .Strong });
    @export(cxa_guard_acquire, .{ .name = "__cxa_guard_acquire", .linkage = .Strong });
    @export(cxa_guard_release, .{ .name = "__cxa_guard_release", .linkage = .Strong });
    @export(cpp_next_prime, .{ .name = "_ZNSt3__112__next_primeEm", .linkage = .Strong });
    @export(cpp_out_of_range, .{ .name = "_ZNSt12out_of_rangeD1Ev", .linkage = .Strong });
    @export(cpp_bad_array_new_length2, .{ .name = "_ZNSt20bad_array_new_lengthC1Ev", .linkage = .Strong });
    @export(cpp_bad_array_new_length, .{ .name = "_ZNSt20bad_array_new_lengthD1Ev", .linkage = .Strong });
    @export(cpp_basic_string_throw_length_error, .{ .name = "_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv", .linkage = .Strong });
    @export(cpp_vector_base_throw_length_error, .{ .name = "_ZNKSt3__120__vector_base_commonILb1EE20__throw_length_errorEv", .linkage = .Strong });
    @export(cpp_vector_base_throw_out_of_range_error, .{ .name = "_ZNKSt3__120__vector_base_commonILb1EE20__throw_out_of_rangeEv", .linkage = .Strong });
    @export(cpp_condvar_wait_unique_lock, .{ .name = "_ZN18condition_variable4waitER11unique_lockI5mutexE", .linkage = .Strong });
    @export(cpp_exception, .{ .name = "_ZNSt9exceptionD2Ev", .linkage = .Strong });
    @export(cpp_exception_what, .{ .name = "_ZNKSt9exception4whatEv", .linkage = .Strong });
    @export(cpp_system_category, .{ .name = "_ZNSt3__115system_categoryEv", .linkage = .Strong });
    @export(cpp_system_category_error, .{ .name = "_ZNSt3__112system_errorC1EiRKNS_14error_categoryE", .linkage = .Strong });
    @export(cpp_system_error, .{ .name = "_ZNSt3__112system_errorD1Ev", .linkage = .Strong });
    @export(cpp_operator_delete, .{ .name = "_ZdlPv", .linkage = .Strong });
    @export(cpp_operator_new, .{ .name = "_Znwm", .linkage = .Strong });
    @export(cpp_length_error, .{ .name = "_ZNSt12length_errorD1Ev", .linkage = .Strong });
    @export(cpp_logic_error, .{ .name = "_ZNSt11logic_errorC2EPKc", .linkage = .Strong });
    @export(cpp_operator_new_1, .{ .name = "_ZnwmSt11align_val_t", .linkage = .Strong });
    @export(cpp_operator_delete_1, .{ .name = "_ZdlPvSt11align_val_t", .linkage = .Strong });
    @export(cpp_vfprintf, .{ .name = "vfprintf", .linkage = .Strong });
    @export(fprintf, .{ .name = "fprintf", .linkage = .Strong });
    @export(cpp_fopen, .{ .name = "fopen", .linkage = .Strong });
    @export(cpp_fseek, .{ .name = "fseek", .linkage = .Strong });
    @export(cpp_ftell, .{ .name = "ftell", .linkage = .Strong });
    @export(cpp_fclose, .{ .name = "fclose", .linkage = .Strong });
    @export(cpp_fread, .{ .name = "fread", .linkage = .Strong });
    @export(cpp_strrchr, .{ .name = "strrchr", .linkage = .Strong });
    @export(cpp_fwrite, .{ .name = "fwrite", .linkage = .Strong });
}

fn cxa_guard_acquire(guard: *anyopaque) callconv(.C) i32 {
    // log.debug("guard_acquire", .{});
    _ = guard;
    return 1;
}

fn cxa_guard_release(guard: *anyopaque) callconv(.C) void {
    // log.debug("guard_release", .{});
    _ = guard;
}

fn c_aligned_alloc(alignment: usize, size: usize) callconv(.C) *anyopaque {
    if (alignment <= @sizeOf(*anyopaque)) {
        return c_malloc(size);
    } else {
        const ptr = c_malloc(size + alignment - @sizeOf(*anyopaque));
        const rem = @ptrToInt(ptr) % alignment;
        if (rem == 0) {
            return ptr;
        } else {
            return @intToPtr(*anyopaque, @ptrToInt(ptr) + alignment - rem);
        }
    }
}

/// Since this is often 16 for the new operator in C++, malloc should also mimic that.
const DefaultMallocAlignment = 16;

const PointerSize = @sizeOf(*anyopaque);
const BlocksPerAlignment = DefaultMallocAlignment / PointerSize;

fn c_malloc(size: usize) callconv(.C) *anyopaque {
    // Allocates blocks of PointerSize sized items that fits the header and the user memory using the default alignment.
    const blocks = (1 + (size + DefaultMallocAlignment - 1) / DefaultMallocAlignment) * BlocksPerAlignment;
    const buf = galloc.alignedAlloc(usize, DefaultMallocAlignment, blocks) catch @panic("c_malloc");
    // Header stores the length.
    buf[0] = blocks;
    // Return the user pointer.
    return &buf[BlocksPerAlignment];
}

fn c_realloc(ptr: ?*anyopaque, size: usize) callconv(.C) *anyopaque {
    if (ptr == null) {
        return c_malloc(size);
    }
    // Get current block size and slice.
    const addr = @ptrToInt(ptr.?) - DefaultMallocAlignment;
    const block = @intToPtr([*]usize, addr);
    const len = block[0];
    const slice: []usize = block[0..len];

    // Reallocate.
    const blocks = (1 + (size + DefaultMallocAlignment - 1) / DefaultMallocAlignment) * BlocksPerAlignment;
    const new_slice = galloc.reallocAdvanced(slice, DefaultMallocAlignment, blocks) catch @panic("c_realloc");
    new_slice[0] = blocks;
    return @ptrCast(*anyopaque, &new_slice[BlocksPerAlignment]);
}

fn cpp_operator_new(size: usize) callconv(.C) ?*anyopaque {
    return c_malloc(size);
}

fn c_free(ptr: ?*anyopaque) callconv(.C) void {
    if (ptr == null) {
        return;
    }
    const addr = @ptrToInt(ptr) - DefaultMallocAlignment;
    const block = @intToPtr([*]const usize, addr);
    const len = block[0];
    galloc.free(block[0..len]);
}

fn cpp_operator_delete(ptr: ?*anyopaque) callconv(.C) void {
    c_free(ptr);
}

fn c_fabs(x: f64) callconv(.C) f64 {
    return @fabs(x);
}

fn c_sqrt(x: f64) callconv(.C) f64 {
    return std.math.sqrt(x);
}

fn c_ldexp(x: f64, n: i32) callconv(.C) f64 {
    return std.math.ldexp(x, n);
}

fn c_pow(x: f64, y: f64) callconv(.C) f64 {
    return std.math.pow(f64, x, y);
}

fn c_abs(x: i32) callconv(.C) i32 {
    return std.math.absInt(x) catch unreachable;
}

// fn c_memset(s: [*]u8, val: u8, n: usize) callconv(.C) ?*anyopaque {
//     // Some user code may try to write to a bad location in wasm with n=0. Wasm doesn't allow that.
//     if (n > 0) {
//         // const slice = @ptrCast([*]u8, s)[0..n];
//         @memset(s[0..n], val);
//     }
//     return s;
// }

/// From lib/c.zig
fn c_memmove(dest: ?[*]u8, src: ?[*]const u8, n: usize) callconv(.C) ?[*]u8 {
    @setRuntimeSafety(false);
    if (@ptrToInt(dest) < @ptrToInt(src)) {
        var index: usize = 0;
        while (index != n) : (index += 1) {
            dest.?[index] = src.?[index];
        }
    } else {
        var index = n;
        while (index != 0) {
            index -= 1;
            dest.?[index] = src.?[index];
        }
    }
    return dest;
}

fn c_memcpy(dst: ?*anyopaque, src: ?*anyopaque, n: usize) callconv(.C) ?*anyopaque {
    const dst_slice = @ptrCast([*]u8, dst)[0..n];
    const src_slice = @ptrCast([*]u8, src)[0..n];
    std.mem.copy(u8, dst_slice, src_slice);
    return dst;
}

fn c_strstr(c_haystack: [*:0]const u8, c_needle: [*:0]const u8) callconv(.C) ?[*:0]const u8 {
    const haystack = std.mem.sliceTo(c_haystack, 0);
    const needle = std.mem.sliceTo(c_needle, 0);
    if (std.mem.indexOf(u8, haystack, needle)) |idx| {
        return @ptrCast([*:0]const u8, &c_haystack[idx]);
    } else return null;
}

fn c_strchr(s: [*:0]const u8, ch: u8) callconv(.C) ?[*:0]const u8 {
    if (std.mem.indexOfScalar(u8, std.mem.sliceTo(s, 0), ch)) |idx| {
        return @ptrCast([*:0]const u8, &s[idx]);
    } else return null;
}

fn c_atof(s: [*:0]const u8) callconv(.C) f64 {
    return std.fmt.parseFloat(f64, std.mem.sliceTo(s, 0)) catch return 0;
}

fn c_atoi(s: [*:0]const u8) callconv(.C) i32 {
    return std.fmt.parseInt(i32, std.mem.sliceTo(s, 0), 10) catch return 0;
}

fn c_atoll(s: [*:0]const u8) callconv(.C) i64 {
    return std.fmt.parseInt(i64, std.mem.sliceTo(s, 0), 10) catch return 0;
}

/// From lib/c.zig
fn c_memcmp(vl: ?[*]const u8, vr: ?[*]const u8, n: usize) callconv(.C) c_int {
    @setRuntimeSafety(false);
    var index: usize = 0;
    while (index != n) : (index += 1) {
        const compare_val = @bitCast(i8, vl.?[index] -% vr.?[index]);
        if (compare_val != 0) {
            return compare_val;
        }
    }
    return 0;
}

/// Allow C/C++ to trigger panic.
fn panic() callconv(.C) void {
    @panic("error");
}

// Handles next_prime for n [0, 210)
const low_next_primes = [_]u32{ 0, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211 };

/// C++ __next_prime
fn cpp_next_prime(n: usize) callconv(.C) usize {
    if (n < low_next_primes.len) {
        return low_next_primes[n];
    } else {
        @panic("next_prime");
    }
}

fn cpp_out_of_range(_: i32) callconv(.C) i32 {
    @panic("out of range");
}

fn cpp_bad_array_new_length2(_: i32) callconv(.C) i32 {
    @panic("bad array new length");
}

fn cpp_bad_array_new_length(_: i32) callconv(.C) i32 {
    @panic("bad array new length");
}

fn cpp_basic_string_throw_length_error(_: i32) callconv(.C) void {
    @panic("throw_length_error");
}

fn cpp_vector_base_throw_length_error(_: i32) callconv(.C) void {
    @panic("throw_length_error");
}

fn cpp_vector_base_throw_out_of_range_error(_: i32) callconv(.C) void {
    @panic("throw_out_of_range");
}

fn cpp_condvar_wait_unique_lock(_: i32, _: i32) callconv(.C) void {
    @panic("condvar wait");
}

fn cpp_exception(_: i32) callconv(.C) i32 {
    @panic("exception");
}

fn cpp_exception_what(_: i32) callconv(.C) i32 {
    @panic("exception what");
}

fn cpp_system_category() callconv(.C) i32 {
    @panic("system category");
}

fn cpp_system_category_error(_: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("system category error");
}

fn cpp_system_error() callconv(.C) i32 {
    @panic("system error");
}

fn cxa_pure_virtual() callconv(.C) void {
    @panic("cxa_pure_virtual");
}

fn cxa_atexit(func: ?*anyopaque, arg: ?*anyopaque, _: ?*anyopaque) callconv(.C) i32 {
    atexits.append(.{
        .func = @ptrCast(*const fn (?*anyopaque) void, func),
        .ctx = arg,
    }) catch @panic("cxa_atexit");
    return 0;
}

fn c_atexit(func: ?*anyopaque) callconv(.C) i32 {
    atexits.append(.{
        .func = @ptrCast(*const fn (?*anyopaque) void, func),
        .ctx = null,
    }) catch @panic("c_atexit");
    return 0;
}

fn cxa_allocate_exception(_: i32) callconv(.C) i32 {
    @panic("allocate_exception");
}

fn cpp_length_error(_: i32) callconv(.C) i32 {
    @panic("length_error");
}

fn cxa_throw(_: i32, _: i32, _: i32) callconv(.C) void {
    @panic("cxa_throw");
}

fn cpp_logic_error(_: i32, _: i32) callconv(.C) i32 {
    @panic("logic_error");
}

fn cpp_operator_new_1(_: i32, _: i32) callconv(.C) i32 {
    @panic("new_1");
}

fn cpp_operator_delete_1(_: i32, _: i32) callconv(.C) void {
    @panic("delete_1");
}

pub fn flushAtExits() void {
    while (atexits.popOrNull()) |atexit| {
        atexit.func(atexit.ctx);
    }
    atexits.clearRetainingCapacity();
}

fn c_exit(_: i32) callconv(.C) void {
    flushAtExits();
}

fn cpp_vfprintf(_: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("vfprintf");
}
fn fprintf(_: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("fprintf");
}

fn cpp_fopen(_: i32, _: i32) callconv(.C) i32 {
    @panic("fopen");
}

fn cpp_fseek(_: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("fseek");
}

fn cpp_ftell(_: i32) callconv(.C) i32 {
    @panic("ftell");
}

fn cpp_fclose(_: i32) callconv(.C) i32 {
    @panic("fclose");
}

fn cpp_fread(_: i32, _: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("fread");
}

fn c_qsort(base: [*]u8, nmemb: usize, size: usize, c_compare: *const fn (*anyopaque, *anyopaque) callconv(.C) i32) callconv(.C) void {
    const idxes = galloc.alloc(u32, nmemb) catch @panic("c_qsort");
    defer galloc.free(idxes);

    const Context = struct {
        buf: []u8,
        c_compare: *const fn (*anyopaque, *anyopaque) callconv(.C) i32,
        size: usize,
    };

    const S = struct {
        fn lessThan(ctx: Context, lhs: u32, rhs: u32) bool {
            return ctx.c_compare(&ctx.buf[lhs * ctx.size], &ctx.buf[rhs * ctx.size]) < 0;
        }
    };
    const ctx = Context{
        .size = size,
        .c_compare = c_compare,
        .buf = base[0 .. nmemb * size],
    };
    for (idxes, 0..) |_, i| {
        idxes[i] = i;
    }
    std.sort.sort(u32, idxes, ctx, S.lessThan);

    // Copy to temporary buffer.
    const temp = galloc.alloc(u8, nmemb * size) catch @panic("c_qsort");
    defer galloc.free(temp);
    for (idxes, 0..) |idx, i| {
        std.mem.copy(u8, temp[i * size .. i * size + size], ctx.buf[idx * size .. idx * size + size]);
    }
    std.mem.copy(u8, ctx.buf, temp);
}

fn cpp_strrchr(_: i32, _: i32) callconv(.C) i32 {
    @panic("strrchr");
}

/// From lib/c.zig
fn c_getenv(name: [*:0]const u8) callconv(.C) ?[*:0]const u8 {
    _ = name;
    return null;
}

// these are part of the c standard library. I shouldn't have to reimplement these and I'm
// not sure why I do. it might be a zig bug.

// returns 0 on eql, -1/1 on lt/gt. this code does not do that.
export fn strncasecmp(s1: [*:0]const u8, s2: [*:0]const u8, n: usize) c_int {
    const is_eql = std.ascii.eqlIgnoreCase(s1[0..n], s2[0..n]);
    // debugprint("strncasecomp on `{s}` == `{s}` → {}", .{ s1[0..n], s2[0..n], is_eql });
    return if (is_eql) return 0 else return 100;
}
export fn tolower(arg: c_int) c_int {
    return std.ascii.toLower(@bitCast(u8, @intCast(i8, arg)));
}

export fn c_strtol(str: [*:0]const u8, eptr: ?*[*:0]const u8, basev: c_int) c_long {
    const base = @bitCast(u8, @intCast(i8, basev));
    var res: c_long = 0;
    var cur = str;
    if (base == 0) @panic("unsupported");
    if (cur[0] == '+' or cur[0] == '-') @panic("unsupported");

    while (@as(?u8, std.fmt.charToDigit(cur[0], base) catch null)) |num| : (cur += 1) {
        res *= base;
        res += num;
    }
    if (eptr) |v| v.* = cur;
    return res;
}

fn strcpy(dest: [*:0]u8, src: [*:0]const u8) callconv(.C) [*:0]u8 {
    var i: usize = 0;
    while (src[i] != 0) : (i += 1) {
        dest[i] = src[i];
    }
    dest[i] = 0;

    return dest;
}

test "strcpy" {
    var s1: [9:0]u8 = undefined;

    s1[0] = 0;
    _ = strcpy(&s1, "foobarbaz");
    try std.testing.expectEqualSlices(u8, "foobarbaz", std.mem.sliceTo(&s1, 0));
}

fn strncpy(dest: [*:0]u8, src: [*:0]const u8, n: usize) callconv(.C) [*:0]u8 {
    var i: usize = 0;
    while (i < n and src[i] != 0) : (i += 1) {
        dest[i] = src[i];
    }
    while (i < n) : (i += 1) {
        dest[i] = 0;
    }

    return dest;
}

test "strncpy" {
    var s1: [9:0]u8 = undefined;

    s1[0] = 0;
    _ = strncpy(&s1, "foobarbaz", @sizeOf(@TypeOf(s1)));
    try std.testing.expectEqualSlices(u8, "foobarbaz", std.mem.sliceTo(&s1, 0));
}

fn strcat(dest: [*:0]u8, src: [*:0]const u8) callconv(.C) [*:0]u8 {
    var dest_end: usize = 0;
    while (dest[dest_end] != 0) : (dest_end += 1) {}

    var i: usize = 0;
    while (src[i] != 0) : (i += 1) {
        dest[dest_end + i] = src[i];
    }
    dest[dest_end + i] = 0;

    return dest;
}

test "strcat" {
    var s1: [9:0]u8 = undefined;

    s1[0] = 0;
    _ = strcat(&s1, "foo");
    _ = strcat(&s1, "bar");
    _ = strcat(&s1, "baz");
    try std.testing.expectEqualSlices(u8, "foobarbaz", std.mem.sliceTo(&s1, 0));
}

fn strncat(dest: [*:0]u8, src: [*:0]const u8, avail: usize) callconv(.C) [*:0]u8 {
    var dest_end: usize = 0;
    while (dest[dest_end] != 0) : (dest_end += 1) {}

    var i: usize = 0;
    while (i < avail and src[i] != 0) : (i += 1) {
        dest[dest_end + i] = src[i];
    }
    dest[dest_end + i] = 0;

    return dest;
}

test "strncat" {
    var s1: [9:0]u8 = undefined;

    s1[0] = 0;
    _ = strncat(&s1, "foo1111", 3);
    _ = strncat(&s1, "bar1111", 3);
    _ = strncat(&s1, "baz1111", 3);
    try std.testing.expectEqualSlices(u8, "foobarbaz", std.mem.sliceTo(&s1, 0));
}

fn strcmp(s1: [*:0]const u8, s2: [*:0]const u8) callconv(.C) c_int {
    return std.cstr.cmp(s1, s2);
}

// fn c_strlen(s: [*:0]const u8) callconv(.C) usize {
//     return std.mem.sliceTo(s, 0).len;
// }

fn strlen(s: [*:0]const u8) callconv(.C) usize {
    return std.mem.len(s);
}

fn strncmp(_l: [*:0]const u8, _r: [*:0]const u8, _n: usize) callconv(.C) c_int {
    if (_n == 0) return 0;
    var l = _l;
    var r = _r;
    var n = _n - 1;
    while (l[0] != 0 and r[0] != 0 and n != 0 and l[0] == r[0]) {
        l += 1;
        r += 1;
        n -= 1;
    }
    return @as(c_int, l[0]) - @as(c_int, r[0]);
}

fn strerror(errnum: c_int) callconv(.C) [*:0]const u8 {
    _ = errnum;
    return "TODO strerror implementation";
}

test "strncmp" {
    try std.testing.expect(strncmp("a", "b", 1) < 0);
    try std.testing.expect(strncmp("a", "c", 1) < 0);
    try std.testing.expect(strncmp("b", "a", 1) > 0);
    try std.testing.expect(strncmp("\xff", "\x02", 1) > 0);
}

fn c_setjmp(_: i32) callconv(.C) i32 {
    // Stack unwinding is not supported but continue anyway.
    return 0;
}

fn c_longjmp(_: i32, _: i32) callconv(.C) void {
    @panic("longjmp");
}

fn cpp_fwrite(_: i32, _: i32, _: i32, _: i32) callconv(.C) i32 {
    @panic("fwrite");
}
