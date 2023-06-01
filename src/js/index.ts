import { initEnvImports } from "./env";
import { initGraphicsImports } from "./graphics";
import { initInputApi } from "./input";
import { initStdxImports } from "./stdx";
import { ImguiWasmInstance, ManagedMemory } from "./types";

export { initInputApi }

function emptyManagedMemory() {
  const buffer = new ArrayBuffer(0)

  const _mmem: ManagedMemory = {
    buffer,
    view: new DataView(buffer),
    HEAP8: new Int8Array(buffer),
    HEAP16: new Int16Array(buffer),
    HEAP32: new Int32Array(buffer),
    HEAPU8: new Uint8Array(buffer),
    HEAPU16: new Uint16Array(buffer),
    HEAPU32: new Uint32Array(buffer),
    HEAPF32: new Float32Array(buffer),
    HEAPF64: new Float64Array(buffer),
  }

  return _mmem
}

export async function createImgui(canvas: HTMLCanvasElement, webglContext: WebGL2RenderingContext): Promise<ImguiWasmInstance> {
  const _mmem: ManagedMemory = emptyManagedMemory()

  const wasm: ImguiWasmInstance = {
    imports: {},
    inputLen: 0,
    inputPtr: 0,
    inputCap: 0,
    get mmem() {
      const buf = wasm.exports.memory.buffer;
      if (_mmem.buffer === buf) return _mmem;
      _mmem.view = new DataView(buf);
      _mmem.HEAP8 = new Int8Array(buf);
      _mmem.HEAP16 = new Int16Array(buf);
      _mmem.HEAP32 = new Int32Array(buf);
      _mmem.HEAPU8 = new Uint8Array(buf);
      _mmem.HEAPU16 = new Uint16Array(buf);
      _mmem.HEAPU32 = new Uint32Array(buf);
      _mmem.HEAPF32 = new Float32Array(buf);
      _mmem.HEAPF64 = new Float64Array(buf)
      _mmem.buffer = buf;
      console.log(`Resizing memory, now it is ${(buf.byteLength / 1024 / 1024).toFixed(1)} MB`)
      return _mmem
    },
  } as any;

  wasm.imports.env = initEnvImports(wasm);
  wasm.imports.graphics = initGraphicsImports(wasm, canvas, webglContext);
  wasm.imports.stdx = initStdxImports(wasm);


  // Load wasm.
  const wasmFile = 'imgui-webgl.wasm';
  const resp = await fetch(wasmFile)
  const buf = await resp.arrayBuffer()
  const res = await WebAssembly.instantiate(buf, wasm.imports)
  wasm.exports = res.instance.exports as any;

  wasm.exports.onInit()
  wasm.exports.windowSizeChanged(canvas.width, canvas.height, devicePixelRatio);

  return wasm
}