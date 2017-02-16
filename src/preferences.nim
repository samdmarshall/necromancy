# =======
# Imports
# =======

import os
import yaml
import streams

import "bindings.nim"
import "logger.nim"

# =====
# Types
# =====

type Configuration* = object
  keys*: seq[UserKeyBinding]

# =========
# Functions
# =========

proc loadPreferences*(path: string): Configuration = 
  Logger(Debug, "Loading preference data...")
  var config: Configuration
  if os.fileExists(path):
    let config_file_descriptor = streams.newFileStream(path)
    yaml.serialization.load(config_file_descriptor, config)
    config_file_descriptor.close()
  
  initializeBindings(config.keys)
  result = config
