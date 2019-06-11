# Package
version = "0.1"
author = "Samantha Marshall"
description = "a quick and simple file system navigator"
license = "BSD 3-Clause"

srcDir = "src/"

bin = @["necromancy"]

skipExt = @["nim"]

# Dependencies
requires "nim >= 0.14.0"
requires "termbox"
requires "dashing >= 0.1.1"
requires "spinny"
requires "fab >= 0.4.3"
requires "progress >= 1.1.1"
