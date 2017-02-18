# =======
# Imports
# =======

import os
import tables
import streams
import parsecfg
import sequtils

import "color.nim"
import "logger.nim"
import "actions.nim"
import "bindings.nim"

# =====
# Types
# =====

type Configuration* = object
  colorMode*: ColorMode
  keys*: seq[UserKeyBinding]

# =========
# Functions
# =========

proc load*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  if not os.fileExists(path):
    Logger(Fatal, "Unable to load preference data, aborting!")
  let config_data: Config = parsecfg.loadConfig(path)
  
  let parsed_mode = parsecfg.getSectionValue(config_data, "general", "colorMode")
  let mode = color.convertConfigToDisplayMode(parsed_mode)

  var bindings = newSeq[UserKeyBinding]()
  let actions: seq[string] = sequtils.toSeq(CommandMap.keys())
  for action_mapping in actions:
    let mapping: string = parsecfg.getSectionValue(config_data, "keys", action_mapping)
    bindings.add(UserKeyBinding(key: mapping, action: action_mapping))
  
  let config = Configuration(colorMode: mode, keys: bindings)
  result = config
