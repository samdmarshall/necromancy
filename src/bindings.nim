# =======
# Imports
# =======

import posix
import tables
import sequtils

import "termbox.nim"

# =========
# Constants
# =========

## Key names
const
  Key_F1 = "<F1>"
  Key_F2 = "<F2>"
  Key_F3 = "<F3>"
  Key_F4 = "<F4>"
  Key_F5 = "<F5>"
  Key_F6 = "<F6>"
  Key_F7 = "<F7>"
  Key_F8 = "<F8>"
  Key_F9 = "<F9>"
  Key_F10 = "<F10>"
  Key_F11 = "<F11>"
  Key_F12 = "<F12>"

  Key_Up = "<up>"
  Key_Down = "<down>"
  Key_Left = "<left>"
  Key_Right = "<right>"

  Key_MouseWheelUp = "<scroll-up>"
  Key_MouseWheelDown = "<scroll-down>"

  Key_CtrlTilde = "<ctrl-~>"
  Key_Backspace = "<backspace>"
  Key_Tab = "<tab>"
  Key_Enter = "<enter>"
  Key_Esc = "<esc>"
  Key_CtrlLeftBracket = "<ctrl-[>"
  Key_CtrlRightBracket = "<ctrl-]>"
  Key_CtrlBackslash = "<ctrl-\\>"
  Key_CtrlSlash = "<ctrl-/>"
  Key_CtrlUnderscore = "<ctrl-_>"
  Key_Space = "<space>"
  Key_Delete = "<delete>"
  
  Key_Ctrl2 = "<ctrl-2>"
  Key_Ctrl3 = "<ctrl-3>"
  Key_Ctrl4 = "<ctrl-4>"
  Key_Ctrl5 = "<ctrl-5>"
  Key_Ctrl6 = "<ctrl-6>"
  Key_Ctrl7 = "<ctrl-7>"
  Key_Ctrl8 = "<ctrl-8>"
  
  Key_CtrlA = "<ctrl-a>"
  Key_CtrlB = "<ctrl-b>"
  Key_CtrlC = "<ctrl-c>"
  Key_CtrlD = "<ctrl-d>"
  Key_CtrlE = "<ctrl-e>"
  Key_CtrlF = "<ctrl-f>"
  Key_CtrlG = "<ctrl-g>"
  Key_CtrlH = "<ctrl-h>"
  Key_CtrlI = "<ctrl-i>"
  Key_CtrlJ = "<ctrl-j>"
  Key_CtrlK = "<ctrl-k>"
  Key_CtrlL = "<ctrl-l>"
  Key_CtrlM = "<ctrl-m>"
  Key_CtrlN = "<ctrl-n>"
  Key_CtrlO = "<ctrl-o>"
  Key_CtrlP = "<ctrl-p>"
  Key_CtrlQ = "<ctrl-q>"
  Key_CtrlR = "<ctrl-r>"
  Key_CtrlS = "<ctrl-s>"
  Key_CtrlT = "<ctrl-t>"
  Key_CtrlU = "<ctrl-u>"
  Key_CtrlV = "<ctrl-v>"
  Key_CtrlW = "<ctrl-w>"
  Key_CtrlX = "<ctrl-x>"
  Key_CtrlY = "<ctrl-y>"
  Key_CtrlZ = "<ctrl-z>"
  

# =======
# Globals
# =======

const BindingMap: Table[uint16, string] = {
  TB_KEY_F1: Key_F1,
  TB_KEY_F2: Key_F2,
  TB_KEY_F3: Key_F3,
  TB_KEY_F4: Key_F4,
  TB_KEY_F5: Key_F5,
  TB_KEY_F6: Key_F6,
  TB_KEY_F7: Key_F7,
  TB_KEY_F8: Key_F8,
  TB_KEY_F9: Key_F9,
  TB_KEY_F10: Key_F10,
  TB_KEY_F11: Key_F11,
  TB_Key_F12: Key_F12,

  TB_KEY_ARROW_UP: KeyUp,
  TB_KEY_ARROW_DOWN: Key_Down,
  TB_KEY_ARROW_LEFT: Key_Left,
  TB_KEY_ARROW_RIGHT: Key_Right,

  TB_KEY_MOUSE_WHEEL_UP: Key_MouseWheelUp,
  TB_KEY_MOUSE_WHEEL_DOWN: Key_MouseWheelDown,

  TB_KEY_CTRL_TILDE: Key_CtrlTilde,
  TB_KEY_CTRL_2: Key_Ctrl2, 
  TB_KEY_CTRL_A: Key_CtrlA,
  TB_KEY_CTRL_B: Key_CtrlB,
  TB_KEY_CTRL_C: Key_CtrlC,
  TB_KEY_CTRL_D: Key_CtrlD,
  TB_KEY_CTRL_E: Key_CtrlE,
  TB_KEY_CTRL_F: Key_CtrlF,
  TB_KEY_CTRL_G: Key_CtrlG,
  TB_KEY_BACKSPACE: Key_Backspace,
  TB_KEY_CTRL_H: Key_CtrlH,
  TB_KEY_TAB: Key_Tab,
  TB_KEY_CTRL_I: Key_CtrlI,
  TB_KEY_CTRL_J: Key_CtrlJ,
  TB_KEY_CTRL_K: Key_CtrlK,
  TB_KEY_CTRL_L: Key_CtrlL,
  TB_KEY_ENTER: Key_Enter,
  TB_KEY_CTRL_M: Key_CtrlM,
  TB_KEY_CTRL_N: Key_CtrlN,
  TB_KEY_CTRL_O: Key_CtrlO,
  TB_KEY_CTRL_P: Key_CtrlP,
  TB_KEY_CTRL_Q: Key_CtrlQ,
  TB_KEY_CTRL_R: Key_CtrlR,
  TB_KEY_CTRL_S: Key_CtrlS,
  TB_KEY_CTRL_T: Key_CtrlT,
  TB_KEY_CTRL_U: Key_CtrlU,
  TB_KEY_CTRL_V: Key_CtrlV,
  TB_KEY_CTRL_W: Key_CtrlW,
  TB_KEY_CTRL_X: Key_CtrlX,
  TB_KEY_CTRL_Y: Key_CtrlY,
  TB_KEY_CTRL_Z: Key_CtrlZ,
  TB_KEY_ESC: Key_Esc,
  TB_KEY_CTRL_LSQ_BRACKET: Key_CtrlLeftBracket,
  TB_KEY_CTRL_3: Key_Ctrl3,
  TB_KEY_CTRL_4: Key_Ctrl4,
  TB_KEY_CTRL_BACKSLASH: Key_CtrlBackslash,
  TB_KEY_CTRL_5: Key_Ctrl5,
  TB_KEY_CTRL_RSQ_BRACKET: Key_CtrlRightBracket,
  TB_KEY_CTRL_6: Key_Ctrl6,
  TB_KEY_CTRL_7: Key_Ctrl7,
  TB_KEY_CTRL_SLASH: Key_CtrlSlash,
  TB_KEY_CTRL_UNDERSCORE: Key_CtrlUnderscore,
  TB_KEY_SPACE: Key_Space,
  TB_KEY_BACKSPACE2: Key_Delete,
  TB_KEY_CTRL_8: Key_Ctrl8,
  
}.toTable

const AsciiBindingMap: Table[uint32, string] = {
  uint32(33): "!",
  uint32(34): "\"",
  uint32(35): "#",
  uint32(36): "$",
  uint32(37): "%",
  uint32(38): "&",
  uint32(39): "'",
  uint32(40): "(",
  uint32(41): ")",
  uint32(42): "*",
  uint32(43): "+",
  uint32(44): ",",
  uint32(45): "-",
  uint32(46): ".",
  uint32(47): "/",
  uint32(48): "0",
  uint32(49): "1",
  uint32(50): "2",
  uint32(51): "3",
  uint32(52): "4",
  uint32(53): "5",
  uint32(54): "6",
  uint32(55): "7",
  uint32(56): "8",
  uint32(57): "9",
  uint32(58): ":",
  uint32(59): ";",
  uint32(60): "<",
  uint32(61): "=",
  uint32(62): ">",
  uint32(63): "?",
  uint32(64): "@",
  uint32(65): "A",
  uint32(66): "B",
  uint32(67): "C",
  uint32(68): "D",
  uint32(69): "E",
  uint32(70): "F",
  uint32(71): "G",
  uint32(72): "H",
  uint32(73): "I",
  uint32(74): "J",
  uint32(75): "K",
  uint32(76): "L",
  uint32(77): "M",
  uint32(78): "N",
  uint32(79): "O",
  uint32(80): "P",
  uint32(81): "Q",
  uint32(82): "R",
  uint32(83): "S",
  uint32(84): "T",
  uint32(85): "U",
  uint32(86): "V",
  uint32(87): "W",
  uint32(88): "X",
  uint32(89): "Y",
  uint32(90): "Z",
  uint32(91): "[",
  uint32(92): "\\",
  uint32(93): "]",
  uint32(94): "^",
  uint32(95): "_",
  uint32(96): "`",
  uint32(97): "a",
  uint32(98): "b",
  uint32(99): "c",
  uint32(100): "d",
  uint32(101): "e",
  uint32(102): "f",
  uint32(103): "g",
  uint32(104): "h",
  uint32(105): "i",
  uint32(106): "j",
  uint32(107): "k",
  uint32(108): "l",
  uint32(109): "m",
  uint32(110): "n",
  uint32(111): "o",
  uint32(112): "p",
  uint32(113): "q",
  uint32(114): "r",
  uint32(115): "s",
  uint32(116): "t",
  uint32(117): "u",
  uint32(118): "v",
  uint32(119): "w",
  uint32(120): "x",
  uint32(121): "y",
  uint32(122): "z",
  uint32(123): "{",
  uint32(124): "|",
  uint32(125): "}",
}.toTable

# =========
# Functions
# =========

proc translate*(input: tb_event): string = 
  if input.ch in AsciiBindingMap:
    return AsciiBindingMap[input.ch]
  elif input.key in BindingMap:
    return BindingMap[input.key]
  return ""

