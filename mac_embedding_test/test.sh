#!/bin/sh

set -e

clang \
    -fPIC \
    -shared \
    -o "$1/libtest.dylib" \
    -I"$(pwd)/$1/include/julia" \
    -DJULIA_BINDIR="\"$(pwd)/$1/bin\"" \
    "src/mac_embedding_test/lib.c" \
    "$1/lib/libjulia.dylib" \
    '-Wl,-rpath,@loader_path/lib'

clang \
    -fPIC \
    -o "$1/test" \
    "src/mac_embedding_test/test.c" \
    "$1/libtest.dylib" \
    '-Wl,-rpath,@executable_path'

lldb \
    --batch \
    --one-line run \
    --one-line-on-crash 'thread backtrace' \
    "$1/test"
