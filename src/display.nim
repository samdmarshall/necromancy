# =======
# Imports
# =======

import posix

import "types.nim"
import "termbox.nim"

# =========
# Functions
# =========

proc setCursorDisplay*(enabled: bool): void =
  if enabled:
    tb_set_cursor(0, 0)
  else:
    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc shutdownDisplay*(): void =
  tb_clear()
  setCursorDisplay(true)
  tb_shutdown()

proc startupDisplay*(): void =
  discard tb_init()
  setCursorDisplay(false)

proc suspendDisplay*(): void =
  shutdownDisplay()
  discard `raise`(SIGSTOP)
  startupDisplay()

proc draw*(screen: Window): void =
  ## Call this method to re-draw the screen contents, it will iterate over
  ## all of the views in the screen (from low to high) drawing the contents 
  ## of each sequentially.
  tb_clear()
  for view in screen.views:
    var y: cint = view.rect.origin.y
    for row in view.internalBuf:
      var x: cint = view.rect.origin.x
      for cell in row:
        tb_change_cell(x, y, cell.ch, cell.fg, cell.bg)
        inc(x)
      inc(y)
  tb_present()
