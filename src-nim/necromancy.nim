# =======
# Imports
# =======

import os
import sets
import strutils
import strformat

#import necromancypkg/[ logger, settings/preferences, models/types, events/actions, events/eventhandler, ui/view, ui/display ]
import "necromancypkg/logger.nim"
import "necromancypkg/settings/preferences.nim"

import "necromancypkg/models/types.nim"

import "necromancypkg/events/actions.nim"
import "necromancypkg/events/eventhandler.nim"

import "necromancypkg/ui/view.nim"
import "necromancypkg/ui/display.nim"

import termbox
import commandeer

const
  NimblePkgName* {.strdefine.} = ""
  NimblePkgVersion* {.strdefine.} = ""

const
  Flag_Long_Config* = "config"
  Flag_Short_Config* = "c"

  Flag_Long_Trace* = "trace"
  Flag_Short_Trace* = ""

  Flag_Long_Version* = "version"
  Flag_Short_Version* = "v"

  Flag_Long_Help* = "help"
  Flag_Short_Help* = "h"

const
  DefaultConfigPath* = getConfigDir() / NimblePkgName / "config.cfg"
  DefaultTracingEnabled* = false

# =========
# Functions
# =========

proc usage(): seq[string] =
  result.add fmt"usage: {NimblePkgName} [-v|--version] [-h|--help] [--config:path] [--trace] [directory path]"

proc versionInfo(): seq[string] =
  result.add fmt"{NimblePkgName} v{NimblePkgVersion}"

# ===========
# Entry Point
# ===========

proc main() =
  var working_directory = getCurrentDir()

  commandline:
    option setConfigurationPath, string, Flag_Long_Config, Flag_Short_Config, DefaultConfigPath
    option setEnableTrace, bool, Flag_Long_Trace, Flag_Short_Trace, DefaultTracingEnabled
    arguments directoryPaths, string, atLeast1=false
    exitoption Flag_Long_Version, Flag_Short_Version, versionInfo().join("\n")
    exitoption Flag_Long_Help, Flag_Short_Help, usage().join("\n")

  var configuration_path = getEnv("NECROMANCY_CONFIG", setConfigurationPath).expandTilde()

  if len(directoryPaths) > 0:
    working_directory = directoryPaths[directoryPaths.high]

  if not configuration_path.fileExists():
    echo("unable to find a configuration file at '" & configuration_path & "'! Please;")
    echo("  1. create it")
    echo("  -- or --")
    echo("  2. specify the path to the configuration file using:")
    echo("    * the command line flag `--config:path`")
    echo("    -- or --")
    echo("    * the environment variable `NECROMANCY_CONFIG`")
    quit(QuitFailure)

  let configuration_full_path = configuration_path.expandFilename()
  let configuration_directory = configuration_full_path.parentDir()

  initiateLogger(configuration_directory, setEnableTrace)

  let user_configuration = loadUserConfiguration(configuration_full_path)

  discard init()

  while user_configuration.handleEvent():
    echo "redrawing..."

  shutdown()

#[
  # starting up the screen
  startupDisplay()

  var screen = createMainWindow()

  if setEnableTrace:
    var debug = createDebugView()
    screen.views.add(debug)

  screen = screen.reloadContents(user_configuration, working_directory)
  while screen.processInput(user_configuration):
    screen.draw()

  # shutting down the screen
  shutdownDisplay()
]#

when isMainModule:
  main()
