# =======
# Imports
# =======

import "logger.nim"
import "termbox.nim"

# =====
# Types
# =====

type ColorMode* = enum
  simple,
  color,
  grayscale

# =========
# Functions
# =========

proc convertDisplayModeToTermbox*(mode: ColorMode): cint =
  var tb_mode: cint
  case mode
  of ColorMode.simple:
    tb_mode = TB_OUTPUT_NORMAL
  of ColorMode.color:
    tb_mode = TB_OUTPUT_256
  of ColorMode.grayscale:
    tb_mode = TB_OUTPUT_GRAYSCALE
  else:
     tb_mode = TB_OUTPUT_CURRENT
  return tb_mode

proc convertConfigToDisplayMode*(mode: string): ColorMode =
  case mode
  of "simple":
    return ColorMode.simple
  of "color":
    return ColorMode.color
  of "grayscale":
    return ColorMode.grayscale
  else:
    Logger(Fatal, "unknown color mode!")
