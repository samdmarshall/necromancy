# =======
# Imports
# =======

import "view.nim"

import "../models/types.nim"

import termbox

# =========
# Functions
# =========

proc setText*(view: View, display: string): View =
  if (not isViewValid(view)) and view.isa == ViewType.Label:
    return
  view.contents.label.text = display
  var chr_index: cint = 0
  while chr_index < view.internalBuf[0].len:
    var character: uint32 = 0
    if chr_index < view.contents.label.text.len:
      let character_repr: string = $view.contents.label.text[chr_index]
      discard utf8_char_to_unicode(addr character, character_repr)
    ((view.internalBuf[0])[chr_index]).ch = character
    ((view.internalBuf[0])[chr_index]).fg = TB_DEFAULT
    ((view.internalBuf[0])[chr_index]).bg = TB_DEFAULT
    inc(chr_index)
  return view
