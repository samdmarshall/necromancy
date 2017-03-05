# ========
# Bindings
# ========

type 
  UserKeyBinding* = object
    key*: string
    action*: string


# ===========
# Preferences
# ===========

type
  ColorValue* = object
    bright*: uint16
    normal*: uint16
    bold*: uint16
    underline*: uint16
    
  ColorMap* {.final.} = object
    default*: ColorValue
    black*: ColorValue
    red*: ColorValue
    green*: ColorValue
    yellow*: ColorValue
    blue*: ColorValue
    magenta*: ColorValue
    cyan*: ColorValue
    white*: ColorValue

  
  ColorTheme* = object
    map*: ColorMap
    file*: ColorValue
    directory*: ColorValue
    executable*: ColorValue
    symlink*: ColorValue
     
  Configuration* = object
    keys*: seq[UserKeyBinding]
    colors*: ColorTheme
