# =======
# Imports
# =======

import "view.nim"

import "../logger.nim"
import "../models/types.nim"

import termbox

# =========
# Functions
# =========

template writeToDebugConsole*(screen: Window, message: string) =
  Logger(Debug, message)
  var debug_index = screen.getDebugViewIndex()
  if debug_index != -1:
    let debug_view = screen.views[debug_index]
    screen.views[debug_index] = debug_view.writeNewTextLine(message)

proc writeNewTextLine*(view: View, newLine: string): View =
  ## writes a new line to the debug console at the bottom of the screen, will automatically 
  ## scroll the contents of the TextView as necessary 
  if (not isViewValid(view)) and view.isa == ViewType.Text:
    return
  view.contents.text.lines.add(newLine)
  let more_lines_than_space = view.contents.text.lines.high() > (view.internalBuf.len - 1)
  let line_lower_bound = 
    if more_lines_than_space: (view.contents.text.lines.high() - (view.internalBuf.len - 1))
    else: 0
  let line_count = 
    if more_lines_than_space: max(view.contents.text.lines.high(), (view.internalBuf.len - 1))
    else: min(view.contents.text.lines.high(), (view.internalBuf.len - 1))
  for line_index in countdown(line_count, line_lower_bound):
    let row = cint(line_count - line_index)
    var chr_index: cint = 0
    while chr_index < view.internalBuf[row].len:
      var character: uint32 = 0
      if chr_index < view.contents.text.lines[line_index].len:
        let character_repr: string = $view.contents.text.lines[line_index][chr_index]
        discard utf8_char_to_unicode(addr character, character_repr)
      ((view.internalBuf[row])[chr_index]).ch = character
      ((view.internalBuf[row])[chr_index]).fg = TB_DEFAULT
      ((view.internalBuf[row])[chr_index]).bg = TB_DEFAULT
      inc(chr_index)
  return view
