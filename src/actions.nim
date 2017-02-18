# =======
# Imports
# =======

import tables

import "command.nim"

# =========
# Constants
# =========

const
  Action_Help = "help"
  Action_Suspend = "suspend"
  Action_Quit = "quit"
  Action_Up = "navigate-up"
  Action_Down = "navigate-down"
  Action_Left = "navigate-left"
  Action_Right = "navigate-right"
  Action_CommandPrompt = "command-prompt"
  # Action_CommandPin = "pin-tab"
  # Action_CommandPop = "pop-tab"
  # Action_NextTab = "next-tab"
  # Action_PrevTab = "prev-tab"

const CommandMap*: Table[string, string] = {
  Action_Help: Command_Help,
  Action_Suspend: Command_Suspend,
  Action_Quit: Command_Quit,
  Action_Up: "",
  Action_Down: "",
  Action_Left: "",
  Action_Right: "",
  Action_CommandPrompt: "",
}.toTable
