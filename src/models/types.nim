# =======
# Imports
# =======

import "fileitem.nim"

import "../termbox.nim"

# =====
# Types
# =====

# ==========
# Drawing UI
# ==========

type
  Point* = object
    x*: cint
    y*: cint

  Size* = object
    width*: cint
    height*: cint

  Rect* = object
    origin*: Point
    dimensions*: Size

  ViewType* = enum
    Plain,
    Text,
    Label,
    Browser,
    Input

  TextView* = object
    lines*: seq[string]
    lineOffset*: int

  LabelView* = object
    text*: string

  FileBrowser* = object
    activePath*: string
    items*: seq[FileItem]
    cursorIndex*: int
  
  InputView* = object
    prompt*: string
    written*: string
    
  ViewContents* {.union.} = object
    text*: TextView
    label*: LabelView
    browser*: FileBrowser
    input*: InputView

  View* = ref object
    isa*: ViewType
    name*: string
    rect*: Rect
    internalBuf*: seq[seq[tb_cell]]
    contents*: ViewContents

  Window* = ref object
    views*: seq[View]


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
    file*: ptr ColorValue
    directory*: ptr ColorValue
    executable*: ptr ColorValue
    symlink*: ptr ColorValue
     
  Configuration* = object
    keys*: seq[UserKeyBinding]
    colors*: ColorTheme
