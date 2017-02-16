# =======
# Imports
# =======

import os
import logging
import parseopt2

import "preferences.nim"

# =====
# Types
# =====

type Subcommand {.pure.} = enum
  None,
  Help,
  Version,
  Configuration

# =========
# Functions
# =========

proc progName(): string =
  result = os.extractFilename(os.getAppFilename())

proc usage(): void = 
  quit(QuitSuccess)

proc versionInfo(): void =
  echo(progname() & " v0.1")
  quit(QuitSuccess)

# ===========================================
# this is the entry-point, there is no main()
# ===========================================

var command = Subcommand.None
var configuration_path = os.expandTilde(os.getEnv("NECROMANCY_CONFIG"))
var working_directory = os.getCurrentDir()
var enable_verbose_logging = false
var enable_debug_logging = false

for kind, key, value in parseopt2.getopt():
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h":
      command = Subcommand.Help
    of "version", "v":
      command = Subcommand.Version
    of "config":
      command = Subcommand.Configuration
      configuration_path = os.expandTilde(value)
    of "verbose":
      enable_verbose_logging = true
    of "debug":
      enable_debug_logging = true
    else:
      discard
  of cmdArgument:
    working_directory = os.expandTilde(key)
  else:
    discard

var logging_level = Level.lvlWarn
if enable_verbose_logging:
  logging_level = Level.lvlInfo
if enable_debug_logging:
  logging_level = Level.lvlDebug
let application_logger = logging.newConsoleLogger(logging_level)
logging.addHandler(application_logger)

logging.debug("Parsing the passed commands")
# case command
# of Subcommand.Version:
  # versionInfo()
# of Subcommand.Help:
  # usage()
# else:
  # let config = loadPreferences(configuration_path)
