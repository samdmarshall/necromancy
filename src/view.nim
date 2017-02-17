# =======
# Imports
# =======

import posix

import "types.nim"
import "logger.nim"
import "window.nim"
import "termbox.nim"

# =======
# Globals
# =======

var windowCtx: Window

# =================
# Private Functions
# =================

proc drawTabBar(): void =
  let display_width = tb_width() - 1
  for col in 0..display_width:
    var character: uint32
    discard tb_utf8_char_to_unicode(addr character, " ")
    tb_change_cell(col, 0, character, TB_DEFAULT, TB_BLACK)

proc drawDirectory(): void =
  let current_tab = window.currentTab(windowCtx)
  let directory_path = " " & current_tab.filePath
  let display_width = tb_width() - 1
  for col in 0..display_width:
    var character: uint32
    if col <= directory_path.len:
      discard tb_utf8_char_to_unicode(addr character, $directory_path[col])
    else:
      discard tb_utf8_char_to_unicode(addr character, " ")
    tb_change_cell(col, 1, character, TB_DEFAULT, TB_DEFAULT)

# =========
# Functions
# =========

proc redraw*(): void =
  tb_clear()
  drawTabBar()
  drawDirectory()
  tb_present()

proc setCursor*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc initializeDisplay*(mode: ColorMode, workingDir: string): void = 
  if not windowCtx.isInitialized:
    windowCtx = window.initializeWindow(workingDir)
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
  redraw()

proc shutdownDisplay*(): void =
  tb_clear()
  setCursor(true)
  tb_shutdown()

proc suspendDisplay*(): void =
  let mode = tb_select_output_mode(TB_OUTPUT_CURRENT)
  shutdownDisplay()
  discard `raise`(SIGSTOP)
  initializeDisplay(ColorMode(mode), "")
