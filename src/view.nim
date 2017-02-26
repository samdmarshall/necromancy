# =======
# Imports
# =======

import sequtils

import "types.nim"
import "termbox.nim"

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
  for y_index in point.y..(point.y + size.height):
    var row = newSeq[tb_cell]()
    for x_index in point.x..(point.x + size.width):
      row.add(tb_cell())
    buffer.add(row)
  return buffer


# ================
# Public Functions
# ================

proc createViewAtPointWithSize*(point: Point, size: Size): View =
  var buffer = createInternalBuffer(point, size)
  return View(rect: Rect(origin: point, dimensions: size), isa: Plain, internalBuf: buffer)

proc createTextViewAtPointWithSize*(point: Point, size: Size): View =
  var view = createViewAtPointWithSize(point, size)
  view.isa = Text
  view.contents.text.lines = newSeq[string]()
  return view

proc createMainWindow*(): Window = 
  let full_screen = Size(width: tb_width(), height: tb_height())
  var main = createViewAtPointWithSize(ZeroPoint, full_screen)
  main.name = "main-screen"
  return Window(views: @[main])

proc createDebugView*(): View =
  let size = Size(width: tb_width(), height: 5)
  let origin = Point(x: 0, y: (tb_height() - size.height))
  var text_view = createTextViewAtPointWithSize(origin, size)
  text_view.name = "debug-console"
  return text_view

proc isViewValid*(view: View): bool =
  ## Tests if a view is valid to be drawn on-screen. 
  let width = view.rect.dimensions.width - view.rect.origin.x
  let height = view.rect.dimensions.height - view.rect.origin.y
  return view.rect != ZeroRect and (width != 0 or height != 0)

proc isDebugView*(view: View): bool =
  return view.name == "debug-console"

proc getDebugViewIndex*(screen: Window): int =
  var index = 0
  var found_view = false
  for view in screen.views:
    found_view = isDebugView(view)
    if found_view:
      break
    inc(index)
  if not found_view:
    return -1
  return index

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

