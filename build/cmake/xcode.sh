#!/bin/bash

export SRC_ROOT=`pwd`/../../
export BUILD_ROOT=`pwd`/build-xcode

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

cmake -G "Xcode" $SRC_ROOT
