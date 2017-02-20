# =======
# Imports
# =======

import "view.nim"
import "windows.nim"
import "constants.nim"

# =========
# Functions
# =========

proc perform*(window: var Window, command: string, args: seq[string]): bool = 
  case command
  of Command_Help:
    discard
  of Command_Quit:
    windows.shutdownDisplay(window)
    return false
  of Command_Suspend:
    windows.suspendDisplay(window)
  of Command_Up:
    var active_view = windows.getActiveView(window)
    moveMarkerUp(active_view)
    updateView(window, active_view)
  of Command_Down:
    var active_view = windows.getActiveView(window)
    moveMarkerDown(active_view)
    updateView(window, active_view)
  of Command_GoIn:
    var active_view = windows.getActiveView(window)
    navigateIn(active_view)
    updateView(window, active_view)
  of Command_GoOut:
    var active_view = windows.getActiveView(window)
    navigateOut(active_view)
    updateView(window, active_view)
  of Command_Prompt:
    discard
  of Command_Reload:
    redraw(window)
  else:
    discard
  return true
