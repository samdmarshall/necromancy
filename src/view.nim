# =======
# Imports
# =======

import "theme.nim"
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
  let row: cint = 1
  let offset: cint = 2
  var index: cint = 0
  for chr in view.cwd:
    let column = offset + index
    drawing.cell(column, row, $chr, TB_DEFAULT, TB_DEFAULT)
    inc(index)

proc drawItems(view: View, theme: ColorTheme): void =
  let col_offset: cint = 4
  var row: cint = 3
  for item in view.items:
    var index: cint = 0
    let path_name = fileitem.getName(item)
    for chr in path_name:
      let col = col_offset + index
      drawing.cell(col, row, $chr, TB_DEFAULT, TB_DEFAULT)
      inc(index)
    inc(row)

# =========
# Functions
# =========

proc createView*(path: string): View =
  return View(cwd: path, items: fileitem.populate(path), active: false)

proc draw*(view: View, theme: ColorTheme): void = 
  drawDirectoryPath(view)
  drawItems(view, theme)
