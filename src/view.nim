# =======
# Imports
# =======

import "fileitem.nim"

# =====
# Types
# =====

type View* = object
  cwd*: string
  items*: seq[FileItem]
  active*: bool


# =========
# Functions
# =========

proc createView*(path: string): View =
  return View(cwd: path, items: fileitem.populate(path), active: false)

proc draw*(view: View): void = 
  discard
