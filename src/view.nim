# =======
# Imports
# =======

import posix

import "types.nim"
import "logger.nim"
import "termbox.nim"

# =====
# Types
# =====

type Tab = object
  filePath: string

type Window = object
  tabs: seq[Tab]
  currentTab: uint
  items: seq[string]
  currentItem: uint

# =========
# Functions
# =========

proc setCursor*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc initializeDisplay*(mode: ColorMode): void = 
  discard tb_init()
  var tb_mode: cint
  case mode
  of ColorMode.simple:
    tb_mode = TB_OUTPUT_NORMAL
  of ColorMode.color:
    tb_mode = TB_OUTPUT_256
  of ColorMode.grayscale:
    tb_mode = TB_OUTPUT_GRAYSCALE
  else:
    tb_mode = cint(mode)
  discard tb_select_output_mode(tb_mode)
  setCursor(false)

proc shutdownDisplay*(): void =
  setCursor(true)
  tb_shutdown()

proc redraw*(): void =
  discard

proc suspendDisplay*(): void =
  let mode = tb_select_output_mode(TB_OUTPUT_CURRENT)
  shutdownDisplay()
  discard `raise`(SIGSTOP)
  initializeDisplay(ColorMode(mode))
  redraw()
