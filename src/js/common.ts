import { ImguiWasmInstance } from "./types";

const textDecoder = new TextDecoder()
const textEncoder = new TextEncoder()

export function getString(wasm: ImguiWasmInstance, ptr: number, len: number) {
  return textDecoder.decode(wasm.exports.memory.buffer.slice(ptr, ptr + len));
}

export function getCString(wasm: ImguiWasmInstance, ptr: number) {
  const view = new Uint8Array(wasm.exports.memory.buffer.slice(ptr))
  let count = 0
  while (view[count] !== 0)
    count++
  return textDecoder.decode(wasm.exports.memory.buffer.slice(ptr, ptr + count));
}