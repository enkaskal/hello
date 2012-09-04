#!/bin/bash

export SRC_ROOT=`pwd`/../../
export BUILD_ROOT=`pwd`/build-ci-dbg

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug $SRC_ROOT
