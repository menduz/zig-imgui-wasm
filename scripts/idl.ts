/// <reference types="node" />

import { genTypescriptTypes, genZigTypes, parseSignature } from "./gen-idl";
import { writeFileSync } from "node:fs";

/// WebGL2 bindings.
/// https://developer.mozilla.org/en-US/docs/Web/API/WebGLRenderingContext
/// https://developer.mozilla.org/en-US/docs/Web/API/WebGL2RenderingContext

const idl = {
  env: [
    "atan2f(x: f32, y: f32) f32",
    "powf(x: f32, y: f32) f32",
    "acosf(x: f32) f32",
    "__stack_chk_fail() void",
    "__assert_fail(a: i32, b: i32, c: i32, d: i32) void",
    "toupper(char: i32) i32",
    "printf(a: i32,b: i32) i32",
    "sscanf(a: i32,b: i32) i32",
    "fflush(a: i32) i32",
    // "sprintf(a: i32, b: i32, c: i32) i32",
    // "snprintf(a: i32, b: i32, c: i32, d: i32) i32",
  ].map(parseSignature),
  stdx: [
    "jsPanic(ptr: string, len: u32) void",
    "jsWarn(ptr: string, len: u32) void",
    "jsLog(ptr: string, len: u32) void",
    "jsErr(ptr: string, len: u32) void"
  ].map(parseSignature),
  graphics: [
    "jsSetCanvasBuffer(width: u32, height: u32) f32",
    // extern "C" GLint glGetAttribLocation (GLuint program, const GLchar *name);
    "glGetAttribLocation(program: GLuint, name: string) GLint",
    // extern "C" void glGetVertexAttribfv (GLuint index, GLenum pname, GLint *params);
    "glGetVertexAttribfv(index: GLuint, pname: GLenum, name: f32_ptr) void",
    // extern "C" void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params);
    "glGetVertexAttribiv(index: GLuint, pname: GLenum, name: GLint_ptr) void",
    // extern "C" void glGetVertexAttribPointerv (GLuint index, GLenum pname, void **pointer);
    "glGetVertexAttribPointerv(index: GLuint, pname: GLenum, pointer_pointer: anyptr) void",
    // extern "C" void glDisableVertexAttribArray (GLuint index);
    "glDisableVertexAttribArray(index: GLuint) void",
    "jsGlBlendEquationSeparate(modeRGB: u32, modeAlpha: u32) void",
    "jsGlBlendFuncSeparate(srcRGB: GLenum, dstRGB: GLenum, srcAlpha: GLenum, dstAlpha: GLenum) void",
    "jsGlPixelStorei(pname: GLenum, param: GLint) void",
    "jsGlIsEnabled(target: GLenum) u32",
    "jsGlBufferData(target: GLenum, data_size: u32, data: anyptr, usage: GLenum) void",
    "jsGlBufferSubData(target: GLenum, offset: i32, data_size: u32, data: anyptr) void",
    "jsGlCreateTexture() u32",
    "jsGlEnable(cap: u32) void",
    "jsGlDisable(cap: u32) void",
    "jsGlFrontFace(mode: u32) void",
    "jsGlBindTexture(target: u32, texture: u32) void",
    "jsGlClearColor(r: f32, g: f32, b: f32, a: f32) void",
    "jsGlGetParameterInt(tag: u32) i32",
    "jsGlGetFrameBufferBinding() u32",
    "jsGlCreateFramebuffer() u32",
    "jsGlBindFramebuffer(target: u32, framebuffer: u32) void",
    "jsGlBindRenderbuffer(target: u32, renderbuffer: u32) void",
    "jsGlRenderbufferStorageMultisample(target: u32, samples: i32, internalformat: u32, width: i32, height: i32) void",
    "jsGlBindVertexArray(array: u32) void",
    "jsGlBindBuffer(target: u32, buffer: u32) void",
    "jsGlEnableVertexAttribArray(index: u32) void",
    "jsGlCreateShader(shaderType: u32) u32",
    "jsGlShaderSource(shader: u32, count: u32, src_ptr: anyptr, src_len_ptr: anyptr) void",
    "jsGlCompileShader(shader: u32) void",
    "jsGlGetShaderParameterInt(shader: u32, pname: u32) i32",
    "jsGlGetShaderInfoLog(shader: u32, buf_size: u32, log_ptr: u8_ptr) u32",
    "jsGlDeleteShader(shader: u32) void",
    "jsGlCreateProgram() u32",
    "jsGlAttachShader(program: u32, shader: u32) void",
    "jsGlDetachShader(program: u32, shader: u32) void",
    "jsGlLinkProgram(program: u32) void",
    "jsGlGetProgramParameterInt(program: u32, pname: u32) i32",
    "jsGlGetProgramInfoLog(program: u32, buf_size: u32, log_ptr: u8_ptr) u32",
    "jsGlGetShaderiv(program: GLuint, pname: GLenum, ptr: u8_ptr) void",
    "jsGlGetProgramiv(program: GLuint, pname: GLenum, ptr: u8_ptr) void",
    "jsGlDeleteProgram(program: u32) void",
    "jsGlCreateVertexArray() u32",
    "jsGlDrawArraysInstanced(mode: u32, first: u32, count: u32, instanceCount: u32) void",
    "jsGlDrawArrays(mode: GLenum, first: GLint, count: GLsizei) void",
    "jsGlTexParameteri(target: u32, pname: u32, param: i32) void",
    "jsGlTexImage2D(target: u32, level: i32, internal_format: i32, width: i32, height: i32, border: i32, format: u32, type: u32, pixels: ?string) void",
    "jsGlTexSubImage2D(target: u32, level: i32, xoffset: i32, yoffset: i32, width: i32, height: i32, format: u32, type: u32, pixels: ?string) void",
    "jsGlCreateBuffer() u32",
    "jsGlVertexAttribPointer(index: u32, size: i32, type: u32, normalized: u32, stride: i32, pointer: anyptr) void",
    "jsGlActiveTexture(texture: u32) void",
    "jsGlVertexAttribDivisor(index: u32, divisor: u32) void",
    "jsGlDeleteTexture(texture: u32) void",
    "jsGlUseProgram(program: u32) void",
    "jsGlUniformMatrix4fv(location: i32, transpose: boolean, value_ptr: f32_ptr) void",
    "jsGlUniformMatrix3fv(location: i32, transpose: boolean, value_ptr: f32_ptr) void",
    "jsGlUniform1i(location: i32, val: i32) void",
    "jsGlUniform1fv(location: i32, value_ptr: f32_ptr) void",
    "jsGlUniform2fv(location: i32, value_ptr: f32_ptr) void",
    "jsGlUniform3fv(location: i32, value_ptr: f32_ptr) void",
    "jsGlUniform4fv(location: i32, value_ptr: f32_ptr) void",
    "jsGlDrawElements(mode: u32, num_indices: u32, index_type: u32, index_offset: u32) void",
    "jsGlCreateRenderbuffer() u32",
    "jsGlPolygonOffset(factor: f32, units: f32) void",
    "jsGlFramebufferRenderbuffer(target: u32, attachment: u32, renderbuffertarget: u32, renderbuffer: u32) void",
    "jsGlFramebufferTexture2D(target: u32, attachment: u32, textarget: u32, texture: u32, level: i32) void",
    "jsGlViewport(x: i32, y: i32, width: i32, height: i32) void",
    "jsGlClear(mask: u32) void",
    "jsGlLineWidth(width: f32) void",
    "jsGlBlendFunc(sfactor: u32, dfactor: u32) void",
    "jsGlBlitFramebuffer(srcX0: i32, srcY0: i32, srcX1: i32, srcY1: i32, dstX0: i32, dstY0: i32, dstX1: i32, dstY1: i32, mask: u32, filter: u32) void",
    "jsGlBlendEquation(mode: u32) void",
    "jsGlScissor(x: i32, y: i32, width: i32, height: i32) void",
    "jsGlGetUniformLocation(program: u32, name_ptr: string, name_len: u32) u32",
    "jsGlCheckFramebufferStatus(target: u32) u32",
    "jsGlDeleteVertexArray(vao: u32) void",
    "jsGlDeleteBuffer(buffer: u32) void",
    "jsGlFlush() void",
    "jsGlFinish() void"
  ].map(parseSignature)
}

writeFileSync('src/js/idl.ts', genTypescriptTypes(idl))
writeFileSync('src/lib/wasm/idl.zig', genZigTypes(idl))

console.log('done')