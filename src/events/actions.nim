# =======
# Imports
# =======

import os
import tables

import "../models/types.nim"
import "../models/configuration.nim"

import "../events/constants.nim"

import "../ui/view.nim"
import "../ui/textview.nim"
import "../ui/labelview.nim"
import "../ui/browserview.nim"

# =========
# Functions
# =========

proc navigateUp*(screen: Window): void = 
  return

proc navigateDown*(screen: Window): void = 
  return

proc navigateIn*(screen: Window): void = 
  let directory_path_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var directory_path_view = screen.views[directory_path_index]
  

proc navigateOut*(screen: Window): void = 
  let directory_path_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var directory_path_view = screen.views[directory_path_index]
  

proc reloadContents*(screen: Window, settings: Configuration, directory: string): void =
  let current_directory = directory.expandTilde()
  
  let directory_path_index = screen.getIndexForViewWithName(ViewName_DirectoryPath)
  var directory_path_view = screen.views[directory_path_index]
  directory_path_view = directory_path_view.setText(current_directory)
  screen.views[directory_path_index] = directory_path_view

  let directory_contents_index = screen.getIndexForViewWithName(ViewName_DirectoryContents)
  var directory_contents_view = screen.views[directory_contents_index]
  directory_contents_view = directory_contents_view.updatePath(current_directory, settings)
  screen.views[directory_contents_index] = directory_contents_view
  
