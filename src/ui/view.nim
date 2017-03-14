# =======
# Imports
# =======

import os
import sequtils

import "theme.nim"

import "../termbox.nim"

import "../models/types.nim"
import "../models/fileitem.nim"
import "../models/configuration.nim"

import "../events/constants.nim"

# =========
# Constants
# =========

const ZeroPoint = Point(x: 0, y: 0)
const ZeroSize = Size(width: 0, height: 0)
const ZeroRect = Rect(origin: ZeroPoint, dimensions: ZeroSize)

# =================
# Private Functions
# =================

proc createInternalBuffer(point: Point, size: Size): seq[seq[tb_cell]] = 
  var buffer = newSeq[seq[tb_cell]]()
  var y_index = point.y
  while y_index < (point.y + size.height):
    var row = newSeq[tb_cell]()
    var x_index = point.x
    while x_index < (point.x + size.width):
      row.add(tb_cell())
      inc(x_index)
    buffer.add(row)
    inc(y_index)
  return buffer


# ================
# Public Functions
# ================

proc createViewAtPointWithSize*(point: Point, size: Size): View =
  var buffer = createInternalBuffer(point, size)
  var view = View(rect: Rect(origin: point, dimensions: size), isa: Plain, internalBuf: buffer)
  view.isa = Plain
  return view

proc createTextViewAtPointWithSize*(point: Point, size: Size): View =
  var view = createViewAtPointWithSize(point, size)
  view.isa = Text
  view.contents.text.lines = newSeq[string]()
  return view

proc createLabelViewAtPointWithSize*(point: Point, size: Size): View =
  var view = createViewAtPointWithSize(point, size)
  view.isa = Label
  return view

proc createBrowserViewAtPointWithSize*(point: Point, size: Size): View =
  var view = createViewAtPointWithSize(point, size)
  view.isa = Browser
  let current_path = getEnv("PWD")
  view.contents.browser.activePath = current_path
  view.contents.browser.items = populate(current_path, @[])
  return view

proc createSelectorViewFromBrowser*(browser: View): View =
  let origin = Point(x: browser.rect.origin.x - 2, y: browser.rect.origin.y)
  let size = Size(width: 1, height: browser.rect.dimensions.height)
  var view = createViewAtPointWithSize(origin, size)
  view.isa = Selector
  view.contents.selector.cursor = ">"
  view.contents.selector.count = (browser.contents.browser.items.len - 1)
  if view.contents.selector.count == 0:
    view.contents.selector.index = -1
  return view

proc createInputViewAtPointWithSize*(point: Point, size: Size): View =
  var view = createViewAtPointWithSize(point, size)
  view.isa = Input
  view.contents.input.prompt = ": "
  return view

proc createMainWindow*(): Window = 
  let full_screen = Size(width: tb_width(), height: tb_height())
  var main = createViewAtPointWithSize(ZeroPoint, full_screen)
  main.name = ViewName_Main

  let top_bar_rect = Size(width: tb_width(), height: 1)
  var top_bar = createViewAtPointWithSize(ZeroPoint, top_bar_rect)
  top_bar.name = ViewName_TopBar
  top_bar.setBackgroundColor(TB_BLACK)

  let directory_path_rect = Size(width: (tb_width() - 4), height: 1)
  let directory_path_origin = Point(x: 4, y: 1)
  var directory_path = createLabelViewAtPointWithSize(directory_path_origin, directory_path_rect)
  directory_path.name = ViewName_DirectoryPath

  let directory_contents_rect = Size(width: (tb_width() - 4), height: (tb_height() - 5))
  let directory_contents_origin = Point(x: 4, y: 4)
  var directory_contents = createTextViewAtPointWithSize(directory_contents_origin, directory_contents_rect)
  directory_contents.name = ViewName_DirectoryContents

  var selector = createSelectorViewFromBrowser(directory_contents)
  selector.name = ViewName_ItemSelector

  let bottom_bar_rect = Size(width: tb_width(), height: 1)
  let bottom_bar_origin = Point(x: 0, y: (tb_height() - 2))
  var bottom_bar = createViewAtPointWithSize(bottom_bar_origin, bottom_bar_rect)
  bottom_bar.name = ViewName_BottomBar
  bottom_bar.setBackgroundColor(TB_BLACK)

  let command_prompt_rect = Size(width: tb_width(), height: 1)
  let command_prompt_origin = Point(x: 0, y: (tb_height() - 1))
  var command_prompt = createInputViewAtPointWithSize(command_prompt_origin, command_prompt_rect)
  command_prompt.name = ViewName_CommandEntry
    
  return Window(views: @[main, top_bar, directory_path, directory_contents, selector,  command_prompt, bottom_bar])

proc createDebugView*(): View =
  let size = Size(width: tb_width(), height: 5)
  let origin = Point(x: 0, y: (tb_height() - size.height))
  var text_view = createTextViewAtPointWithSize(origin, size)
  text_view.name = ViewName_DebugConsole
  return text_view

proc isViewValid*(view: View): bool =
  ## Tests if a view is valid to be drawn on-screen. 
  let width = view.rect.dimensions.width - view.rect.origin.x
  let height = view.rect.dimensions.height - view.rect.origin.y
  return view.rect != ZeroRect and (width != 0 or height != 0)

proc getIndexForViewWithName*(screen: Window, name: string): int =
  var index = 0
  var found_view = false
  for view in screen.views:
    found_view = (view.name == name)
    if found_view:
      break
    inc(index)
  if not found_view:
    return -1
  return index
  
proc getDebugViewIndex*(screen: Window): int =
  return screen.getIndexForViewWithName(ViewName_DebugConsole)

proc viewContainsPoint*(view: View, coordinate: Point): bool =
  ## Returns a boolean value of if a particular view contains a point. This
  ## is used to determine which view a mouse-click should interact with.

  #[
    This method is to determine if an arbitrary point is within a view or any of it's subviews. 
        A              B
          *----------*
          |          |
          |          |
          *----------*
        C              D
  ]#
  let ax = (view.rect.origin.x)
  let ay = (view.rect.origin.y)
  let a = Point(x: ax, y: ay)

  let bx = (view.rect.origin.x + view.rect.dimensions.width)
  let by = (view.rect.origin.y)
  let b = Point(x: bx, y: by)

  let cx = (view.rect.origin.x)
  let cy = (view.rect.origin.y + view.rect.dimensions.height)
  let c = Point(x: cx, y: cy)

  let dx = (view.rect.origin.x + view.rect.dimensions.width)
  let dy = (view.rect.origin.y + view.rect.dimensions.height)
  let d = Point(x: dx, y: dy)

  let is_within_x = (coordinate.x >= a.x and coordinate.x <= d.x)
  let is_within_y = (coordinate.y >= c.y and coordinate.y <= b.x)
  
  return is_within_x and is_within_y

proc viewIndexForPoint*(screen: Window, point: Point): int =
  ## Returns the index of the view in a screen that contains a given point.
  ## This method will return `-1` if no view can be found for the point.
  var index = 0
  var found_view = false
  for view in screen.views:
    found_view = viewContainsPoint(view, point)
    if found_view:
      break
    inc(index)
  if not found_view:
    return -1 
  return index

