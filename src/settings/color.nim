# =======
# Imports
# =======

import os
import parsecfg
import strutils

import "../termbox.nim"

import "../models/types.nim"

# =========
# Functions
# =========

proc parseStringAsColorValue(value: string): uint16 = 
  case value.toLowerAscii()
  of "default":
    return TB_DEFAULT
  of "black":
    return TB_BLACK
  of "red":
    return TB_RED
  of "green":
    return TB_GREEN
  of "yellow":
    return TB_YELLOW
  of "blue":
    return TB_BLUE
  of "magenta":
    return TB_MAGENTA
  of "cyan":
    return TB_CYAN
  of "white":
    return TB_WHITE
  of "bold":
    return TB_BOLD
  of "underline":
    return TB_UNDERLINE
  else:
    return TB_DEFAULT

proc parseColorValueFromSection(settings: Config, name: string): ColorValue =
  let normal_string = settings.getSectionValue(name, "normal")
  let bold_string = settings.getSectionValue(name, "bold")
  let underline_string = settings.getSectionValue(name, "underline")
  
  let normal_color = parseStringAsColorValue(normal_string)
  let bold_color = parseStringAsColorValue(bold_string)
  let underline_color = parseStringAsColorValue(underline_string)

  return ColorValue(normal: normal_color, bold: bold_color, underline: underline_color)

proc loadThemeWithName*(prefs_dir: string, theme_name: string): ColorMap =
  let themes_directory = prefs_dir.joinPath("themes/")
  let theme_file_path = themes_directory.joinPath(theme_name)
  let color_config: Config = loadConfig(theme_file_path)

  
  let default = color_config.parseColorValueFromSection("default")
  let black = color_config.parseColorValueFromSection("black")
  let red = color_config.parseColorValueFromSection("red")
  let green = color_config.parseColorValueFromSection("green")
  let yellow = color_config.parseColorValueFromSection("yellow")
  let blue = color_config.parseColorValueFromSection("blue")
  let magenta = color_config.parseColorValueFromSection("magenta")
  let cyan = color_config.parseColorValueFromSection("cyan")
  let white = color_config.parseColorValueFromSection("white")
  
  return ColorMap(
    default: default, 
    black: black, 
    red: red, 
    green: green, 
    yellow: yellow, 
    blue: blue, 
    magenta: magenta, 
    cyan: cyan, 
    white: white
  )
