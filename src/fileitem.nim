# ======
# Import
# ======

import os

# =====
# Types
# =====

type FileItem* = object
  data: tuple[kind: PathComponent, path: string]
  

# =========
# Functions
# =========

proc getName*(file: FileItem): string = 
  case file.data.kind
  of pcDir:
    return file.data.path & "/"
  else:
    return file.data.path

proc getInfo*(file: FileItem): FileInfo =
  return os.getFileInfo(file.data.path)

proc populate*(directory: string): seq[FileItem] = 
  var items = newSeq[FileItem]()
  for item in os.walkDir(directory, relative = true):
    let fi = FileItem(data: item)
    items.add(fi)
  return items
