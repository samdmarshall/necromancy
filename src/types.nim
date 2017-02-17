# =====
# Types
# =====

type ColorMode* = enum
  simple,
  color,
  grayscale

type UserKeyBinding* = object
  key*: string
  action*: string

type Configuration* = object
  colorMode*: ColorMode
  keys*: seq[UserKeyBinding]
  
