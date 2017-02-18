# =======
# Imports
# =======

import posix
import tables
import sequtils

import "view.nim"
import "color.nim"
import "drawing.nim"
import "termbox.nim"
import "preferences.nim"

# =====
# Types
# =====

type Window* = object
  displayMode: cint
  views: seq[View]
  colorTheme: Table[string, cint]

# =======
# Drawing
# =======

proc drawTopBar(window: Window): void =
  for col in 0..tb_Width():
    drawing.cell(cint(col), cint(0), " ", TB_DEFAULT, TB_BLACK)

proc drawBottomBar(window: Window): void =
  for col in 0..tb_Width():
    let bottom_bar_offset = tb_height() - 2
    drawing.cell(cint(col), cint(bottom_bar_offset), " ", TB_DEFAULT, TB_BLACK)

# =========
# Functions
# =========

proc setCursorDisplay*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc createWindow*(config: Configuration, working_path: string): Window =
  let tb_mode = convertDisplayModeToTermbox(config.colorMode)
  var main_view = view.createView(working_path)
  main_view.active = true
  return Window(displayMode: tb_mode, views: @[main_view])

proc redraw*(window: Window): void = 
  tb_clear()
  drawTopBar(window)
  let active_views = sequtils.filter(window.views, proc(x: View): bool = (x.active))
  for display_view in active_views:
    view.draw(display_view)
  drawBottomBar(window)
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
