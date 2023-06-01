"use strict";
var ZigImgui = (() => {
  var __defProp = Object.defineProperty;
  var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
  var __getOwnPropNames = Object.getOwnPropertyNames;
  var __hasOwnProp = Object.prototype.hasOwnProperty;
  var __export = (target, all) => {
    for (var name in all)
      __defProp(target, name, { get: all[name], enumerable: true });
  };
  var __copyProps = (to, from, except, desc) => {
    if (from && typeof from === "object" || typeof from === "function") {
      for (let key of __getOwnPropNames(from))
        if (!__hasOwnProp.call(to, key) && key !== except)
          __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
    }
    return to;
  };
  var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

  // src/js/index.ts
  var js_exports = {};
  __export(js_exports, {
    createImgui: () => createImgui,
    initInputApi: () => initInputApi
  });

  // src/js/common.ts
  var textDecoder = new TextDecoder();
  var textEncoder = new TextEncoder();
  function getString(wasm, ptr, len) {
    return textDecoder.decode(wasm.exports.memory.buffer.slice(ptr, ptr + len));
  }
  function getCString(wasm, ptr) {
    const view = new Uint8Array(wasm.exports.memory.buffer.slice(ptr));
    let count = 0;
    while (view[count] !== 0)
      count++;
    return textDecoder.decode(wasm.exports.memory.buffer.slice(ptr, ptr + count));
  }

  // src/js/env.ts
  function initEnvImports(wasm) {
    return {
      __assert_fail(expr, file, line, func) {
        const errorExpression = getCString(wasm, expr);
        const errorFile = getCString(wasm, file);
        const errorLine = line;
        const errorFunction = getCString(wasm, func);
        try {
          throw new Error("asd");
        } catch (err) {
          err.stack = errorExpression + `
    at ${errorFunction} (${errorFile}:${errorLine})` + err.stack.replace(/.+__assert_fail.+\n/m, "").replace(/Error: asd/, "");
          console.error(err);
          debugger;
          throw err;
        }
      },
      __stack_chk_fail() {
        debugger;
        console.log("__stack_chk_fail");
      },
      acosf(x) {
        return Math.acos(x);
      },
      atan2f(x, y) {
        return Math.atan2(x, y);
      },
      powf(x, y) {
        return Math.pow(x, y);
      },
      toupper(char) {
        return String.fromCharCode(char).toUpperCase().charCodeAt(0);
      },
      printf(a, b) {
        debugger;
        return 0;
      },
      sscanf(a, b) {
        debugger;
        return 0;
      },
      fflush(a) {
        debugger;
        return 0;
      }
    };
  }

  // src/js/graphics.ts
  function initGraphicsImports(wasm, canvas, ctx) {
    const text_encoder = new TextEncoder();
    const unused_res_ids = [];
    let next_res_id = 1;
    function getNextResId() {
      if (unused_res_ids.length > 0) {
        return unused_res_ids.shift();
      } else {
        const id = next_res_id;
        next_res_id += 1;
        return id;
      }
    }
    function removeResId(id) {
      unused_res_ids.push(id);
    }
    const textures = /* @__PURE__ */ new Map();
    const framebuffers = /* @__PURE__ */ new Map();
    const renderbuffers = /* @__PURE__ */ new Map();
    const vertex_arrays = /* @__PURE__ */ new Map();
    const shaders = /* @__PURE__ */ new Map();
    const programs = /* @__PURE__ */ new Map();
    const buffers = /* @__PURE__ */ new Map();
    const uniform_locs = /* @__PURE__ */ new Map();
    function emscriptenWebGLGetVertexAttrib(index, pname, params, type) {
      if (!params) {
        debugger;
        return;
      }
      const buffer = buffers.get(index);
      if (!buffer) {
        debugger;
        throw new Error("glGetVertexAttrib*v on client-side array: not supported, bad data returned");
      }
      var data = ctx.getVertexAttrib(index, pname);
      if (pname == 34975) {
        wasm.mmem.HEAP32[params >>> 2] = data && data["name"];
      } else if (typeof data == "number" || typeof data == "boolean") {
        switch (type) {
          case 0:
            wasm.mmem.HEAP32[params >>> 2] = +data;
            break;
          case 2:
            wasm.mmem.HEAPF32[params >>> 2] = +data;
            break;
          case 5:
            wasm.mmem.HEAP32[params >>> 2] = Math.fround(+data);
            break;
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
              break;
          }
        }
      }
    }
    function ensureShader(id) {
      const s = shaders.get(id);
      if (!s) {
        debugger;
        throw new Error(`Missing shader id ${id}`);
      }
      return s;
    }
    function ensureUniform(id) {
      const s = uniform_locs.get(id);
      if (!s) {
        debugger;
        throw new Error(`Missing uniform id ${id}`);
      }
      return s;
    }
    function ensureProgram(id) {
      const p = programs.get(id);
      if (!p) {
        debugger;
        throw new Error(`Missing program id ${id}`);
      }
      return p;
    }
    return {
      jsSetCanvasBuffer(width, height) {
        const dpr = window.devicePixelRatio || 1;
        const w = width * dpr;
        const h = height * dpr;
        if (w !== canvas.width || h !== canvas.height) {
          canvas.style.width = `${width}px`;
          canvas.style.height = `${height}px`;
          canvas.width = width * dpr;
          canvas.height = height * dpr;
        }
        return dpr;
      },
      jsGlFrontFace(mode) {
        ctx.frontFace(mode);
      },
      jsGlGetUniformLocation(program_id, name_ptr, name_len) {
        const p = ensureProgram(program_id);
        const loc = ctx.getUniformLocation(p, getString(wasm, name_ptr, name_len));
        if (!loc.id) {
          loc.id = getNextResId();
          uniform_locs.set(loc.id, loc);
        }
        return loc.id;
      },
      jsGlGetProgramiv(program, pname, params) {
        const p = ensureProgram(program);
        if (pname == 35716) {
          const log = ctx.getProgramInfoLog(p);
          const logLength = log ? log.length + 1 : 0;
          wasm.mmem.HEAP32[params >>> 2] = logLength;
        } else {
          const param = ctx.getProgramParameter(p, pname);
          if (pname == ctx.LINK_STATUS) {
            if (param) {
              wasm.mmem.HEAP32[params >>> 2] = 1;
            } else {
              wasm.mmem.HEAP32[params >>> 2] = 0;
            }
          } else if (Number.isInteger(param)) {
            wasm.mmem.HEAP32[params >>> 2] = param;
          } else if (param === true) {
            wasm.mmem.HEAP32[params >>> 2] = 1;
          } else if (param === false) {
            wasm.mmem.HEAP32[params >>> 2] = 0;
          } else {
            console.warn(`getProgramParameter 0x${pname.toString(16)}: ${param}`);
          }
        }
      },
      jsGlGetShaderiv(program, pname, params) {
        const s = ensureShader(program);
        if (program <= 0 || !s) {
          return;
        }
        if (pname == 35716) {
          const log = ctx.getShaderInfoLog(s);
          const logLength = log ? log.length + 1 : 0;
          wasm.mmem.HEAP32[params >>> 2] = logLength;
        } else if (pname == 35720) {
          var source = ctx.getShaderSource(s);
          var sourceLength = source ? source.length + 1 : 0;
          wasm.mmem.HEAP32[params >>> 2] = sourceLength;
        } else {
          const param = ctx.getShaderParameter(s, pname);
          if (pname == ctx.LINK_STATUS) {
            if (param) {
              wasm.mmem.HEAP32[params >>> 2] = 1;
            } else {
              wasm.mmem.HEAP32[params >>> 2] = 0;
            }
          } else if (Number.isInteger(param)) {
            wasm.mmem.HEAP32[params >>> 2] = param;
          } else if (param === true) {
            wasm.mmem.HEAP32[params >>> 2] = 1;
          } else if (param === false) {
            wasm.mmem.HEAP32[params >>> 2] = 0;
          } else {
            console.warn(`jsGlGetShaderiv 0x${pname.toString(16)}: ${param}`);
          }
        }
      },
      jsGlCreateTexture() {
        const id = getNextResId();
        textures.set(id, ctx.createTexture());
        return id;
      },
      jsGlEnable(val) {
        ctx.enable(val);
      },
      jsGlDisable(val) {
        ctx.disable(val);
      },
      jsGlBindTexture(target, tex_id) {
        const tex = textures.get(tex_id);
        ctx.bindTexture(target, tex);
      },
      jsGlClearColor(r, g, b, a) {
        ctx.clearColor(r, g, b, a);
      },
      jsGlGetParameterInt(tag) {
        return ctx.getParameter(tag);
      },
      jsGlGetFrameBufferBinding() {
        const cur = ctx.getParameter(ctx.FRAMEBUFFER_BINDING);
        if (cur == null) {
          return 0;
        } else {
          return cur.id;
        }
      },
      jsGlPolygonOffset(factor, units) {
        ctx.polygonOffset(factor, units);
      },
      jsGlLineWidth(width) {
        ctx.lineWidth(width);
      },
      jsGlCreateFramebuffer() {
        const id = getNextResId();
        const fb = ctx.createFramebuffer();
        fb.id = id;
        framebuffers.set(id, fb);
        return id;
      },
      jsGlCreateRenderbuffer() {
        const id = getNextResId();
        renderbuffers.set(id, ctx.createRenderbuffer());
        return id;
      },
      jsGlBindFramebuffer(target, id) {
        if (id == 0) {
          ctx.bindFramebuffer(target, null);
        } else {
          ctx.bindFramebuffer(target, framebuffers.get(id) || null);
        }
      },
      jsGlRenderbufferStorageMultisample(target, samples, internalformat, width, height) {
        ctx.renderbufferStorageMultisample(target, samples, internalformat, width, height);
      },
      jsGlBindVertexArray(id) {
        ctx.bindVertexArray(vertex_arrays.get(id));
      },
      jsGlBindBuffer(target, id) {
        const buf = buffers.get(id) || null;
        if (!buf && id !== 0) {
          debugger;
          throw new Error("invalid buffer " + id);
        }
        ctx.bindBuffer(target, buf);
      },
      jsGlEnableVertexAttribArray(index) {
        ctx.enableVertexAttribArray(index);
      },
      jsGlCreateShader(type) {
        const id = getNextResId();
        shaders.set(id, ctx.createShader(type));
        return id;
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
        var source = "";
        for (var i = 0; i < count; ++i) {
          const len = length ? wasm.mmem.HEAP32[len_ptr + i * 4 >>> 2] : -1;
          const ptr = wasm.mmem.HEAP32[data_ptr + i * 4 >>> 2];
          source += len >= 0 ? getString(wasm, ptr, len) : getCString(wasm, ptr);
        }
        console.log({ source, shader: id });
        ctx.shaderSource(ensureShader(id), source);
      },
      jsGlCompileShader(id) {
        const shader = ensureShader(id);
        ctx.compileShader(shader);
        console.info("shader", id, ctx.getShaderInfoLog(shader));
        if (!ctx.getShaderParameter(shader, ctx.COMPILE_STATUS)) {
          console.error("Error compiling shader:" + ctx.getShaderInfoLog(shader));
        }
      },
      jsGlGetShaderParameterInt(id, param) {
        return ctx.getShaderParameter(ensureShader(id), param);
      },
      jsGlGetShaderInfoLog(id, buf_size, log_ptr) {
        const log = ctx.getShaderInfoLog(ensureShader(id));
        if (!log) {
          debugger;
          throw new Error("no log");
        }
        const log_utf8 = text_encoder.encode(log).slice(0, buf_size);
        wasm.mmem.HEAPU8.set(log_utf8, log_ptr);
        return log.length;
      },
      jsGlDeleteShader(id) {
        ctx.deleteShader(ensureShader(id));
        removeResId(id);
      },
      jsGlCreateProgram() {
        const id = getNextResId();
        programs.set(id, ctx.createProgram());
        return id;
      },
      jsGlAttachShader(program_id, shader_id) {
        const program = ensureProgram(program_id);
        const shader = ensureShader(shader_id);
        ctx.attachShader(program, shader);
      },
      jsGlDetachShader(program_id, shader_id) {
        const program = ensureProgram(program_id);
        const shader = ensureShader(shader_id);
        ctx.detachShader(program, shader);
      },
      jsGlLinkProgram(id) {
        const program = ensureProgram(id);
        ctx.linkProgram(program);
        console.info("program", ctx.getProgramInfoLog(program));
        if (!ctx.getProgramParameter(program, ctx.LINK_STATUS)) {
          console.error("Error linking program:" + ctx.getProgramInfoLog(program));
        }
      },
      jsGlGetProgramParameterInt(id, param) {
        const program = ensureProgram(id);
        return ctx.getProgramParameter(program, param);
      },
      jsGlGetProgramInfoLog(id, buf_size, log_ptr) {
        const program = ensureProgram(id);
        const log = ctx.getProgramInfoLog(program);
        if (!log) {
          debugger;
          throw new Error("no log");
        }
        const log_utf8 = text_encoder.encode(log).slice(0, buf_size);
        wasm.mmem.HEAPU8.set(log_utf8, log_ptr);
        return log.length;
      },
      jsGlDeleteProgram(id) {
        const program = ensureProgram(id);
        ctx.deleteProgram(program);
        removeResId(id);
      },
      jsGlCreateVertexArray() {
        const id = getNextResId();
        vertex_arrays.set(id, ctx.createVertexArray());
        return id;
      },
      jsGlDrawArraysInstanced(mode, first, count, instanceCount) {
        ctx.drawArraysInstanced(mode, first, count, instanceCount);
      },
      jsGlDrawArrays(mode, first, count) {
        ctx.drawArrays(mode, first, count);
      },
      jsGlTexParameteri(target, pname, param) {
        ctx.texParameteri(target, pname, param);
      },
      jsGlTexImage2D(target, level, internal_format, width, height, border, format, type, pixels_ptr) {
        if (pixels_ptr == 0) {
          ctx.texImage2D(target, level, internal_format, width, height, border, format, type, null);
        } else {
          ctx.texImage2D(target, level, internal_format, width, height, border, format, type, wasm.mmem.HEAPU8, pixels_ptr);
        }
      },
      jsGlTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels_ptr) {
        ctx.texSubImage2D(target, level, xoffset, yoffset, width, height, format, type, wasm.mmem.HEAPU8, pixels_ptr);
      },
      jsGlCreateBuffer() {
        const id = getNextResId();
        const buf = ctx.createBuffer();
        if (!buf)
          throw new Error("cannot create buffer");
        buffers.set(id, buf);
        return id;
      },
      jsGlVertexAttribPointer(index, size, type, normalized, stride, offset) {
        ctx.vertexAttribPointer(index, size, type, !!normalized, stride, offset);
      },
      jsGlActiveTexture(tex) {
        ctx.activeTexture(tex);
      },
      jsGlDeleteTexture(id) {
        ctx.deleteTexture(textures.get(id));
        removeResId(id);
      },
      jsGlUseProgram(id) {
        if (!id) {
          ctx.useProgram(null);
        } else {
          const program = ensureProgram(id);
          ctx.useProgram(program);
        }
      },
      jsGlUniformMatrix3fv(location, transpose, value_ptr) {
        const loc = ensureUniform(location);
        ctx.uniformMatrix3fv(loc, !!transpose, new Float32Array(wasm.mmem.HEAPU8.slice(value_ptr, value_ptr + 9 * 4).buffer));
      },
      jsGlUniformMatrix4fv(location, transpose, value_ptr) {
        const loc = ensureUniform(location);
        ctx.uniformMatrix4fv(loc, !!transpose, new Float32Array(wasm.mmem.HEAPU8.slice(value_ptr, value_ptr + 16 * 4).buffer));
      },
      jsGlUniform4fv(location, val_ptr) {
        const loc = ensureUniform(location);
        ctx.uniform4fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 4 * 4).buffer));
      },
      jsGlUniform3fv(location, val_ptr) {
        const loc = ensureUniform(location);
        ctx.uniform3fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 3 * 4).buffer));
      },
      jsGlUniform2fv(location, val_ptr) {
        const loc = ensureUniform(location);
        ctx.uniform2fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 2 * 4).buffer));
      },
      jsGlUniform1fv(location, val_ptr) {
        const loc = ensureUniform(location);
        ctx.uniform1fv(loc, new Float32Array(wasm.mmem.HEAPU8.slice(val_ptr, val_ptr + 1 * 4).buffer));
      },
      jsGlUniform1i(location, val) {
        const loc = ensureUniform(location);
        ctx.uniform1i(loc, val);
      },
      jsGlBufferData(target, data_size, data_ptr, usage) {
        ctx.bufferData(target, wasm.mmem.HEAPU8, usage, data_ptr, data_size);
      },
      jsGlBufferSubData(target, offset, data_size, data_ptr) {
        ctx.bufferSubData(target, offset, wasm.mmem.HEAPU8, data_ptr, data_size);
      },
      jsGlDrawElements(mode, num_indices, index_type, index_offset) {
        ctx.drawElements(mode, num_indices, index_type, index_offset);
      },
      jsGlBindRenderbuffer(target, id) {
        ctx.bindRenderbuffer(target, renderbuffers.get(id));
      },
      jsGlFramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer) {
        ctx.framebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffers.get(renderbuffer));
      },
      jsGlFramebufferTexture2D(target, attachment, textarget, texture, level) {
        ctx.framebufferTexture2D(target, attachment, textarget, textures.get(texture), level);
      },
      jsGlViewport(x, y, width, height) {
        ctx.viewport(x, y, width, height);
      },
      jsGlClear(mask) {
        ctx.clear(mask);
      },
      jsGlBlendFunc(sfactor, dfactor) {
        ctx.blendFunc(sfactor, dfactor);
      },
      jsGlBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter) {
        ctx.blitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
      },
      jsGlBlendEquation(mode) {
        ctx.blendEquation(mode);
      },
      jsGlScissor(x, y, width, height) {
        ctx.scissor(x, y, width, height);
      },
      jsGlCheckFramebufferStatus(target) {
        return ctx.checkFramebufferStatus(target);
      },
      jsGlDeleteVertexArray(id) {
        ctx.deleteVertexArray(vertex_arrays.get(id));
      },
      jsGlDeleteBuffer(id) {
        const buf = buffers.get(id);
        buf && ctx.deleteBuffer(buf);
        buffers.delete(id);
      },
      jsGlVertexAttribDivisor(index, divisor) {
        ctx.vertexAttribDivisor(index, divisor);
      },
      jsGlFlush() {
        ctx.flush();
      },
      jsGlFinish() {
        ctx.finish();
      },
      jsGlBlendEquationSeparate(modeRGB, modeAlpha) {
        ctx.blendEquationSeparate(modeRGB, modeAlpha);
      },
      jsGlBlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha) {
        ctx.blendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
      },
      jsGlPixelStorei(pname, param) {
        ctx.pixelStorei(pname, !!param);
      },
      jsGlIsEnabled(target) {
        return ctx.isEnabled(target) ? 1 : 0;
      },
      glDisableVertexAttribArray(index) {
        ctx.disableVertexAttribArray(index);
      },
      glGetAttribLocation(program_id, name) {
        const program = ensureProgram(program_id);
        const attrib = getCString(wasm, name);
        return ctx.getAttribLocation(program, attrib);
      },
      glGetVertexAttribfv(index, pname, params) {
        emscriptenWebGLGetVertexAttrib(index, pname, params, 2);
      },
      glGetVertexAttribiv(index, pname, params) {
        emscriptenWebGLGetVertexAttrib(index, pname, params, 5);
      },
      glGetVertexAttribPointerv(index, pname, pointer_pointer) {
        emscriptenWebGLGetVertexAttrib(index, pname, pointer_pointer, 0);
      }
    };
  }

  // src/js/input.ts
  function initInputApi(canvas) {
    const textArea = document.createElement("textarea");
    let wasm = null;
    canvas.parentElement?.appendChild(textArea);
    const ImGuiMouseButton_Left = 0;
    const ImGuiMouseButton_Right = 1;
    const ImGuiMouseButton_Middle = 2;
    function getMousePos(canvas2, evt) {
      var rect = canvas2.getBoundingClientRect();
      return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top - 1
      };
    }
    function getImguiMouseButton(button) {
      switch (button) {
        case 0:
          return ImGuiMouseButton_Left;
        case 1:
          return ImGuiMouseButton_Middle;
        case 2:
          return ImGuiMouseButton_Right;
      }
      return -1;
    }
    function keyToImguiKey(key) {
      switch (key) {
        case "Tab":
          return 12 /* EngineKey_Tab */;
        case "ArrowLeft":
          return 13 /* EngineKey_LeftArrow */;
        case "ArrowRight":
          return 14 /* EngineKey_RightArrow */;
        case "ArrowUp":
          return 15 /* EngineKey_UpArrow */;
        case "ArrowDown":
          return 16 /* EngineKey_DownArrow */;
        case "PageUp":
          return 17 /* EngineKey_PageUp */;
        case "PageDown":
          return 18 /* EngineKey_PageDown */;
        case "Home":
          return 19 /* EngineKey_Home */;
        case "End":
          return 20 /* EngineKey_End */;
        case "Insert":
          return 21 /* EngineKey_Insert */;
        case "Delete":
          return 22 /* EngineKey_Delete */;
        case "Backspace":
          return 23 /* EngineKey_Backspace */;
        case "Space":
        case " ":
          return 24 /* EngineKey_Space */;
        case "Enter":
          return 25 /* EngineKey_Enter */;
        case "Escape":
          return 26 /* EngineKey_Escape */;
        case "Control":
        case "LeftCtrl":
          return 27 /* EngineKey_LeftCtrl */;
        case "Shift":
        case "LeftShift":
          return 28 /* EngineKey_LeftShift */;
        case "RightShift":
          return 32 /* EngineKey_RightShift */;
        case "Alt":
        case "LeftAlt":
          return 29 /* EngineKey_LeftAlt */;
        case "RightCtrl":
          return 31 /* EngineKey_RightCtrl */;
        case "RightAlt":
        case "AltGraph":
          return 33 /* EngineKey_RightAlt */;
        case "Meta":
        case "RightSuper":
        case "LeftSuper":
          return 30 /* EngineKey_LeftSuper */;
        case "Menu":
          return 35 /* EngineKey_Menu */;
        case "0":
          return 36 /* EngineKey_0 */;
        case "1":
          return 37 /* EngineKey_1 */;
        case "2":
          return 38 /* EngineKey_2 */;
        case "3":
          return 39 /* EngineKey_3 */;
        case "4":
          return 40 /* EngineKey_4 */;
        case "5":
          return 41 /* EngineKey_5 */;
        case "6":
          return 42 /* EngineKey_6 */;
        case "7":
          return 43 /* EngineKey_7 */;
        case "8":
          return 44 /* EngineKey_8 */;
        case "9":
          return 45 /* EngineKey_9 */;
        case "A":
        case "a":
          return 46 /* EngineKey_A */;
        case "B":
        case "b":
          return 47 /* EngineKey_B */;
        case "C":
        case "c":
          return 48 /* EngineKey_C */;
        case "D":
        case "d":
          return 49 /* EngineKey_D */;
        case "E":
        case "e":
          return 50 /* EngineKey_E */;
        case "F":
        case "f":
          return 51 /* EngineKey_F */;
        case "G":
        case "g":
          return 52 /* EngineKey_G */;
        case "H":
        case "h":
          return 53 /* EngineKey_H */;
        case "I":
        case "i":
          return 54 /* EngineKey_I */;
        case "J":
        case "j":
          return 55 /* EngineKey_J */;
        case "K":
        case "k":
          return 56 /* EngineKey_K */;
        case "L":
        case "l":
          return 57 /* EngineKey_L */;
        case "M":
        case "m":
          return 58 /* EngineKey_M */;
        case "N":
        case "n":
          return 59 /* EngineKey_N */;
        case "O":
        case "o":
          return 60 /* EngineKey_O */;
        case "P":
        case "p":
          return 61 /* EngineKey_P */;
        case "Q":
        case "q":
          return 62 /* EngineKey_Q */;
        case "R":
        case "r":
          return 63 /* EngineKey_R */;
        case "S":
        case "s":
          return 64 /* EngineKey_S */;
        case "T":
        case "t":
          return 65 /* EngineKey_T */;
        case "U":
        case "u":
          return 66 /* EngineKey_U */;
        case "V":
        case "v":
          return 67 /* EngineKey_V */;
        case "W":
        case "w":
          return 68 /* EngineKey_W */;
        case "X":
        case "x":
          return 69 /* EngineKey_X */;
        case "Y":
        case "y":
          return 70 /* EngineKey_Y */;
        case "Z":
        case "z":
          return 71 /* EngineKey_Z */;
        case "F1":
          return 72 /* EngineKey_F1 */;
        case "F2":
          return 73 /* EngineKey_F2 */;
        case "F3":
          return 74 /* EngineKey_F3 */;
        case "F4":
          return 75 /* EngineKey_F4 */;
        case "F5":
          return 76 /* EngineKey_F5 */;
        case "F6":
          return 77 /* EngineKey_F6 */;
        case "F7":
          return 78 /* EngineKey_F7 */;
        case "F8":
          return 79 /* EngineKey_F8 */;
        case "F9":
          return 80 /* EngineKey_F9 */;
        case "F10":
          return 81 /* EngineKey_F10 */;
        case "F11":
          return 82 /* EngineKey_F11 */;
        case "F12":
          return 83 /* EngineKey_F12 */;
        case "`":
          return 84 /* EngineKey_Apostrophe */;
        case ",":
          return 85 /* EngineKey_Comma */;
        case "-":
          return 86 /* EngineKey_Minus */;
        case ".":
          return 87 /* EngineKey_Period */;
        case "Slash":
        case "/":
          return 88 /* EngineKey_Slash */;
        case "Semicolon":
        case ";":
          return 89 /* EngineKey_Semicolon */;
        case "=":
          return 90 /* EngineKey_Equal */;
        case "LeftBracket":
        case "{":
          return 91 /* EngineKey_LeftBracket */;
        case "RightBracket":
        case "}":
          return 93 /* EngineKey_RightBracket */;
        case "Backslash":
        case "\\":
          return 92 /* EngineKey_Backslash */;
        case "GraveAccent":
        case "\xB4":
          return 94 /* EngineKey_GraveAccent */;
        case "CapsLock":
          return 95 /* EngineKey_CapsLock */;
        case "ScrollLock":
          return 96 /* EngineKey_ScrollLock */;
        case "NumLock":
          return 97 /* EngineKey_NumLock */;
        case "PrintScreen":
          return 98 /* EngineKey_PrintScreen */;
        case "Pause":
          return 99 /* EngineKey_Pause */;
        case "Keypad0":
          return 100 /* EngineKey_Keypad0 */;
        case "Keypad1":
          return 101 /* EngineKey_Keypad1 */;
        case "Keypad2":
          return 102 /* EngineKey_Keypad2 */;
        case "Keypad3":
          return 103 /* EngineKey_Keypad3 */;
        case "Keypad4":
          return 104 /* EngineKey_Keypad4 */;
        case "Keypad5":
          return 105 /* EngineKey_Keypad5 */;
        case "Keypad6":
          return 106 /* EngineKey_Keypad6 */;
        case "Keypad7":
          return 107 /* EngineKey_Keypad7 */;
        case "Keypad8":
          return 108 /* EngineKey_Keypad8 */;
        case "Keypad9":
          return 109 /* EngineKey_Keypad9 */;
        case "Period":
        case "Separator":
        case "Decimal":
        case "KeypadDecimal":
          return 110 /* EngineKey_KeypadDecimal */;
        case "KeypadDivide":
        case "Divide":
          return 111 /* EngineKey_KeypadDivide */;
        case "KeypadMultiply":
        case "Multiply":
          return 112 /* EngineKey_KeypadMultiply */;
        case "KeypadSubtract":
        case "Subtract":
          return 113 /* EngineKey_KeypadSubtract */;
        case "KeypadAdd":
        case "Add":
          return 114 /* EngineKey_KeypadAdd */;
        case "KeypadEnter":
          return 115 /* EngineKey_KeypadEnter */;
        case "Equal":
        case "KeypadEqual":
          return 116 /* EngineKey_KeypadEqual */;
        case "GamepadStart":
          return 117 /* EngineKey_GamepadStart */;
        case "GamepadBack":
          return 118 /* EngineKey_GamepadBack */;
        case "GamepadFaceLeft":
          return 119 /* EngineKey_GamepadFaceLeft */;
        case "GamepadFaceRight":
          return 120 /* EngineKey_GamepadFaceRight */;
        case "GamepadFaceUp":
          return 121 /* EngineKey_GamepadFaceUp */;
        case "GamepadFaceDown":
          return 122 /* EngineKey_GamepadFaceDown */;
        case "GamepadDpadLeft":
          return 123 /* EngineKey_GamepadDpadLeft */;
        case "GamepadDpadRight":
          return 124 /* EngineKey_GamepadDpadRight */;
        case "GamepadDpadUp":
          return 125 /* EngineKey_GamepadDpadUp */;
        case "GamepadDpadDown":
          return 126 /* EngineKey_GamepadDpadDown */;
        case "GamepadL1":
          return 127 /* EngineKey_GamepadL1 */;
        case "GamepadR1":
          return 128 /* EngineKey_GamepadR1 */;
        case "GamepadL2":
          return 129 /* EngineKey_GamepadL2 */;
        case "GamepadR2":
          return 130 /* EngineKey_GamepadR2 */;
        case "GamepadL3":
          return 131 /* EngineKey_GamepadL3 */;
        case "GamepadR3":
          return 132 /* EngineKey_GamepadR3 */;
        case "GamepadLStickLeft":
          return 133 /* EngineKey_GamepadLStickLeft */;
        case "GamepadLStickRight":
          return 134 /* EngineKey_GamepadLStickRight */;
        case "GamepadLStickUp":
          return 135 /* EngineKey_GamepadLStickUp */;
        case "GamepadLStickDown":
          return 136 /* EngineKey_GamepadLStickDown */;
        case "GamepadRStickLeft":
          return 137 /* EngineKey_GamepadRStickLeft */;
        case "GamepadRStickRight":
          return 138 /* EngineKey_GamepadRStickRight */;
        case "GamepadRStickUp":
          return 139 /* EngineKey_GamepadRStickUp */;
        case "GamepadRStickDown":
          return 140 /* EngineKey_GamepadRStickDown */;
        case "MouseLeft":
          return 141 /* EngineKey_MouseLeft */;
        case "MouseRight":
          return 142 /* EngineKey_MouseRight */;
        case "MouseMiddle":
          return 143 /* EngineKey_MouseMiddle */;
        case "MouseX1":
          return 144 /* EngineKey_MouseX1 */;
        case "MouseX2":
          return 145 /* EngineKey_MouseX2 */;
        case "MouseWheelX":
          return 146 /* EngineKey_MouseWheelX */;
        case "MouseWheelY":
          return 147 /* EngineKey_MouseWheelY */;
      }
      return 0;
    }
    function getModKey(e) {
      let mod = 0;
      if (e.shiftKey) {
        mod |= 8;
      }
      if (e.ctrlKey) {
        mod |= 4;
      }
      if (e.altKey) {
        mod |= 2;
      }
      if (e.metaKey) {
        mod |= 1;
      }
      return mod;
    }
    canvas.addEventListener("pointermove", (event) => {
      if (!wasm)
        return;
      const { x, y } = getMousePos(canvas, event);
      wasm.exports.mouseCallback(x, y);
    });
    canvas.addEventListener("pointerdown", (event) => {
      if (!wasm)
        return;
      const button = getImguiMouseButton(event.button);
      wasm.exports.mousebuttonCallback(button, 1);
    });
    canvas.addEventListener("pointerup", (event) => {
      if (!wasm)
        return;
      const button = getImguiMouseButton(event.button);
      wasm.exports.mousebuttonCallback(button, 0);
    });
    textArea.addEventListener("pointerup", (event) => {
      if (!wasm)
        return;
      const button = getImguiMouseButton(event.button);
      wasm.exports.mousebuttonCallback(button, 1);
    });
    canvas.addEventListener("contextmenu", (event) => {
      event.preventDefault();
    });
    canvas.addEventListener("wheel", (event) => {
      if (!wasm)
        return;
      let multiplier = 1;
      event.preventDefault();
      switch (event.deltaMode) {
        case 0:
          multiplier = 1 / 100;
          break;
        case 1:
          multiplier = 1 / 3;
          break;
        case 2:
          multiplier = 80;
          break;
        default:
          console.error("unrecognized mouse wheel delta mode: " + event.deltaMode);
      }
      wasm.exports.mouseWheelCallback(
        -multiplier * (event.deltaX == 0 ? 0 : event.deltaX > 0 ? Math.max(event.deltaX, 1) : Math.min(event.deltaX, -1)),
        -multiplier * (event.deltaY == 0 ? 0 : event.deltaY > 0 ? Math.max(event.deltaY, 1) : Math.min(event.deltaY, -1))
      );
    });
    function requestKeyFocus() {
      textArea.focus();
    }
    textArea.addEventListener("paste", function(e) {
      e.stopPropagation();
      e.preventDefault();
      const clipboardData = e.clipboardData;
      if (clipboardData) {
        const clipboard = clipboardData.getData("Text");
        debugger;
      }
    });
    textArea.addEventListener("blur", function(e) {
      requestKeyFocus();
    });
    textArea.addEventListener("input", function(e) {
      if (!wasm)
        return;
      textArea.value = "";
      if (e.data !== null && e.data !== void 0) {
        for (const char of e.data) {
          const utf16 = char.codePointAt(0);
          if (utf16 !== void 0) {
            wasm.exports.charCallback(utf16);
          }
        }
      }
    });
    textArea.addEventListener("keydown", function(e) {
      if (!wasm)
        return;
      wasm.exports.inputCallback(keyToImguiKey(e.key), 0, 1, getModKey(e));
      if (e.metaKey || e.ctrlKey || e.key == "Tab" || e.key == "Enter" || e.key == "Return") {
        e.preventDefault();
        return false;
      }
    });
    textArea.addEventListener("keyup", function(e) {
      if (!wasm)
        return;
      wasm.exports.inputCallback(keyToImguiKey(e.key), 0, 0, getModKey(e));
    });
    requestKeyFocus();
    return {
      inputTick(deltaTime) {
        if (!wasm)
          throw new Error("you must call inputApi.configure(wasm) before the inputTick");
        const ptr = wasm.exports.getGlobalInput();
        const memory = wasm.mmem.view;
        memory.setFloat32(ptr, deltaTime, true);
        return ptr;
      },
      configure(instance) {
        wasm = instance;
      }
    };
  }

  // src/js/stdx.ts
  function initStdxImports(wasm) {
    return {
      jsPanic(ptr, len) {
        const msg = getString(wasm, ptr, len);
        debugger;
        throw new Error(msg);
      },
      jsWarn(ptr, len) {
        console.warn(getString(wasm, ptr, len));
      },
      jsLog(ptr, len) {
        console.log(getString(wasm, ptr, len));
      },
      jsErr(ptr, len) {
        console.error(getString(wasm, ptr, len));
      }
    };
  }

  // src/js/index.ts
  function emptyManagedMemory() {
    const buffer = new ArrayBuffer(0);
    const _mmem = {
      buffer,
      view: new DataView(buffer),
      HEAP8: new Int8Array(buffer),
      HEAP16: new Int16Array(buffer),
      HEAP32: new Int32Array(buffer),
      HEAPU8: new Uint8Array(buffer),
      HEAPU16: new Uint16Array(buffer),
      HEAPU32: new Uint32Array(buffer),
      HEAPF32: new Float32Array(buffer),
      HEAPF64: new Float64Array(buffer)
    };
    return _mmem;
  }
  async function createImgui(canvas, webglContext) {
    const _mmem = emptyManagedMemory();
    const wasm = {
      imports: {},
      inputLen: 0,
      inputPtr: 0,
      inputCap: 0,
      get mmem() {
        const buf2 = wasm.exports.memory.buffer;
        if (_mmem.buffer === buf2)
          return _mmem;
        _mmem.view = new DataView(buf2);
        _mmem.HEAP8 = new Int8Array(buf2);
        _mmem.HEAP16 = new Int16Array(buf2);
        _mmem.HEAP32 = new Int32Array(buf2);
        _mmem.HEAPU8 = new Uint8Array(buf2);
        _mmem.HEAPU16 = new Uint16Array(buf2);
        _mmem.HEAPU32 = new Uint32Array(buf2);
        _mmem.HEAPF32 = new Float32Array(buf2);
        _mmem.HEAPF64 = new Float64Array(buf2);
        _mmem.buffer = buf2;
        console.log(`Resizing memory, now it is ${(buf2.byteLength / 1024 / 1024).toFixed(1)} MB`);
        return _mmem;
      }
    };
    wasm.imports.env = initEnvImports(wasm);
    wasm.imports.graphics = initGraphicsImports(wasm, canvas, webglContext);
    wasm.imports.stdx = initStdxImports(wasm);
    const wasmFile = "imgui-webgl.wasm";
    const resp = await fetch(wasmFile);
    const buf = await resp.arrayBuffer();
    const res = await WebAssembly.instantiate(buf, wasm.imports);
    wasm.exports = res.instance.exports;
    wasm.exports.onInit();
    wasm.exports.windowSizeChanged(canvas.width, canvas.height, devicePixelRatio);
    return wasm;
  }
  return __toCommonJS(js_exports);
})();
//# sourceMappingURL=index.js.map
