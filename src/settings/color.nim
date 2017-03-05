# =======
# Imports
# =======

import os
import parsecfg
import strutils

import "../termbox.nim"

import "../models/types.nim"
import "../models/configuration.nim"

# =========
# Constants
# =========

const
  Color_Default = "default"
  Color_Black = "black"
  Color_Red = "red"
  Color_Green = "green"
  Color_Yellow = "yellow"
  Color_Blue = "blue"
  Color_Magenta = "magenta"
  Color_Cyan = "cyan"
  Color_White = "white"

# =========
# Functions
# =========

proc parseStringAsColorValue(value: string): uint16 = 
  case value.toLowerAscii()
  of Color_Default:
    return TB_DEFAULT
  of Color_Black:
    return TB_BLACK
  of Color_Red:
    return TB_RED
  of Color_Green:
    return TB_GREEN
  of Color_Yellow:
    return TB_YELLOW
  of Color_Blue:
    return TB_BLUE
  of Color_Magenta:
    return TB_MAGENTA
  of Color_Cyan:
    return TB_CYAN
  of Color_White:
    return TB_WHITE
  of "bold":
    return TB_BOLD
  of "underline":
    return TB_UNDERLINE
  else:
    return TB_DEFAULT

proc mapValueOfKeyToColorRef(settings: Config, key: string, map: ColorMap): ColorValue =
  case settings.getSectionValue("theme", key).toLowerAscii()
  of Color_Default:
    return map.default
  of Color_Black:
    return map.black
  of Color_Red:
    return map.red
  of Color_Green:
    return map.green
  of Color_Yellow:
    return map.yellow
  of Color_Blue:
    return map.blue
  of Color_Magenta:
    return map.magenta
  of Color_Cyan:
    return map.cyan
  of Color_White:
    return map.white
  else:
    return map.default

proc parseColorValueFromSection(settings: Config, name: string): ColorValue =
  let normal_string = settings.getSectionValue(name, "normal")
  let bold_string = settings.getSectionValue(name, "bold")
  let underline_string = settings.getSectionValue(name, "underline")
  
  let normal_color = parseStringAsColorValue(normal_string)
  let bold_color = parseStringAsColorValue(bold_string)
  let underline_color = parseStringAsColorValue(underline_string)

  return ColorValue(normal: normal_color, bold: bold_color, underline: underline_color)

proc loadThemeWithName*(prefs_dir: string, theme_name: string): ColorTheme =
  let themes_directory = prefs_dir.joinPath("themes/")
  let theme_file_path = themes_directory.joinPath(theme_name)
  let color_config: Config = loadConfig(theme_file_path)

  
  let default = color_config.parseColorValueFromSection(Color_Default)
  let black = color_config.parseColorValueFromSection(Color_Black)
  let red = color_config.parseColorValueFromSection(Color_Red)
  let green = color_config.parseColorValueFromSection(Color_Green)
  let yellow = color_config.parseColorValueFromSection(Color_Yellow)
  let blue = color_config.parseColorValueFromSection(Color_Blue)
  let magenta = color_config.parseColorValueFromSection(Color_Magenta)
  let cyan = color_config.parseColorValueFromSection(Color_Cyan)
  let white = color_config.parseColorValueFromSection(Color_White)
  
  let color_mapping = ColorMap(default: default, black: black, red: red, green: green, yellow: yellow, blue: blue, magenta: magenta, cyan: cyan, white: white)

  var theme = ColorTheme(map: color_mapping)
  theme.file = color_config.mapValueOfKeyToColorRef("file", color_mapping)
  theme.directory = color_config.mapValueOfKeyToColorRef("directory", color_mapping)
  theme.executable = color_config.mapValueOfKeyToColorRef("executable", color_mapping)
  theme.symlink = color_config.mapValueOfKeyToColorRef("symlink", color_mapping)
  
  return theme
