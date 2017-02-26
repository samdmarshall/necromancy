# =======
# Imports
# =======

import "view.nim"
import "types.nim"
import "termbox.nim"

# =========
# Functions
# =========

template writeToDebugConsole*(screen: Window, message: string) =
  var debug_index = getDebugViewIndex(screen)
  if debug_index != -1:
    screen.views[debug_index] = writeNewDebugLine(screen.views[debug_index], message)

proc writeNewDebugLine*(view: View, newLine: string): View =
  ## writes a new line to the debug console at the bottom of the screen, will automatically 
  ## scroll the contents of the TextView as necessary 
  if (not isViewValid(view)) and view.isa == ViewType.Text:
    return
  view.contents.text.lines.add(newLine)
  let more_lines_than_space = view.contents.text.lines.len > view.rect.dimensions.height
  let line_lower_bound = 
    if more_lines_than_space: (view.contents.text.lines.len - view.rect.dimensions.height)
    else: 0
  let line_count = 
    if more_lines_than_space: max(view.contents.text.lines.len, view.rect.dimensions.height)
    else: min(view.contents.text.lines.len, view.rect.dimensions.height)
  for line_index in countdown(line_count-1, line_lower_bound):
    let row = cint(line_count - line_index)
    var chr_index: cint = 0
    for chr in view.contents.text.lines[line_index]:
      var character: uint32
      let character_repr: string = $chr
      discard tb_utf8_char_to_unicode(addr character, character_repr)
      ((view.internalBuf[row])[chr_index]).ch = character
      ((view.internalBuf[row])[chr_index]).fg = TB_DEFAULT
      ((view.internalBuf[row])[chr_index]).bg = TB_DEFAULT
      inc(chr_index)
    if chr_index < view.rect.dimensions.width:
      for clear_index in chr_index..view.rect.dimensions.width:
        ((view.internalBuf[row])[clear_index]).ch = 0
        ((view.internalBuf[row])[clear_index]).fg = TB_DEFAULT
        ((view.internalBuf[row])[clear_index]).bg = TB_DEFAULT
  return view
