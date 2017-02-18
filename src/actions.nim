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
  Action_Up: Command_Up,
  Action_Down: Command_Down,
  Action_Left: Command_GoOut,
  Action_Right: Command_GoIn,
  Action_CommandPrompt: Command_Prompt,
}.toTable
