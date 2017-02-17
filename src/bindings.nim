# =======
# Imports
# =======

import posix
import tables
import sequtils

import "types.nim"
import "logger.nim"
import "actions.nim"
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

  Key_Space = "<space>"

  Key_CtrlQ = "<ctrl-q>"
  Key_CtrlZ = "<ctrl-z>"

# =======
# Globals
# =======

let BindingMap: Table[uint16, string] = {
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

  TB_KEY_SPACE: Key_Space,
  
  TB_KEY_CTRL_Q: Key_CtrlQ,
  
  TB_KEY_CTRL_Z: Key_CtrlZ,
  
}.toTable

let AsciiBindingMap: Table[uint32, string] = {
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


proc translateBinding(input: tb_event, keyMapping: seq[UserKeyBinding]): string = 
  case input.`type`
  of TB_EVENT_KEY:
    var mapped_key = ""
    if input.ch in AsciiBindingMap:
      mapped_key = AsciiBindingMap[input.ch]
    elif input.key in BindingMap:
      mapped_key = BindingMap[input.key]
    if mapped_key != "":
      let found_bindings = sequtils.filterIt(keyMapping, it.key == mapped_key)
      if found_bindings.len > 0:
        return found_bindings[0].action
  of TB_EVENT_RESIZE:
    return "reload"
  else:
    discard
  return ""
  
proc processInput*(keyMapping: seq[UserKeyBinding]): bool = 
  var event: tb_event
  let event_result = tb_poll_event(addr event)
  let action_string = translateBinding(event, keyMapping)
  if action_string != "":
    result = handleAction(action_string)
  else:
    result = true
