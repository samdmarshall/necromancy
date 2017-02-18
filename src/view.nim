# =======
# Imports
# =======

import "drawing.nim"
import "termbox.nim"
import "fileitem.nim"

# =====
# Types
# =====

type View* = object
  cwd*: string
  items: seq[FileItem]
  active*: bool

# =======
# Drawing
# =======

proc drawDirectoryPath(view: View): void =
  let offset = 2
  var index = 0
  for chr in view.cwd:
    let column: cint = cint(offset + index)
    drawing.cell(column, cint(1), $chr, TB_DEFAULT, TB_DEFAULT)
    inc(index)

proc drawItems(view: View): void =
  let col_offset = 4
  var row: cint = 4
  for item in view.items:
    var index = 0
    let path_name = fileitem.getName(item)
    for chr in path_name:
      let col = cint(col_offset + index)
      drawing.cell(col, row, $chr, TB_DEFAULT, TB_DEFAULT)
      inc(index)
    inc(row)

# =========
# Functions
# =========

proc createView*(path: string): View =
  return View(cwd: path, items: fileitem.populate(path), active: false)

proc draw*(view: View): void = 
  drawDirectoryPath(view)
  drawItems(view)
