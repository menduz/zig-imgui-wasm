import { getCString, getString } from './common';
import { ImguiWasmImports } from './idl'
import { ImguiWasmInstance } from './types';

export function initGraphicsImports(wasm: ImguiWasmInstance, canvas: HTMLCanvasElement, ctx: WebGL2RenderingContext): ImguiWasmImports["graphics"] {
  const text_encoder = new TextEncoder()

  const unused_res_ids: number[] = []
  let next_res_id = 1

  function getNextResId(): number {
    if (unused_res_ids.length > 0) {
      return unused_res_ids.shift()!
    } else {
      const id = next_res_id
      next_res_id += 1
      return id
    }
  }

  function removeResId(id: number) {
    unused_res_ids.push(id)
  }

  const textures = new Map()
  const framebuffers = new Map<number, WebGLFramebuffer>()
  const renderbuffers = new Map()
  const vertex_arrays = new Map<number, WebGLVertexArrayObject>()
  const shaders = new Map<number, WebGLShader>()
  const programs = new Map<number, WebGLProgram>()
  const buffers = new Map<number, WebGLBuffer>()
  const uniform_locs = new Map<number, WebGLUniformLocation>()

  function emscriptenWebGLGetVertexAttrib(index: number, pname: number, params: number, type: number) {
    if (!params) {
      debugger // GL.recordError(1281);
      return
    }
    const buffer = buffers.get(index)
    if (!buffer) {
      debugger
      throw new Error('glGetVertexAttrib*v on client-side array: not supported, bad data returned')
    }
    var data = ctx.getVertexAttrib(index, pname);
    if (pname == 34975) {
      wasm.mmem.HEAP32[params >>> 2] = data && data['name']
    } else if (typeof data == 'number' || typeof data == 'boolean') {
      switch (type) {
        case 0:
          wasm.mmem.HEAP32[params >>> 2] = +data;
          break;
        case 2:
          wasm.mmem.HEAPF32[params >>> 2] = +data;
          break;
        case 5:
          wasm.mmem.HEAP32[params >>> 2] = Math.fround(+data);
          break
      }
    } else {
      for (var i = 0; i < data.length; i++) {
        switch (type) {
          case 0:
            wasm.mmem.HEAP32[params + i * 4 >>> 2] = data[i];
            break;
          case 2:
            wasm.mmem.HEAPF32[params + i * 4 >>> 2] = data[i];
            break;
          case 5:
            wasm.mmem.HEAP32[params + i * 4 >>> 2] = Math.fround(data[i]);
            break
        }
      }
    }
  }

  function ensureShader(id: number) {
    const s = shaders.get(id)
    if (!s) {
      debugger
      throw new Error(`Missing shader id ${id}`)
    }
    return s
  }

  function ensureUniform(id: number) {
    const s = uniform_locs.get(id)
    if (!s) {
      debugger
      throw new Error(`Missing uniform id ${id}`)
    }
    return s
  }

  function ensureProgram(id: number) {
    const p = programs.get(id)
    if (!p) {
      debugger
      throw new Error(`Missing program id ${id}`)
    }
    return p
  }

  return {
    jsSetCanvasBuffer(width, height) {
      const dpr = window.devicePixelRatio || 1;

      const w = width * dpr
      const h = height * dpr

      if (w !== canvas.width || h !== canvas.height) {
        canvas.style.width = `${width}px`
        canvas.style.height = `${height}px`
        canvas.width = width * dpr
        canvas.height = height * dpr
      }

      return dpr
    },
    jsGlFrontFace(mode) {
      ctx.frontFace(mode);
    },
    jsGlGetUniformLocation(program_id, name_ptr, name_len) {
      const p = ensureProgram(program_id)
      const loc: any = ctx.getUniformLocation(p, getString(wasm, name_ptr, name_len))
      if (!loc.id) {
        loc.id = getNextResId()
        uniform_locs.set(loc.id, loc)
      }
      return loc.id
    },
    jsGlGetProgramiv(program, pname, params) {
      const p = ensureProgram(program)

      if (pname == 0x8B84) { // GL_INFO_LOG_LENGTH
        const log = ctx.getProgramInfoLog(p);
        // The GLES2 specification says that if the shader has an empty info log,
        // a value of 0 is returned. Otherwise the log has a null char appended.
        // (An empty string is falsey, so we can just check that instead of
        // looking at log.length.)
        const logLength = log ? log.length + 1 : 0;
        wasm.mmem.HEAP32[params >>> 2] = logLength
      } else {


        //     if (pname == 0x8B84) { // GL_INFO_LOG_LENGTH
        //       var log = GLctx.getProgramInfoLog(program);
        // #if GL_ASSERTIONS || GL_TRACK_ERRORS
        //       if (log === null) log = '(unknown error)';
        // #endif
        //       {{{ makeSetValue('p', '0', 'log.length + 1', 'i32') }}};
        //     } else if (pname == 0x8B87 /* GL_ACTIVE_UNIFORM_MAX_LENGTH */) {
        //       if (!program.maxUniformLength) {
        //         for (var i = 0; i < GLctx.getProgramParameter(program, 0x8B86/*GL_ACTIVE_UNIFORMS*/); ++i) {
        //           program.maxUniformLength = Math.max(program.maxUniformLength, GLctx.getActiveUniform(program, i).name.length+1);
        //         }
        //       }
        //       {{{ makeSetValue('p', '0', 'program.maxUniformLength', 'i32') }}};
        //     } else if (pname == 0x8B8A /* GL_ACTIVE_ATTRIBUTE_MAX_LENGTH */) {
        //       if (!program.maxAttributeLength) {
        //         for (var i = 0; i < GLctx.getProgramParameter(program, 0x8B89/*GL_ACTIVE_ATTRIBUTES*/); ++i) {
        //           program.maxAttributeLength = Math.max(program.maxAttributeLength, GLctx.getActiveAttrib(program, i).name.length+1);
        //         }
        //       }
        //       {{{ makeSetValue('p', '0', 'program.maxAttributeLength', 'i32') }}};
        //     } else if (pname == 0x8A35 /* GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH */) {
        //       if (!program.maxUniformBlockNameLength) {
        //         for (var i = 0; i < GLctx.getProgramParameter(program, 0x8A36/*GL_ACTIVE_UNIFORM_BLOCKS*/); ++i) {
        //           program.maxUniformBlockNameLength = Math.max(program.maxUniformBlockNameLength, GLctx.getActiveUniformBlockName(program, i).length+1);
        //         }
        //       }
        //       {{{ makeSetValue('p', '0', 'program.maxUniformBlockNameLength', 'i32') }}};
        //     } else {
        //       {{{ makeSetValue('p', '0', 'GLctx.getProgramParameter(program, pname)', 'i32') }}};
        //     }

        const param = ctx.getProgramParameter(p, pname);
        if (pname == ctx.LINK_STATUS) {
          if (param) {
            // gl.GL_TRUE
            wasm.mmem.HEAP32[params >>> 2] = 1
          }
          else {
            // gl.GL_FALSE
            wasm.mmem.HEAP32[params >>> 2] = 0
          }
        }
        else if (Number.isInteger(param)) {
          wasm.mmem.HEAP32[params >>> 2] = param
        }
        else if (param === true) {
          wasm.mmem.HEAP32[params >>> 2] = 1
        }
        else if (param === false) {
          wasm.mmem.HEAP32[params >>> 2] = 0
        }
        else {
          console.warn(`getProgramParameter 0x${pname.toString(16)}: ${param}`);
        }
      }
    },
    jsGlGetShaderiv(program, pname, params) {
      const s = ensureShader(program)
      if (program <= 0 || !s) {
        return;
      }
      if (pname == 0x8B84) { // GL_INFO_LOG_LENGTH
        const log = ctx.getShaderInfoLog(s);
        // The GLES2 specification says that if the shader has an empty info log,
        // a value of 0 is returned. Otherwise the log has a null char appended.
        // (An empty string is falsey, so we can just check that instead of
        // looking at log.length.)
        const logLength = log ? log.length + 1 : 0;
        wasm.mmem.HEAP32[params >>> 2] = logLength
      } else if (pname == 0x8B88) { // GL_SHADER_SOURCE_LENGTH
        var source = ctx.getShaderSource(s);
        // source may be a null, or the empty string, both of which are falsey
        // values that we report a 0 length for.
        var sourceLength = source ? source.length + 1 : 0;
        wasm.mmem.HEAP32[params >>> 2] = sourceLength
      } else {
        const param = ctx.getShaderParameter(s, pname);

        if (pname == ctx.LINK_STATUS) {
          if (param) {
            // gl.GL_TRUE
            wasm.mmem.HEAP32[params >>> 2] = 1
          }
          else {
            // gl.GL_FALSE
            wasm.mmem.HEAP32[params >>> 2] = 0
          }
        }
        else if (Number.isInteger(param)) {
          wasm.mmem.HEAP32[params >>> 2] = param
        }
        else if (param === true) {
          wasm.mmem.HEAP32[params >>> 2] = 1
        }
        else if (param === false) {
          wasm.mmem.HEAP32[params >>> 2] = 0
        }
        else {
          console.warn(`jsGlGetShaderiv 0x${pname.toString(16)}: ${param}`);
        }
      }
    },
    jsGlCreateTexture() {
      const id = getNextResId()
      textures.set(id, ctx.createTexture())
      return id
    },
    jsGlEnable(val) {
      ctx.enable(val)
    },
    jsGlDisable(val) {
      ctx.disable(val)
    },
    jsGlBindTexture(target, tex_id) {
      const tex = textures.get(tex_id)
      ctx.bindTexture(target, tex)
    },
    jsGlClearColor(r, g, b, a) {
      ctx.clearColor(r, g, b, a)
    },
    jsGlGetParameterInt(tag) {
      return ctx.getParameter(tag)
    },
    jsGlGetFrameBufferBinding() {
      const cur = ctx.getParameter(ctx.FRAMEBUFFER_BINDING)
      if (cur == null) {
        return 0
      } else {
        return cur.id
      }
    },
    jsGlPolygonOffset(factor, units) {
      ctx.polygonOffset(factor, units)
    },
    jsGlLineWidth(width) {
      ctx.lineWidth(width)
    },
    jsGlCreateFramebuffer() {
      const id = getNextResId()
      const fb: any = ctx.createFramebuffer()
      // Some ops will return the webgl fb object. Record the id on the object so it can map back to a wasm resource id.
      fb.id = id
      framebuffers.set(id, fb)
      return id
    },
    jsGlCreateRenderbuffer() {
      const id = getNextResId()
      renderbuffers.set(id, ctx.createRenderbuffer())
      return id
    },
    jsGlBindFramebuffer(target, id) {
      if (id == 0) {
        ctx.bindFramebuffer(target, null)
      } else {
        ctx.bindFramebuffer(target, framebuffers.get(id)! || null)
      }
    },
    jsGlRenderbufferStorageMultisample(target, samples, internalformat, width, height) {
      ctx.renderbufferStorageMultisample(target, samples, internalformat, width, height)
    },
    jsGlBindVertexArray(id) {
      ctx.bindVertexArray(vertex_arrays.get(id)!)
    },
    jsGlBindBuffer(target, id) {
      const buf = buffers.get(id) || null
      if (!buf && id !== 0) {
        debugger
        throw new Error('invalid buffer ' + id)
      }
      ctx.bindBuffer(target, buf)
    },
    jsGlEnableVertexAttribArray(index) {
      ctx.enableVertexAttribArray(index)
    },
    jsGlCreateShader(type) {
      const id = getNextResId()
      shaders.set(id, ctx.createShader(type)!)
      return id
    },
    // jsGlGetString(name) {
    //   switch (name) {
    //     case 0x1F03 /* GL_EXTENSIONS */:
    //       var exts = GLctx.getSupportedExtensions() || []; // .getSupportedExtensions() can return null if context is lost, so coerce to empty array.
    //       exts = exts.concat(exts.map(function (e) { return "GL_" + e; }));
    //       ret = stringToNewUTF8(exts.join(' '));
    //       break;
    //     case 0x1F00 /* GL_VENDOR */:
    //     case 0x1F01 /* GL_RENDERER */:
    //     case 0x9245 /* UNMASKED_VENDOR_WEBGL */:
    //     case 0x9246 /* UNMASKED_RENDERER_WEBGL */:
    //       var s = GLctx.getParameter(name_);
    //       if (!s) {
    //         GL.recordError(0x500/*GL_INVALID_ENUM*/);
    //         err('GL_INVALID_ENUM in glGetString: Received empty parameter for query name ' + name_ + '!'); // This occurs e.g. if one attempts GL_UNMASKED_VENDOR_WEBGL when it is not supported.
    //       }
    //       ret = s && stringToNewUTF8(s);
    //       break;

    //     case 0x1F02 /* GL_VERSION */:
    //       var glVersion = GLctx.getParameter(0x1F02 /*GL_VERSION*/);
    //       // return GLES version string corresponding to the version of the WebGL context
    //       if ({{ { isCurrentContextWebGL2() } })
    //       glVersion = 'OpenGL ES 3.0 (' + glVersion + ')';
    //       ret = stringToNewUTF8(glVersion);
    //       break;
    //     case 0x8B8C /* GL_SHADING_LANGUAGE_VERSION */:
    //       var glslVersion = GLctx.getParameter(0x8B8C /*GL_SHADING_LANGUAGE_VERSION*/);
    //       // extract the version number 'N.M' from the string 'WebGL GLSL ES N.M ...'
    //       var ver_re = /^WebGL GLSL ES ([0-9]\.[0-9][0-9]?)(?:$| .*)/;
    //       var ver_num = glslVersion.match(ver_re);
    //       if (ver_num !== null) {
    //         if (ver_num[1].length == 3) ver_num[1] = ver_num[1] + '0'; // ensure minor version has 2 digits
    //         glslVersion = 'OpenGL ES GLSL ES ' + ver_num[1] + ' (' + glslVersion + ')';
    //       }
    //       ret = stringToNewUTF8(glslVersion);
    //       break;
    //   }
    // },
    jsGlShaderSource(id, count, data_ptr, len_ptr) {
      var source = '';
      for (var i = 0; i < count; ++i) {
        const len = length ? wasm.mmem.HEAP32[len_ptr + i * 4 >>> 2] : - 1;
        const ptr = wasm.mmem.HEAP32[data_ptr + i * 4 >>> 2]
        source += len >= 0 ? getString(wasm, ptr, len) : getCString(wasm, ptr)
      }
      console.log({ source, shader: id })
      ctx.shaderSource(ensureShader(id), source)
    },
    jsGlCompileShader(id) {
      const shader = ensureShader(id)
      ctx.compileShader(shader)

      console.info('shader', id, ctx.getShaderInfoLog(shader));

      if (!ctx.getShaderParameter(shader, ctx.COMPILE_STATUS)) {
        console.error("Error compiling shader:" + ctx.getShaderInfoLog(shader));
      }
    },
    jsGlGetShaderParameterInt(id, param) {
      return ctx.getShaderParameter(ensureShader(id), param)
    },
    jsGlGetShaderInfoLog(id, buf_size, log_ptr) {
      const log = ctx.getShaderInfoLog(ensureShader(id))
      if (!log) {
        debugger
        throw new Error('no log')
      }
      const log_utf8 = text_encoder.encode(log).slice(0, buf_size)
      wasm.mmem.HEAPU8.set(log_utf8, log_ptr)
      return log.length
    },
    jsGlDeleteShader(id) {
      ctx.deleteShader(ensureShader(id))
      removeResId(id)
    },
    jsGlCreateProgram() {
      const id = getNextResId()
      programs.set(id, ctx.createProgram()!)
      return id
    },
    jsGlAttachShader(program_id, shader_id) {
      const program = ensureProgram(program_id)
      const shader = ensureShader(shader_id)
      ctx.attachShader(program, shader)
    },
    jsGlDetachShader(program_id, shader_id) {
      const program = ensureProgram(program_id)
      const shader = ensureShader(shader_id)
      ctx.detachShader(program, shader)
    },
    jsGlLinkProgram(id) {
      const program = ensureProgram(id)
      ctx.linkProgram(program)
      console.info('program', ctx.getProgramInfoLog(program));
      if (!ctx.getProgramParameter(program, ctx.LINK_STATUS)) {
        console.error("Error linking program:" + ctx.getProgramInfoLog(program));
      }
    },
    jsGlGetProgramParameterInt(id, param) {
      const program = ensureProgram(id)
      return ctx.getProgramParameter(program, param)
    },
    jsGlGetProgramInfoLog(id, buf_size, log_ptr) {
      const program = ensureProgram(id)
      const log = ctx.getProgramInfoLog(program)
      if (!log) {
        debugger
        throw new Error('no log')
      }
      const log_utf8 = text_encoder.encode(log).slice(0, buf_size)
      wasm.mmem.HEAPU8.set(log_utf8, log_ptr)
      return log.length
    },
    jsGlDeleteProgram(id) {
      const program = ensureProgram(id)
      ctx.deleteProgram(program)
      removeResId(id)
    },
    jsGlCreateVertexArray() {
      const id = getNextResId()
      vertex_arrays.set(id, ctx.createVertexArray()!)
      return id
    },
    jsGlDrawArraysInstanced(mode, first, count, instanceCount) {
      ctx.drawArraysInstanced(mode, first, count, instanceCount)
    },
    jsGlDrawArrays(mode, first, count) {
      ctx.drawArrays(mode, first, count)
    },
    jsGlTexParameteri(target, pname, param) {
      ctx.texParameteri(target, pname, param)
    },
    jsGlTexImage2D(target, level, internal_format, width, height, border, format, type, pixels_ptr) {
      if (pixels_ptr == 0) {
        // Initialize buffer with undefined values.
        ctx.texImage2D(target, level, internal_format, width, height, border, format, type, null)
      } else {
        ctx.texImage2D(target, level, internal_format, width, height, border, format, type, wasm.mmem.HEAPU8, pixels_ptr)
      }
    },
    jsGlTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels_ptr) {
      ctx.texSubImage2D(target, level, xoffset, yoffset, width, height, format, type, wasm.mmem.HEAPU8, pixels_ptr)
    },
    jsGlCreateBuffer() {
      const id = getNextResId()
      const buf = ctx.createBuffer()
      if (!buf) throw new Error('cannot create buffer')
      buffers.set(id, buf)
      return id
    },
    jsGlVertexAttribPointer(index, size, type, normalized, stride, offset) {
      ctx.vertexAttribPointer(index, size, type, !!normalized, stride, offset)
    },
    jsGlActiveTexture(tex) {
      // tex is a gl.TEXTUREI and not a resource id.
      ctx.activeTexture(tex)
    },
    jsGlDeleteTexture(id) {
      ctx.deleteTexture(textures.get(id))
      removeResId(id)
    },
    jsGlUseProgram(id) {
      if (!id) {
        ctx.useProgram(null)
      } else {
        const program = ensureProgram(id)
        ctx.useProgram(program)
      }
    },
    jsGlUniformMatrix3fv(location, transpose, value_ptr) {
      const loc = ensureUniform(location)
      ctx.uniformMatrix3fv(loc, !!transpose, new Float32Array(wasm.mmem.HEAPU8.slice(value_ptr, value_ptr + 9 * 4).buffer))
    },
    jsGlUniformMatrix4fv(location, transpose, value_ptr) {
      const loc = ensureUniform(location)
      ctx.uniformMatrix4fv(loc, !!transpose, new Float32Array(wasm.mmem.HEAPU8.slice(value_ptr, value_ptr + 16 * 4).buffer))
    },
    jsGlUniform4fv(location, val_ptr) {
      const loc = ensureUniform(location)
      ctx.uniform4fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 4 * 4).buffer))
    },
    jsGlUniform3fv(location, val_ptr) {
      const loc = ensureUniform(location)
      ctx.uniform3fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 3 * 4).buffer))
    },
    jsGlUniform2fv(location, val_ptr) {
      const loc = ensureUniform(location)
      ctx.uniform2fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 2 * 4).buffer))
    },
    jsGlUniform1fv(location, val_ptr) {
      const loc = ensureUniform(location)
      ctx.uniform1fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 1 * 4).buffer))
    },
    jsGlUniform1i(location, val) {
      const loc = ensureUniform(location)
      ctx.uniform1i(loc, val)
    },
    jsGlBufferData(target, data_size, data_ptr, usage) {
      ctx.bufferData(target, wasm.mmem.HEAPU8, usage, data_ptr, data_size)
    },
    jsGlBufferSubData(target, offset, data_size, data_ptr) {
      ctx.bufferSubData(target, offset, wasm.mmem.HEAPU8, data_ptr, data_size)
    },
    jsGlDrawElements(mode, num_indices, index_type, index_offset) {
      ctx.drawElements(mode, num_indices, index_type, index_offset)
    },
    jsGlBindRenderbuffer(target, id) {
      ctx.bindRenderbuffer(target, renderbuffers.get(id))
    },
    jsGlFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer) {
      ctx.framebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffers.get(renderbuffer))
    },
    jsGlFramebufferTexture2D(target, attachment, textarget, texture, level) {
      ctx.framebufferTexture2D(target, attachment, textarget, textures.get(texture), level)
    },
    jsGlViewport(x, y, width, height) {
      ctx.viewport(x, y, width, height)
    },
    jsGlClear(mask) {
      ctx.clear(mask)
    },
    jsGlBlendFunc(sfactor, dfactor) {
      ctx.blendFunc(sfactor, dfactor)
    },
    jsGlBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter) {
      ctx.blitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter)
    },
    jsGlBlendEquation(mode) {
      ctx.blendEquation(mode)
    },
    jsGlScissor(x, y, width, height) {
      ctx.scissor(x, y, width, height)
    },
    jsGlCheckFramebufferStatus(target) {
      return ctx.checkFramebufferStatus(target)
    },
    jsGlDeleteVertexArray(id) {
      ctx.deleteVertexArray(vertex_arrays.get(id)!)
    },
    jsGlDeleteBuffer(id) {
      const buf = buffers.get(id)
      buf && ctx.deleteBuffer(buf)
      buffers.delete(id)
    },
    jsGlVertexAttribDivisor(index, divisor) {
      ctx.vertexAttribDivisor(index, divisor);
    },
    jsGlFlush() {
      ctx.flush()
    },
    jsGlFinish() {
      ctx.finish()
    },
    jsGlBlendEquationSeparate(modeRGB, modeAlpha) {
      ctx.blendEquationSeparate(modeRGB, modeAlpha)
    },
    jsGlBlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha) {
      ctx.blendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha)
    },
    jsGlPixelStorei(pname, param) {
      ctx.pixelStorei(pname, !!param)
    },
    jsGlIsEnabled(target) {
      return ctx.isEnabled(target) ? 1 : 0
    },
    glDisableVertexAttribArray(index) {
      ctx.disableVertexAttribArray(index)
    },
    glGetAttribLocation(program_id, name) {
      const program = ensureProgram(program_id)
      const attrib = getCString(wasm, name)
      return ctx.getAttribLocation(program, attrib)
    },
    glGetVertexAttribfv(index, pname, params) {
      emscriptenWebGLGetVertexAttrib(index, pname, params, 2)
    },
    glGetVertexAttribiv(index, pname, params) {
      emscriptenWebGLGetVertexAttrib(index, pname, params, 5)
    },
    glGetVertexAttribPointerv(index, pname, pointer_pointer) {
      emscriptenWebGLGetVertexAttrib(index, pname, pointer_pointer, 0)
    },
  }
}