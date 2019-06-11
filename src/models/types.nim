# =======
# Imports
# =======

import "fileitem.nim"

import termbox

# =====
# Types
# =====

# ==========
# Drawing UI
# ==========

type
  Point* = object
    x*: cuint
    y*: cuint

  Size* = object
    width*: cuint
    height*: cuint

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
    lineOffset*: cint

  LabelView* = object
    text*: string

  FileBrowser* = object
    activePath*: string
    displayOffset*: cint
    items*: seq[FileItem]
    cursorIndex*: cint

  SelectorView* = object
    cursor*: string
    count*: cint
    index*: cint
  
  InputView* = object
    prompt*: string
    written*: string
    
  ViewContents* = object
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

