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


# =========
# Functions
# =========

proc createView*(path: string): View =
  return View(cwd: path, items: fileitem.populate(path))
