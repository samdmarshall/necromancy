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
    Selector,
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

  SelectorView* = object
    cursor*: string
    count*: int
    index*: int
  
  InputView* = object
    prompt*: string
    written*: string
    
  ViewContents* {.union.} = object
    text*: TextView
    label*: LabelView
    browser*: FileBrowser
    selector*: SelectorView
    input*: InputView

  View* = ref object
    isa*: ViewType
    name*: string
    rect*: Rect
    internalBuf*: seq[seq[tb_cell]]
    contents*: ViewContents

  Window* = ref object
    views*: seq[View]

