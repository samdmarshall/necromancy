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
  var row_index = 0
  while row_index < view.internalBuf.len:
    var item_name = ""
    if row_index < view.contents.browser.items.len:
      let item = view.contents.browser.items[row_index]
      item_name = item.getName()
    var col_index = 0
    while col_index < view.internalBuf[row_index].len:
      var character: uint32
      if col_index < item_name.len:
        let character_repr: string = $item_name[col_index]
        discard tb_utf8_char_to_unicode(addr character, character_repr)
      else:
        character = 0
      ((view.internalBuf[row_index])[col_index]).ch = character
      ((view.internalBuf[row_index])[col_index]).fg = TB_DEFAULT
      ((view.internalBuf[row_index])[col_index]).bg = TB_DEFAULT
      inc(col_index)
    inc(row_index)
  return view


