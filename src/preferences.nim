# =======
# Imports
# =======

import os
import streams
import parsecfg

import "types.nim"
import "logger.nim"
import "actions.nim"

# =========
# Functions
# =========

proc loadPreferences*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  if not os.fileExists(path):
    Logger(Fatal, "Unable to load preference data, aborting!")
  let config_data: Config = parsecfg.loadConfig(path)
  
  var mode: ColorMode
  case parsecfg.getSectionValue(config_data, "general", "colorMode")
  of "simple":
    mode = ColorMode.simple
  of "color":
    mode = ColorMode.color
  of "grayscale":
    mode = ColorMode.grayscale
  else:
    discard

  var bindings = newSeq[UserKeyBinding]()
  for action_mapping in KnownActions:
    let mapping: string = parsecfg.getSectionValue(config_data, "keys", action_mapping)
    bindings.add(UserKeyBinding(key: mapping, action: action_mapping))
  
  let config = Configuration(colorMode: mode, keys: bindings)
  result = config
