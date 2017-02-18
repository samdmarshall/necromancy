# =======
# Imports
# =======

import posix
import tables
import sequtils

import "view.nim"
import "color.nim"
import "theme.nim"
import "drawing.nim"
import "termbox.nim"
import "preferences.nim"

# =====
# Types
# =====

type Window* = object
  displayMode: cint
  views: seq[View]
  colorTheme: ColorTheme

# =======
# Drawing
# =======

proc drawTopBar(window: Window): void =
  for col in 0..(tb_Width() - 1):
    drawing.cell(cint(col), cint(0), " ", TB_DEFAULT, TB_BLACK)

proc drawBottomBar(window: Window): void =
  for col in 0..(tb_Width() - 1):
    let bottom_bar_offset = tb_height() - 2
    drawing.cell(cint(col), cint(bottom_bar_offset), " ", TB_DEFAULT, TB_BLACK)

# =========
# Functions
# =========

proc updateView*(window: var Window, view: View): void =
  var view_index = 0
  for view_item in window.views:
    if view_item.active:
      window.views[view_index] = view
    inc(view_index)

proc getActiveView*(window: Window): View = 
  for view in window.views:
    if view.active:
      return view
  
proc setCursorDisplay*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc createWindow*(config: Configuration, working_path: string): Window =
  let tb_mode = convertDisplayModeToTermbox(config.colorMode)
  var main_view = view.createView(working_path)
  main_view.active = true
  return Window(displayMode: tb_mode, views: @[main_view], colorTheme: config.theme)

proc redraw*(window: var Window): void = 
  tb_clear()
  drawTopBar(window)
  var displayed_view = getActiveView(window)
  draw(displayed_view, window.colorTheme)
  updateView(window, displayed_view)
  drawBottomBar(window)
  tb_present()

proc initializeDisplay*(window: var Window): void = 
  discard tb_init()
  discard tb_select_output_mode(window.displayMode)
  setCursorDisplay(false)
  redraw(window)

proc shutdownDisplay*(window: Window): void =
  tb_clear()
  setCursorDisplay(true)
  tb_shutdown()

proc suspendDisplay*(window: var Window): void =
  shutdownDisplay(window)
  discard `raise`(SIGSTOP)
  initializeDisplay(window)
