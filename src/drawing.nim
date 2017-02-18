# =======
# Imports
# =======

import "logger.nim"
import "termbox.nim"

# =========
# Functions
# =========

proc cell*(x: cint, y: cint, chr: string, fg: uint16, bg: uint16): void =
  let within_x_bounds = (x < tb_width() and x >= 0)
  let within_y_bounds = (y < tb_height() and y >= 0)
  if within_x_bounds and within_y_bounds:
    var character: uint32
    discard tb_utf8_char_to_unicode(addr character, chr)
    tb_change_cell(x, y, character, fg, bg)
  else:
    Logger(Error, "attempting to write at (row: " & $y & ", col: " & $x & "), which is out of bounds")
