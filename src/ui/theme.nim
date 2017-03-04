# =======
# Imports
# =======

import "../models/types.nim"

# =========
# Functions
# =========

proc setBackgroundColor*(view: View, bg_color: uint16): void = 
  for row_index in 0..view.internalBuf.high():
    let row = view.internalBuf[row_index]
    for cell_index in 0..row.high():
      view.internalBuf[row_index][cell_index].bg = bg_color
