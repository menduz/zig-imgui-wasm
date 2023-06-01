import { ImguiWasmInstance } from "./types";

export function initInputApi(canvas: HTMLCanvasElement): {
  inputTick(deltaTime: number): number,
  configure(instance: ImguiWasmInstance): void
} {
  const textArea = document.createElement('textarea')

  let wasm: ImguiWasmInstance | null = null

  canvas.parentElement?.appendChild(textArea)

  const ImGuiMouseButton_Left = 0
  const ImGuiMouseButton_Right = 1
  const ImGuiMouseButton_Middle = 2

  function getMousePos(canvas: HTMLCanvasElement, evt: PointerEvent) {
    var rect = canvas.getBoundingClientRect();

    return {
      x: evt.clientX - rect.left,
      y: evt.clientY - rect.top - 1
    };
  }

  function getImguiMouseButton(button: number) {
    switch (button) {
      case 0: return ImGuiMouseButton_Left
      case 1: return ImGuiMouseButton_Middle
      case 2: return ImGuiMouseButton_Right
    }
    return -1
  }

  function keyToImguiKey(key: string) {
    switch (key) {
      case "Tab": return EngineKey.EngineKey_Tab
      case "ArrowLeft": return EngineKey.EngineKey_LeftArrow
      case "ArrowRight": return EngineKey.EngineKey_RightArrow
      case "ArrowUp": return EngineKey.EngineKey_UpArrow
      case "ArrowDown": return EngineKey.EngineKey_DownArrow
      case "PageUp": return EngineKey.EngineKey_PageUp
      case "PageDown": return EngineKey.EngineKey_PageDown
      case "Home": return EngineKey.EngineKey_Home
      case "End": return EngineKey.EngineKey_End
      case "Insert": return EngineKey.EngineKey_Insert
      case "Delete": return EngineKey.EngineKey_Delete
      case "Backspace": return EngineKey.EngineKey_Backspace

      case "Space":
      case " ":
        return EngineKey.EngineKey_Space

      case "Enter": return EngineKey.EngineKey_Enter

      case "Escape": return EngineKey.EngineKey_Escape

      case "Control":
      case "LeftCtrl":
        return EngineKey.EngineKey_LeftCtrl

      case "Shift":
      case "LeftShift":
        return EngineKey.EngineKey_LeftShift
      case "RightShift":
        return EngineKey.EngineKey_RightShift

      case "Alt":
      case "LeftAlt": return EngineKey.EngineKey_LeftAlt
      case "RightCtrl": return EngineKey.EngineKey_RightCtrl

      case "RightAlt":
      case "AltGraph":
        return EngineKey.EngineKey_RightAlt

      case "Meta":
      case "RightSuper":
      case "LeftSuper":
        return EngineKey.EngineKey_LeftSuper

      case "Menu": return EngineKey.EngineKey_Menu
      case "0": return EngineKey.EngineKey_0
      case "1": return EngineKey.EngineKey_1
      case "2": return EngineKey.EngineKey_2
      case "3": return EngineKey.EngineKey_3
      case "4": return EngineKey.EngineKey_4
      case "5": return EngineKey.EngineKey_5
      case "6": return EngineKey.EngineKey_6
      case "7": return EngineKey.EngineKey_7
      case "8": return EngineKey.EngineKey_8
      case "9": return EngineKey.EngineKey_9
      case "A":
      case "a":
        return EngineKey.EngineKey_A
      case "B":
      case "b":
        return EngineKey.EngineKey_B
      case "C":
      case "c":
        return EngineKey.EngineKey_C
      case "D":
      case "d":
        return EngineKey.EngineKey_D
      case "E":
      case "e":
        return EngineKey.EngineKey_E
      case "F":
      case "f":
        return EngineKey.EngineKey_F
      case "G":
      case "g":
        return EngineKey.EngineKey_G
      case "H":
      case "h":
        return EngineKey.EngineKey_H
      case "I":
      case "i":
        return EngineKey.EngineKey_I
      case "J":
      case "j":
        return EngineKey.EngineKey_J
      case "K":
      case "k":
        return EngineKey.EngineKey_K
      case "L":
      case "l":
        return EngineKey.EngineKey_L
      case "M":
      case "m":
        return EngineKey.EngineKey_M
      case "N":
      case "n":
        return EngineKey.EngineKey_N
      case "O":
      case "o":
        return EngineKey.EngineKey_O
      case "P":
      case "p":
        return EngineKey.EngineKey_P
      case "Q":
      case "q":
        return EngineKey.EngineKey_Q
      case "R":
      case "r":
        return EngineKey.EngineKey_R
      case "S":
      case "s":
        return EngineKey.EngineKey_S
      case "T":
      case "t":
        return EngineKey.EngineKey_T
      case "U":
      case "u":
        return EngineKey.EngineKey_U
      case "V":
      case "v":
        return EngineKey.EngineKey_V
      case "W":
      case "w":
        return EngineKey.EngineKey_W
      case "X":
      case "x":
        return EngineKey.EngineKey_X
      case "Y":
      case "y":
        return EngineKey.EngineKey_Y
      case "Z":
      case "z":
        return EngineKey.EngineKey_Z
      case "F1": return EngineKey.EngineKey_F1
      case "F2": return EngineKey.EngineKey_F2
      case "F3": return EngineKey.EngineKey_F3
      case "F4": return EngineKey.EngineKey_F4
      case "F5": return EngineKey.EngineKey_F5
      case "F6": return EngineKey.EngineKey_F6
      case "F7": return EngineKey.EngineKey_F7
      case "F8": return EngineKey.EngineKey_F8
      case "F9": return EngineKey.EngineKey_F9
      case "F10": return EngineKey.EngineKey_F10
      case "F11": return EngineKey.EngineKey_F11
      case "F12": return EngineKey.EngineKey_F12
      case "`": return EngineKey.EngineKey_Apostrophe
      case ",": return EngineKey.EngineKey_Comma
      case "-":
        return EngineKey.EngineKey_Minus
      case ".":
        return EngineKey.EngineKey_Period
      case "Slash":
      case "/":
        return EngineKey.EngineKey_Slash
      case "Semicolon":
      case ";":
        return EngineKey.EngineKey_Semicolon
      case "=":
        return EngineKey.EngineKey_Equal
      case "LeftBracket":
      case "{":
        return EngineKey.EngineKey_LeftBracket
      case "RightBracket":
      case "}":
        return EngineKey.EngineKey_RightBracket
      case "Backslash":
      case "\\":
        return EngineKey.EngineKey_Backslash
      case "GraveAccent":
      case "´":
        return EngineKey.EngineKey_GraveAccent
      case "CapsLock": return EngineKey.EngineKey_CapsLock
      case "ScrollLock": return EngineKey.EngineKey_ScrollLock
      case "NumLock": return EngineKey.EngineKey_NumLock
      case "PrintScreen": return EngineKey.EngineKey_PrintScreen
      case "Pause": return EngineKey.EngineKey_Pause
      case "Keypad0":
        return EngineKey.EngineKey_Keypad0
      case "Keypad1":
        return EngineKey.EngineKey_Keypad1
      case "Keypad2":
        return EngineKey.EngineKey_Keypad2
      case "Keypad3":
        return EngineKey.EngineKey_Keypad3
      case "Keypad4":
        return EngineKey.EngineKey_Keypad4
      case "Keypad5":
        return EngineKey.EngineKey_Keypad5
      case "Keypad6":
        return EngineKey.EngineKey_Keypad6
      case "Keypad7":
        return EngineKey.EngineKey_Keypad7
      case "Keypad8":
        return EngineKey.EngineKey_Keypad8
      case "Keypad9":
        return EngineKey.EngineKey_Keypad9
      case "Period":
      case "Separator":
      case "Decimal":
      case "KeypadDecimal":
        return EngineKey.EngineKey_KeypadDecimal
      case "KeypadDivide":
      case "Divide":
        return EngineKey.EngineKey_KeypadDivide

      case "KeypadMultiply":
      case "Multiply":
        return EngineKey.EngineKey_KeypadMultiply

      case "KeypadSubtract":
      case "Subtract":
        return EngineKey.EngineKey_KeypadSubtract

      case "KeypadAdd":
      case "Add":
        return EngineKey.EngineKey_KeypadAdd
      case "KeypadEnter":
        return EngineKey.EngineKey_KeypadEnter

      case "Equal":
      case "KeypadEqual":
        return EngineKey.EngineKey_KeypadEqual

      case "GamepadStart": return EngineKey.EngineKey_GamepadStart
      case "GamepadBack": return EngineKey.EngineKey_GamepadBack
      case "GamepadFaceLeft": return EngineKey.EngineKey_GamepadFaceLeft
      case "GamepadFaceRight": return EngineKey.EngineKey_GamepadFaceRight
      case "GamepadFaceUp": return EngineKey.EngineKey_GamepadFaceUp
      case "GamepadFaceDown": return EngineKey.EngineKey_GamepadFaceDown
      case "GamepadDpadLeft": return EngineKey.EngineKey_GamepadDpadLeft
      case "GamepadDpadRight": return EngineKey.EngineKey_GamepadDpadRight
      case "GamepadDpadUp": return EngineKey.EngineKey_GamepadDpadUp
      case "GamepadDpadDown": return EngineKey.EngineKey_GamepadDpadDown
      case "GamepadL1": return EngineKey.EngineKey_GamepadL1
      case "GamepadR1": return EngineKey.EngineKey_GamepadR1
      case "GamepadL2": return EngineKey.EngineKey_GamepadL2
      case "GamepadR2": return EngineKey.EngineKey_GamepadR2
      case "GamepadL3": return EngineKey.EngineKey_GamepadL3
      case "GamepadR3": return EngineKey.EngineKey_GamepadR3
      case "GamepadLStickLeft": return EngineKey.EngineKey_GamepadLStickLeft
      case "GamepadLStickRight": return EngineKey.EngineKey_GamepadLStickRight
      case "GamepadLStickUp": return EngineKey.EngineKey_GamepadLStickUp
      case "GamepadLStickDown": return EngineKey.EngineKey_GamepadLStickDown
      case "GamepadRStickLeft": return EngineKey.EngineKey_GamepadRStickLeft
      case "GamepadRStickRight": return EngineKey.EngineKey_GamepadRStickRight
      case "GamepadRStickUp": return EngineKey.EngineKey_GamepadRStickUp
      case "GamepadRStickDown": return EngineKey.EngineKey_GamepadRStickDown

      case "MouseLeft": return EngineKey.EngineKey_MouseLeft
      case "MouseRight": return EngineKey.EngineKey_MouseRight
      case "MouseMiddle": return EngineKey.EngineKey_MouseMiddle
      case "MouseX1": return EngineKey.EngineKey_MouseX1
      case "MouseX2": return EngineKey.EngineKey_MouseX2
      case "MouseWheelX": return EngineKey.EngineKey_MouseWheelX
      case "MouseWheelY": return EngineKey.EngineKey_MouseWheelY
    }
    return 0
  }

  function getModKey(e: KeyboardEvent) {
    let mod = 0
    if (e.shiftKey) {
      mod |= 8
    }
    if (e.ctrlKey) {
      mod |= 4
    }
    if (e.altKey) {
      mod |= 2
    }
    if (e.metaKey) {
      mod |= 1
    }
    return mod
  }

  canvas.addEventListener("pointermove", (event) => {
    if (!wasm) return
    const { x, y } = getMousePos(canvas, event)
    wasm.exports.mouseCallback(x, y)
  });

  canvas.addEventListener("pointerdown", (event) => {
    if (!wasm) return
    const button = getImguiMouseButton(event.button)
    wasm.exports.mousebuttonCallback(button, 1)
  });
  
  canvas.addEventListener("pointerup", (event) => {
    if (!wasm) return
    const button = getImguiMouseButton(event.button)
    wasm.exports.mousebuttonCallback(button, 0)
  });

  textArea.addEventListener("pointerup", (event) => {
    if (!wasm) return
    const button = getImguiMouseButton(event.button)
    wasm.exports.mousebuttonCallback(button, 1)
  });

  canvas.addEventListener('contextmenu', (event) => {
    event.preventDefault()
    // mouse_right = true;
  })

  canvas.addEventListener("wheel", (event) => {
    if (!wasm) return

    let multiplier = 1

    event.preventDefault()

    switch (event.deltaMode) {
      case 0:
        // DOM_DELTA_PIXEL: 100 pixels make up a step
        multiplier = 1 / 100;
        break;
      case 1:
        // DOM_DELTA_LINE: 3 lines make up a step
        multiplier = 1 / 3;
        break;
      case 2:
        // DOM_DELTA_PAGE: A page makes up 80 steps
        multiplier = 80;
        break;
      default:
        console.error('unrecognized mouse wheel delta mode: ' + event.deltaMode);
    }

    wasm.exports.mouseWheelCallback(

      -multiplier * ((event.deltaX == 0) ? 0 : (event.deltaX > 0 ? Math.max(event.deltaX, 1) : Math.min(event.deltaX, -1))),
      -multiplier * ((event.deltaY == 0) ? 0 : (event.deltaY > 0 ? Math.max(event.deltaY, 1) : Math.min(event.deltaY, -1)))
    );
  });

  // window.addEventListener('resize', function () {
  //   resize(window.innerWidth, window.innerHeight)
  // })
  // // Initially resize to the window size.
  // resize(window.innerWidth, window.innerHeight)

  function requestKeyFocus() {
    textArea.focus()
  }
  textArea.addEventListener('paste', function (e) {
    e.stopPropagation()
    e.preventDefault()
    const clipboardData = e.clipboardData
    if (clipboardData) {
      const clipboard = clipboardData.getData('Text')
      debugger
      // // For now submit event directly to wasm since it has dynamic payload.
      // const ptr = ensureJsCapacity(clipboard.length * 3)
      // const buf = new Uint8Array(wasm.exports.memory.buffer, ptr, wasm.jsCap)
      // const len = textEncoder.encodeInto(clipboard, buf).written
      // wasm.exports.wasmEmitPasteEvent(ptr, len);
    }
  })
  textArea.addEventListener('blur', function (e) {
    requestKeyFocus()
  })
  textArea.addEventListener('input', function (e: InputEvent) {
    if (!wasm) return
    textArea.value = ''
    if (e.data !== null && e.data !== undefined) {
      for (const char of e.data) {
        const utf16 = char.codePointAt(0)
        if (utf16 !== undefined) {
          wasm.exports.charCallback(utf16)
        }
      }
    }
  } as any)

  textArea.addEventListener('keydown', function (e) {
    if (!wasm) return
    wasm.exports.inputCallback(keyToImguiKey(e.key), 0, 1, getModKey(e))
    // Need to prevent some browser default shortcuts. eg. Ctrl+S would bring up a save page dialog.
    if (e.metaKey || e.ctrlKey || e.key == 'Tab' || e.key == 'Enter' || e.key == 'Return') {
      e.preventDefault()
      return false
    }
  });

  textArea.addEventListener('keyup', function (e) {
    if (!wasm) return
    wasm.exports.inputCallback(keyToImguiKey(e.key), 0, 0, getModKey(e))
  })

  requestKeyFocus()

  return {
    inputTick(deltaTime: number) {
      if (!wasm) throw new Error('you must call inputApi.configure(wasm) before the inputTick')
      const ptr = wasm.exports.getGlobalInput();
      const memory = wasm.mmem.view
      memory.setFloat32(ptr, deltaTime, true); // delta time

      return ptr
    },
    configure(instance) {
      wasm = instance
    },
  }
}

enum EngineKey {
  EngineKey_Tab = 12,
  EngineKey_LeftArrow = 13,
  EngineKey_RightArrow = 14,
  EngineKey_UpArrow = 15,
  EngineKey_DownArrow = 16,
  EngineKey_PageUp = 17,
  EngineKey_PageDown = 18,
  EngineKey_Home = 19,
  EngineKey_End = 20,
  EngineKey_Insert = 21,
  EngineKey_Delete = 22,
  EngineKey_Backspace = 23,
  EngineKey_Space = 24,
  EngineKey_Enter = 25,
  EngineKey_Escape = 26,
  EngineKey_LeftCtrl = 27,
  EngineKey_LeftShift = 28,
  EngineKey_LeftAlt = 29,
  EngineKey_LeftSuper = 30,
  EngineKey_RightCtrl = 31,
  EngineKey_RightShift = 32,
  EngineKey_RightAlt = 33,
  EngineKey_RightSuper = 34,
  EngineKey_Menu = 35,
  EngineKey_0 = 36,
  EngineKey_1 = 37,
  EngineKey_2 = 38,
  EngineKey_3 = 39,
  EngineKey_4 = 40,
  EngineKey_5 = 41,
  EngineKey_6 = 42,
  EngineKey_7 = 43,
  EngineKey_8 = 44,
  EngineKey_9 = 45,
  EngineKey_A = 46,
  EngineKey_B = 47,
  EngineKey_C = 48,
  EngineKey_D = 49,
  EngineKey_E = 50,
  EngineKey_F = 51,
  EngineKey_G = 52,
  EngineKey_H = 53,
  EngineKey_I = 54,
  EngineKey_J = 55,
  EngineKey_K = 56,
  EngineKey_L = 57,
  EngineKey_M = 58,
  EngineKey_N = 59,
  EngineKey_O = 60,
  EngineKey_P = 61,
  EngineKey_Q = 62,
  EngineKey_R = 63,
  EngineKey_S = 64,
  EngineKey_T = 65,
  EngineKey_U = 66,
  EngineKey_V = 67,
  EngineKey_W = 68,
  EngineKey_X = 69,
  EngineKey_Y = 70,
  EngineKey_Z = 71,
  EngineKey_F1 = 72,
  EngineKey_F2 = 73,
  EngineKey_F3 = 74,
  EngineKey_F4 = 75,
  EngineKey_F5 = 76,
  EngineKey_F6 = 77,
  EngineKey_F7 = 78,
  EngineKey_F8 = 79,
  EngineKey_F9 = 80,
  EngineKey_F10 = 81,
  EngineKey_F11 = 82,
  EngineKey_F12 = 83,
  EngineKey_Apostrophe = 84,
  EngineKey_Comma = 85,
  EngineKey_Minus = 86,
  EngineKey_Period = 87,
  EngineKey_Slash = 88,
  EngineKey_Semicolon = 89,
  EngineKey_Equal = 90,
  EngineKey_LeftBracket = 91,
  EngineKey_Backslash = 92,
  EngineKey_RightBracket = 93,
  EngineKey_GraveAccent = 94,
  EngineKey_CapsLock = 95,
  EngineKey_ScrollLock = 96,
  EngineKey_NumLock = 97,
  EngineKey_PrintScreen = 98,
  EngineKey_Pause = 99,
  EngineKey_Keypad0 = 100,
  EngineKey_Keypad1 = 101,
  EngineKey_Keypad2 = 102,
  EngineKey_Keypad3 = 103,
  EngineKey_Keypad4 = 104,
  EngineKey_Keypad5 = 105,
  EngineKey_Keypad6 = 106,
  EngineKey_Keypad7 = 107,
  EngineKey_Keypad8 = 108,
  EngineKey_Keypad9 = 109,
  EngineKey_KeypadDecimal = 110,
  EngineKey_KeypadDivide = 111,
  EngineKey_KeypadMultiply = 112,
  EngineKey_KeypadSubtract = 113,
  EngineKey_KeypadAdd = 114,
  EngineKey_KeypadEnter = 115,
  EngineKey_KeypadEqual = 116,
  EngineKey_GamepadStart = 117,
  EngineKey_GamepadBack = 118,
  EngineKey_GamepadFaceLeft = 119,
  EngineKey_GamepadFaceRight = 120,
  EngineKey_GamepadFaceUp = 121,
  EngineKey_GamepadFaceDown = 122,
  EngineKey_GamepadDpadLeft = 123,
  EngineKey_GamepadDpadRight = 124,
  EngineKey_GamepadDpadUp = 125,
  EngineKey_GamepadDpadDown = 126,
  EngineKey_GamepadL1 = 127,
  EngineKey_GamepadR1 = 128,
  EngineKey_GamepadL2 = 129,
  EngineKey_GamepadR2 = 130,
  EngineKey_GamepadL3 = 131,
  EngineKey_GamepadR3 = 132,
  EngineKey_GamepadLStickLeft = 133,
  EngineKey_GamepadLStickRight = 134,
  EngineKey_GamepadLStickUp = 135,
  EngineKey_GamepadLStickDown = 136,
  EngineKey_GamepadRStickLeft = 137,
  EngineKey_GamepadRStickRight = 138,
  EngineKey_GamepadRStickUp = 139,
  EngineKey_GamepadRStickDown = 140,
  EngineKey_MouseLeft = 141,
  EngineKey_MouseRight = 142,
  EngineKey_MouseMiddle = 143,
  EngineKey_MouseX1 = 144,
  EngineKey_MouseX2 = 145,
  EngineKey_MouseWheelX = 146,
  EngineKey_MouseWheelY = 147,
}