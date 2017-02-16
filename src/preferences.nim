# =======
# Imports
# =======

import os
import yaml
import logging

import "bindings.nim"

# =====
# Types
# =====

type Configuration* = object
  keys*: seq[UserKeyBinding]

# =========
# Functions
# =========

proc loadPreferences*(path: string): Configuration = 
  logging.debug("Loading preference data...")
  var config = Configuration()
  initializeBindings(config.keys)
  result = config
