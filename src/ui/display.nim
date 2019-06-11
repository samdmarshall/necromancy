# =======
# Imports
# =======

import posix

import termbox

import "../models/types.nim"

# =========
# Functions
# =========

proc setCursorDisplay*(enabled: bool): void =
  if enabled:
    set_cursor(0, 0)
  else:
    set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)

proc shutdownDisplay*(): void =
  clear()
  setCursorDisplay(true)
  shutdown()

proc startupDisplay*(): void =
  discard init()
  setCursorDisplay(false)

proc suspendDisplay*(): void =
  shutdownDisplay()
  discard `raise`(SIGSTOP)
  startupDisplay()

proc draw*(screen: Window): void =
  ## Call this method to re-draw the screen contents, it will iterate over
  ## all of the views in the screen (from low to high) drawing the contents 
  ## of each sequentially.
  clear()
  for view in screen.views:
    var y: cuint = view.rect.origin.y
    for row in view.internalBuf:
      var x: cuint = view.rect.origin.x
      for cell in row:
        change_cell(x, y, cell.ch, cell.fg, cell.bg)
        inc(x)
      inc(y)
  present()
