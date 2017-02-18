# =======
# Imports
# =======

import os
import tables
import streams
import parsecfg
import sequtils
import typeinfo

import "color.nim"
import "theme.nim"
import "logger.nim"
import "actions.nim"
import "bindings.nim"

# =====
# Types
# =====

type Configuration* = object
  colorMode*: ColorMode
  keys*: seq[UserKeyBinding]
  theme*: ColorTheme

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
    Logger(Info, "Mapping '" & mapping & "' to '" & action_mapping & "'")

  var config = Configuration(colorMode: mode, keys: bindings, theme: DefaultTheme)
  
  for item in ColorThemeItems():
    let mapping = parsecfg.getSectionValue(config_data, "theme", item)
    if mapping.len > 0:
      theme.updateValue(config.theme, item, mapping)

  result = config
