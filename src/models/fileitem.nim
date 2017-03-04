# ======
# Import
# ======

import os

# =====
# Types
# =====

type FileItem* = object
  parent: string
  data: tuple[kind: PathComponent, path: string]

type FileType {.pure.} = enum
  File,
  Executable,
  Directory,
  Symlink,

# =========
# Functions
# =========

proc getFullPath*(file: FileItem): string =
  return os.joinPath(file.parent, file.data.path)

proc getInfo*(file: FileItem): FileInfo =
  return os.getFileInfo(getFullPath(file))

proc resolveFileType(file: FileItem): FileType =
  let info = getInfo(file)
  case file.data.kind
  of pcDir:
    return FileType.Directory
  of pcFile:
    if FilePermission.fpUserExec in info.permissions:
      return FileType.Executable
    return FileType.File
  else:
    return FileType.Symlink

proc getDecorator(file: FileItem): string =
  case resolveFileType(file)
  of FileType.File:
    return ""
  of FileType.Executable:
    return "*"
  of FileType.Directory:
    return "/"
  of FileType.Symlink:
    var expanded_path: string
    try:
      expanded_path = os.expandSymlink(file.data.path)
    except:
      expanded_path = "???"
    return " -> " & expanded_path

proc getName*(file: FileItem): string = 
  return file.data.path & getDecorator(file)

proc populate*(directory: string): seq[FileItem] = 
  var items = newSeq[FileItem]()
  for item in os.walkDir(directory, relative = true):
    let fi = FileItem(parent: directory, data: item)
    items.add(fi)
  return items
