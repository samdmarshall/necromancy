# =======
# Imports
# =======

import "termbox.nim"

# =========
# Functions
# =========

proc cell*(x: cint, y: cint, chr: string, fg: uint16, bg: uint16): void =
  if x < tb_width():
    var character: uint32
    discard tb_utf8_char_to_unicode(addr character, chr)
    tb_change_cell(x, y, character, fg, bg)
