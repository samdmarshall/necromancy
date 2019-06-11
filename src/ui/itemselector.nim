# =======
# Imports
# =======

import math

import "view.nim"

import "../logger.nim"

import termbox

import "../models/types.nim"

import "../events/constants.nim"

# =========
# Functions
# =========

proc moveUp*(view: View, browser: View): View =
  if (not isViewValid(view)) and view.isa == ViewType.Selector:
    return
  view.contents.selector.index -= 1
  let max_num_items = max(browser.rect.dimensions.height, view.contents.selector.count)
  let ratio = ceil(max_num_items / view.contents.selector.count)
  Logger(Debug, "found ratio " & $ratio)
  var row_index = 0
  while row_index < view.internalBuf.len:
    var foreground_color = TB_DEFAULT
    var background_color = TB_DEFAULT
    var character: uint32 = 0
    if row_index == view.contents.selector.index:
      discard tb_utf8_char_to_unicode(addr character, view.contents.selector.cursor)
    ((view.internalBuf[row_index])[0]).ch = character
    ((view.internalBuf[row_index])[0]).fg = foreground_color
    ((view.internalBuf[row_index])[0]).bg = background_color
    inc(row_index)
  return view

proc moveDown*(view: View, browser: View): View = 
  if (not isViewValid(view)) and view.isa == ViewType.Selector:
    return
  view.contents.selector.index += 1
  let max_num_items = max(browser.rect.dimensions.height, view.contents.selector.count)
  let ratio = ceil(max_num_items / view.contents.selector.count)
  Logger(Debug, "found ratio " & $ratio)
  var row_index = 0
  while row_index < view.internalBuf.len:
    var foreground_color = TB_DEFAULT
    var background_color = TB_DEFAULT
    var character: uint32 = 0
    if row_index == view.contents.selector.index:
      discard tb_utf8_char_to_unicode(addr character, view.contents.selector.cursor)
    ((view.internalBuf[row_index])[0]).ch = character
    ((view.internalBuf[row_index])[0]).fg = foreground_color
    ((view.internalBuf[row_index])[0]).bg = background_color
    inc(row_index)
  return view
  
