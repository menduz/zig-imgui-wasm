import { getString } from "./common";
import { ImguiWasmImports } from "./idl";
import { ImguiWasmInstance } from "./types";

export function initStdxImports(wasm: ImguiWasmInstance): ImguiWasmImports["stdx"] {
  return {
    jsPanic(ptr, len) {
      const msg = getString(wasm, ptr, len)
      debugger
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
    },
  }
}