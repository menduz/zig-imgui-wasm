import { ImguiWasmImports } from "./idl"

export interface ImguiWasmExports extends WebAssembly.Exports {
  memory: WebAssembly.Memory
  render(inputPtr: number): void
  onInit(): void
  getGlobalInput(): number
  windowSizeChanged(newWidth: number, newHeight: number, aspectRatio: number): void
  inputCallback(key: number, scan: number, action: number, mods: number): void
  mouseWheelCallback(x: number, y: number): void
  mouseCallback(x: number, y: number): void
  mousebuttonCallback(key: number, action: number): void
  cursorCallback(x: number, y: number): void
  charCallback(char: number): void
}

export interface ImguiWasmInstance {
  mmem: ManagedMemory
  exports: ImguiWasmExports
  imports: ImguiWasmImports

  inputPtr: number
  inputCap: number
  inputLen: number
}

export type ManagedMemory = {
  buffer: ArrayBuffer
  view: DataView
  HEAP8: Int8Array
  HEAP16: Int16Array
  HEAP32: Int32Array
  HEAPU8: Uint8Array
  HEAPU16: Uint16Array
  HEAPU32: Uint32Array
  HEAPF32: Float32Array
  HEAPF64: Float64Array
}