# =======
# Imports
# =======

import os
import tables

import "../logger.nim"

import "../models/types.nim"
import "../models/fileitem.nim"
import "../models/configuration.nim"

import "../events/constants.nim"

import "../ui/view.nim"
import "../ui/display.nim"
import "../ui/textview.nim"
import "../ui/labelview.nim"
import "../ui/browserview.nim"
import "../ui/itemselector.nim"

# =========
# Functions
# =========

proc navigateUp*(screen: Window): void =
  let selector_index = screen.getIndexForViewWithName(ViewName_ItemSelector)
  var selector_view = screen.views[selector_index]
  if selector_view.contents.selector.index > 0:
    let browser_index = screen.getIndexForViewWithName(ViewName_DirectoryContents)
    var browser = screen.views[browser_index]
    selector_view = selector_view.moveUp(browser)
    screen.views[browser_index] = browser.updateCursor(selector_view.contents.selector.index)
  screen.views[selector_index] = selector_view

proc navigateDown*(screen: Window): void =
  let selector_index = screen.getIndexForViewWithName(ViewName_ItemSelector)
  var selector_view = screen.views[selector_index]
  if selector_view.contents.selector.index < selector_view.contents.selector.count:
    let browser_index = screen.getIndexForViewWithName(ViewName_DirectoryContents)
    var browser = screen.views[browser_index]
    selector_view = selector_view.moveDown(browser)
    screen.views[browser_index] = browser.updateCursor(selector_view.contents.selector.index)
  screen.views[selector_index] = selector_view

proc navigateIn*(screen: Window, settings: Configuration): void =
  let browser_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var browser = screen.views[browser_index]

proc navigateOut*(screen: Window, settings: Configuration): void =
  let browser_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var browser = screen.views[browser_index]
  let active_path = browser.getActivePath()
  if not active_path.isRootDir():
    let parent_path = active_path.parentDir()
    browser = browser.updatePath(parent_path, settings)
    screen.views[browser_index] = browser

proc reloadContents*(screen: Window, settings: Configuration, directory: string): Window =
  let current_directory = directory.expandTilde()

  let directory_path_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var directory_path_view = screen.views[directory_path_index]
  directory_path_view = directory_path_view.setText(current_directory)
  screen.views[directory_path_index] = directory_path_view

  let directory_contents_index = screen.getIndexForViewWithName(ViewName_DirectoryContents)
  var directory_contents_view = screen.views[directory_contents_index]
  directory_contents_view = directory_contents_view.updatePath(current_directory, settings)
  screen.views[directory_contents_index] = directory_contents_view

  let selector_index = screen.getIndexForViewWithName(ViewName_ItemSelector)
  screen.views[selector_index] = createSelectorViewFromBrowser(directory_contents_view)
  screen.views[selector_index].name = ViewName_ItemSelector

  screen.draw()

  return screen
