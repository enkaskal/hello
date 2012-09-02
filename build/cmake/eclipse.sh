#!/bin/bash

export SRC_ROOT=`pwd`/../../
export BUILD_ROOT=${SRC_ROOT}/../hello-eclipse

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

cmake -G "Eclipse CDT4 - Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug $SRC_ROOT
