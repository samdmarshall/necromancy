# =======
# Imports
# =======

import os

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
  visibleRange*: tuple[first: int, last: int]
  markerIndex*: int

# =========
# Constants
# =========

const OffsetFromTopForItems = 3
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

proc drawItems(view: var View, theme: ColorTheme): void =
  let col_offset: cint = 4
  var row: cint = OffsetFromTopForItems
  view.visibleRange.first = row
  for item in view.items:
    var index: cint = 0
    let path_name = fileitem.getName(item)
    let draw_color = fileitem.getDisplayColor(item, theme)
    for chr in path_name:
      let col = col_offset + index
      if row < (tb_height() - OffsetFromTopForItems):
        drawing.cell(col, row, $chr, draw_color, TB_DEFAULT)
        view.visibleRange.last = row
      inc(index)
    inc(row)

proc drawMarker(view: var View): void =
  let truncated_top = view.visibleRange.first != (0 + OffsetFromTopForItems)
  let trancated_bottom = view.visibleRange.last != (view.items.len + OffsetFromTopForItems)
  for index in view.visibleRange.first..view.visibleRange.last:
    if index == view.markerIndex:
      drawing.cell(cint(2), cint(index), ">", TB_BOLD, TB_DEFAULT)
    else:
      drawing.cell(cint(2), cint(index), " ", TB_DEFAULT, TB_DEFAULT)

proc drawDebug(view: var View): void =
  var col_offset: cint = 0
  for chr in $view.markerIndex:
    drawing.cell(col_offset, tb_height()-1, $chr, TB_DEFAULT, TB_DEFAULT)
    inc(col_offset)

# =========
# Functions
# =========

proc createView*(path: string): View =
  return View(cwd: path, items: fileitem.populate(path), active: false, markerIndex: OffsetFromTopForItems)

proc updateViewContents*(view: var View, path: string): void =
  view.cwd = path
  view.items = fileitem.populate(path)
  view.markerIndex = OffsetFromTopForItems
  view.visibleRange.first = OffsetFromTopForItems
  view.visibleRange.last = OffsetFromTopForItems

proc draw*(displayed_view: var View, theme: ColorTheme): void = 
  drawDirectoryPath(displayed_view)
  drawItems(displayed_view, theme)
  drawMarker(displayed_view)
  drawDebug(displayed_view)

proc moveMarkerUp*(view: var View): void =
  var current: int = view.markerIndex
  let peek = current - 1
  if peek >= view.visibleRange.first:
    view.markerIndex = peek

proc moveMarkerDown*(view: var View): void = 
  var current: int = view.markerIndex
  let peek = current + 1
  if peek <= view.visibleRange.last:
    view.markerIndex = peek

proc navigateIn*(view: var View): void =
  var current: int = view.markerIndex - OffsetFromTopForItems
  let item_type = fileitem.getInfo(view.items[current])
  case item_type.kind
  of pcDir, pcLinkToDir:
    updateViewContents(view, fileitem.getFullPath(view.items[current]))
  else:
    discard

proc navigateOut*(view: var View): void =
  updateViewContents(view, os.parentDir(view.cwd))
