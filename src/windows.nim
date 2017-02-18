# =======
# Imports
# =======

import posix

import "view.nim"
import "color.nim"
import "termbox.nim"

# =====
# Types
# =====

type Window* = object
  displayMode: cint
  views: seq[View]

# =======
# Drawing
# =======

proc drawCell(x: cint, y: cint, chr: string, fg: uint16, bg: uint16): void =
  var character: uint32
  discard tb_utf8_char_to_unicode(addr character, chr)
  tb_change_cell(x, y, character, fg, bg)

# =========
# Functions
# =========

proc setCursorDisplay*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc createWindow*(mode: ColorMode, working_path: string): Window =
  let tb_mode = convertDisplayModeToTermbox(mode)
  let main_view = view.createView(working_path)
  return Window(displayMode: tb_mode, views: @[main_view])

proc redraw*(window: Window): void = 
  tb_clear()
  tb_present()

proc initializeDisplay*(window: Window): void = 
  discard tb_init()
  discard tb_select_output_mode(window.displayMode)
  setCursorDisplay(false)
  redraw(window)

proc shutdownDisplay*(window: Window): void =
  tb_clear()
  setCursorDisplay(true)
  tb_shutdown()

proc suspendDisplay*(window: Window): void =
  shutdownDisplay(window)
  discard `raise`(SIGSTOP)
  initializeDisplay(window)
