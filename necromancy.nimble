# Package
version = "0.1"
author = "Samantha Marshall"
description = "a quick and simple file system navigator"
license = "BSD 3-Clause"

srcDir = "src/"

bin = @["necromancy"]

skipExt = @["nim"]

# Dependencies
requires "nim >= 0.16.0"
requires "yaml"
