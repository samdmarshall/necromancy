# =======
# Imports
# =======

import "view.nim"

import "../termbox.nim"

import "../models/types.nim"
import "../models/fileitem.nim"

# =========
# Functions
# =========

proc updatePath*(view: View, path: string): View =
  if (not isViewValid(view)) and view.isa == ViewType.Browser:
    return
  view.contents.browser.activePath = path
  view.contents.browser.items = populate(path)
  view.contents.browser.cursorIndex = 
    if view.contents.browser.items.len > 0: 0
    else: -1
  var row_index = 0
  while row_index < view.internalBuf.len:
    var foreground_color = TB_DEFAULT
    var background_color = TB_DEFAULT
    var item_name = ""
    if row_index < view.contents.browser.items.len:
      let item = view.contents.browser.items[row_index]
      item_name = item.getName()
    var col_index = 3
    while col_index < view.internalBuf[row_index].len:
      var offset = col_index - 3 # use the starting value of `col_index`
      var character: uint32
      if offset < item_name.len:
        let character_repr: string = $item_name[offset]
        discard tb_utf8_char_to_unicode(addr character, character_repr)
      else:
        character = 0
      ((view.internalBuf[row_index])[col_index]).ch = character
      ((view.internalBuf[row_index])[col_index]).fg = foreground_color
      ((view.internalBuf[row_index])[col_index]).bg = background_color
      inc(col_index)
    inc(row_index)
  return view


