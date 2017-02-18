# =======
# Imports
# =======

import os

# =====
# Types
# =====

type Tab* = object
  filePath*: string
  items: seq[tuple[kind: PathComponent, path: string]]
  currentItem: int

type Window* = object
  tabs: seq[Tab]
  currentTab: int
  isInitialized*: bool

# =========
# Functions
# =========

proc getDirectoryContents*(path: string): seq[tuple[kind: PathComponent, path: string]] = 
  var contents = newSeq[tuple[kind: PathComponent, path: string]]()
  for item in os.walkDir(path, true):
      contents.add(item)
  return contents

proc addTab*(window: var Window, working_directory: string): Window = 
  let path =  os.expandFileName(working_directory)
  let contents = getDirectoryContents(path)
  let first_tab = Tab(filePath: path, items: contents, currentItem: 0)
  window.tabs.add(first_tab)
  return window

proc initializeWindow*(working_directory: string): Window =
  var window = Window(tabs: newSeq[Tab](), currentTab: 0, isInitialized: true)
  return addTab(window, working_directory)
  

iterator getTabs*(window: Window): Tab =
  for tab in window.tabs:
    yield tab

proc currentTab*(window: Window): Tab =
  if window.currentTab != -1:
    return window.tabs[window.currentTab]

iterator getItems*(tab: Tab): tuple[kind: PathComponent, path: string] = 
  for item in tab.items:
    yield item

