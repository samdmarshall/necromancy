# =======
# Imports
# =======

import tables

import "constants.nim"

# =========
# Constants
# =========

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
