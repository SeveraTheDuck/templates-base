set allow-duplicate-recipes := true

[private]
default:
    @just --list

import '.just/common.just'
import? '.just/lang.just'
