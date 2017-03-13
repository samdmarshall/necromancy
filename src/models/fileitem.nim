# ======
# Import
# ======

import os

import "configuration.nim"

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
  return (file.parent).joinPath(file.data.path)

proc getInfo*(file: FileItem): FileInfo =
  return getFullPath(file).getFileInfo()

proc resolveFileType(file: FileItem): FileType =
  let info = file.getInfo()
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
  case file.resolveFileType()
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

proc getItemColor*(file: FileItem, settings: Configuration): uint16 = 
  case file.resolveFileType()
  of FileType.File:
    return settings.colors.file.normal
  of FileType.Executable:
    return settings.colors.executable.normal
  of FileType.Directory:
    return settings.colors.directory.normal
  of FileType.Symlink:
    return settings.colors.symlink.normal

proc getName*(file: FileItem): string = 
  return file.data.path & getDecorator(file)

proc populate*(directory: string, ignored: seq[string]): seq[FileItem] = 
  var items = newSeq[FileItem]()
  for item in os.walkDir(directory, relative = true):
    if item.path notin ignored:
      let fi = FileItem(parent: directory, data: item)
      items.add(fi)
  return items
