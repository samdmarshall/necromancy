# Package
version = "0.1.0"
author = "Samantha Marshall"
description = "a quick and simple file system navigator"
license = "BSD 3-Clause"

srcDir = "src/"
binDir = "build/"

bin = @["necromancy"]
installExt = @["nim"]

# Dependencies
requires "nim"
requires "termbox"
requires "commandeer"

#requires "dashing >= 0.1.1"
#requires "spinny"
#requires "fab >= 0.4.3"
#requires "progress >= 1.1.1"
