#!/bin/bash

export SRC_ROOT=`cygpath -a -m ../../`
export BUILD_ROOT=`pwd`/build-cygwin-dbg

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug $SRC_ROOT
