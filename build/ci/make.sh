#!/bin/bash

export SRC_ROOT=`pwd`/../../
export BUILD_ROOT=`pwd`/build-ci

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release $SRC_ROOT
