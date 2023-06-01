import { getCString } from './common';
import { ImguiWasmImports } from './idl'
import { ImguiWasmInstance } from './types';

export function initEnvImports(wasm: ImguiWasmInstance): ImguiWasmImports["env"] {
  return {
    __assert_fail(expr, file, line, func) {
      const errorExpression = getCString(wasm, expr)
      const errorFile = getCString(wasm, file)
      const errorLine = line
      const errorFunction = getCString(wasm, func)
      try {
        throw new Error('asd')
      } catch (err: any) {
        err.stack = errorExpression + `\n    at ${errorFunction} (${errorFile}:${errorLine})` + err.stack.replace(/.+__assert_fail.+\n/m, '').replace(/Error: asd/, '')
        console.error(err)
        debugger
        throw err
      }
    },
    __stack_chk_fail() {
      debugger
      console.log('__stack_chk_fail')
    },
    acosf(x) {
      return Math.acos(x)
    },
    atan2f(x, y) {
      return Math.atan2(x, y)
    },
    powf(x, y) {
      return Math.pow(x, y)
    },
    toupper(char) {
      return String.fromCharCode(char).toUpperCase().charCodeAt(0)
    },
    printf(a, b) {
      debugger
      return 0
    },
    sscanf(a, b) {
      debugger
      return 0
    },
    fflush(a) {
      debugger
      return 0
    }
  }
}