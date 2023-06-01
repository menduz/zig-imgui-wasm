
// THIS FILE IS AUTOGENERATED USING "make idl"

pub extern "env" fn atan2f(x: f32, y: f32) f32;
pub extern "env" fn powf(x: f32, y: f32) f32;
pub extern "env" fn acosf(x: f32) f32;
pub extern "env" fn __stack_chk_fail() void;
pub extern "env" fn __assert_fail(a: i32, b: i32, c: i32, d: i32) void;
pub extern "env" fn toupper(char: i32) i32;
pub extern "env" fn printf(a: i32, b: i32) i32;
pub extern "env" fn sscanf(a: i32, b: i32) i32;
pub extern "env" fn fflush(a: i32) i32;

pub extern "stdx" fn jsPanic(ptr: *const u8, len: u32) void;
pub extern "stdx" fn jsWarn(ptr: *const u8, len: u32) void;
pub extern "stdx" fn jsLog(ptr: *const u8, len: u32) void;
pub extern "stdx" fn jsErr(ptr: *const u8, len: u32) void;

pub extern "graphics" fn jsSetCanvasBuffer(width: u32, height: u32) f32;
pub extern "graphics" fn glGetAttribLocation(program: u32, name: *const u8) i32;
pub extern "graphics" fn glGetVertexAttribfv(index: u32, pname: u32, name: [*c]const f32) void;
pub extern "graphics" fn glGetVertexAttribiv(index: u32, pname: u32, name: ?*const i32) void;
pub extern "graphics" fn glGetVertexAttribPointerv(index: u32, pname: u32, pointer_pointer: ?*const anyopaque) void;
pub extern "graphics" fn glDisableVertexAttribArray(index: u32) void;
pub extern "graphics" fn jsGlBlendEquationSeparate(modeRGB: u32, modeAlpha: u32) void;
pub extern "graphics" fn jsGlBlendFuncSeparate(srcRGB: u32, dstRGB: u32, srcAlpha: u32, dstAlpha: u32) void;
pub extern "graphics" fn jsGlPixelStorei(pname: u32, param: i32) void;
pub extern "graphics" fn jsGlIsEnabled(target: u32) u32;
pub extern "graphics" fn jsGlBufferData(target: u32, data_size: u32, data: ?*const anyopaque, usage: u32) void;
pub extern "graphics" fn jsGlBufferSubData(target: u32, offset: i32, data_size: u32, data: ?*const anyopaque) void;
pub extern "graphics" fn jsGlCreateTexture() u32;
pub extern "graphics" fn jsGlEnable(cap: u32) void;
pub extern "graphics" fn jsGlDisable(cap: u32) void;
pub extern "graphics" fn jsGlFrontFace(mode: u32) void;
pub extern "graphics" fn jsGlBindTexture(target: u32, texture: u32) void;
pub extern "graphics" fn jsGlClearColor(r: f32, g: f32, b: f32, a: f32) void;
pub extern "graphics" fn jsGlGetParameterInt(tag: u32) i32;
pub extern "graphics" fn jsGlGetFrameBufferBinding() u32;
pub extern "graphics" fn jsGlCreateFramebuffer() u32;
pub extern "graphics" fn jsGlBindFramebuffer(target: u32, framebuffer: u32) void;
pub extern "graphics" fn jsGlBindRenderbuffer(target: u32, renderbuffer: u32) void;
pub extern "graphics" fn jsGlRenderbufferStorageMultisample(target: u32, samples: i32, internalformat: u32, width: i32, height: i32) void;
pub extern "graphics" fn jsGlBindVertexArray(array: u32) void;
pub extern "graphics" fn jsGlBindBuffer(target: u32, buffer: u32) void;
pub extern "graphics" fn jsGlEnableVertexAttribArray(index: u32) void;
pub extern "graphics" fn jsGlCreateShader(shaderType: u32) u32;
pub extern "graphics" fn jsGlShaderSource(shader: u32, count: u32, src_ptr: ?*const anyopaque, src_len_ptr: ?*const anyopaque) void;
pub extern "graphics" fn jsGlCompileShader(shader: u32) void;
pub extern "graphics" fn jsGlGetShaderParameterInt(shader: u32, pname: u32) i32;
pub extern "graphics" fn jsGlGetShaderInfoLog(shader: u32, buf_size: u32, log_ptr: *u8) u32;
pub extern "graphics" fn jsGlDeleteShader(shader: u32) void;
pub extern "graphics" fn jsGlCreateProgram() u32;
pub extern "graphics" fn jsGlAttachShader(program: u32, shader: u32) void;
pub extern "graphics" fn jsGlDetachShader(program: u32, shader: u32) void;
pub extern "graphics" fn jsGlLinkProgram(program: u32) void;
pub extern "graphics" fn jsGlGetProgramParameterInt(program: u32, pname: u32) i32;
pub extern "graphics" fn jsGlGetProgramInfoLog(program: u32, buf_size: u32, log_ptr: *u8) u32;
pub extern "graphics" fn jsGlGetShaderiv(program: u32, pname: u32, ptr: *u8) void;
pub extern "graphics" fn jsGlGetProgramiv(program: u32, pname: u32, ptr: *u8) void;
pub extern "graphics" fn jsGlDeleteProgram(program: u32) void;
pub extern "graphics" fn jsGlCreateVertexArray() u32;
pub extern "graphics" fn jsGlDrawArraysInstanced(mode: u32, first: u32, count: u32, instanceCount: u32) void;
pub extern "graphics" fn jsGlDrawArrays(mode: u32, first: i32, count: i32) void;
pub extern "graphics" fn jsGlTexParameteri(target: u32, pname: u32, param: i32) void;
pub extern "graphics" fn jsGlTexImage2D(target: u32, level: i32, internal_format: i32, width: i32, height: i32, border: i32, format: u32, type: u32, pixels: ?*const u8) void;
pub extern "graphics" fn jsGlTexSubImage2D(target: u32, level: i32, xoffset: i32, yoffset: i32, width: i32, height: i32, format: u32, type: u32, pixels: ?*const u8) void;
pub extern "graphics" fn jsGlCreateBuffer() u32;
pub extern "graphics" fn jsGlVertexAttribPointer(index: u32, size: i32, type: u32, normalized: u32, stride: i32, pointer: ?*const anyopaque) void;
pub extern "graphics" fn jsGlActiveTexture(texture: u32) void;
pub extern "graphics" fn jsGlVertexAttribDivisor(index: u32, divisor: u32) void;
pub extern "graphics" fn jsGlDeleteTexture(texture: u32) void;
pub extern "graphics" fn jsGlUseProgram(program: u32) void;
pub extern "graphics" fn jsGlUniformMatrix4fv(location: i32, transpose: c_uint, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlUniformMatrix3fv(location: i32, transpose: c_uint, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlUniform1i(location: i32, val: i32) void;
pub extern "graphics" fn jsGlUniform1fv(location: i32, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlUniform2fv(location: i32, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlUniform3fv(location: i32, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlUniform4fv(location: i32, value_ptr: [*c]const f32) void;
pub extern "graphics" fn jsGlDrawElements(mode: u32, num_indices: u32, index_type: u32, index_offset: u32) void;
pub extern "graphics" fn jsGlCreateRenderbuffer() u32;
pub extern "graphics" fn jsGlPolygonOffset(factor: f32, units: f32) void;
pub extern "graphics" fn jsGlFramebufferRenderbuffer(target: u32, attachment: u32, renderbuffertarget: u32, renderbuffer: u32) void;
pub extern "graphics" fn jsGlFramebufferTexture2D(target: u32, attachment: u32, textarget: u32, texture: u32, level: i32) void;
pub extern "graphics" fn jsGlViewport(x: i32, y: i32, width: i32, height: i32) void;
pub extern "graphics" fn jsGlClear(mask: u32) void;
pub extern "graphics" fn jsGlLineWidth(width: f32) void;
pub extern "graphics" fn jsGlBlendFunc(sfactor: u32, dfactor: u32) void;
pub extern "graphics" fn jsGlBlitFramebuffer(srcX0: i32, srcY0: i32, srcX1: i32, srcY1: i32, dstX0: i32, dstY0: i32, dstX1: i32, dstY1: i32, mask: u32, filter: u32) void;
pub extern "graphics" fn jsGlBlendEquation(mode: u32) void;
pub extern "graphics" fn jsGlScissor(x: i32, y: i32, width: i32, height: i32) void;
pub extern "graphics" fn jsGlGetUniformLocation(program: u32, name_ptr: *const u8, name_len: u32) u32;
pub extern "graphics" fn jsGlCheckFramebufferStatus(target: u32) u32;
pub extern "graphics" fn jsGlDeleteVertexArray(vao: u32) void;
pub extern "graphics" fn jsGlDeleteBuffer(buffer: u32) void;
pub extern "graphics" fn jsGlFlush() void;
pub extern "graphics" fn jsGlFinish() void;
