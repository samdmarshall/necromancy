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

proc getInfo*(file: FileItem): FileInfo =
  return os.getFileInfo(file.data.path)

proc getDecorator(file: FileItem): string =
  let info = getInfo(file)
  case file.data.kind
  of pcDir:
    return "/"
  of pcFile:
    if FilePermission.fpUserExec in info.permissions:
      return "*"
  else:
    return " -> " & os.expandSymlink(file.data.path)
  return ""

proc getName*(file: FileItem): string = 
  return file.data.path & getDecorator(file)

proc populate*(directory: string): seq[FileItem] = 
  var items = newSeq[FileItem]()
  for item in os.walkDir(directory, relative = true):
    let fi = FileItem(data: item)
    items.add(fi)
  return items
