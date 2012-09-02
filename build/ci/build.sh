#!/bin/bash
# for building on the commandline with ant
# mainly created to build, test, debug CI scripts without installing hudson

export JOB_NAME=hello
# note for hudson this is actually the name of the working copy directory which is regular
# however users can name them whatever they want so in order to make this regular
# workspace is one directory up from its definition in hudson (i.e. one directory up from here)
# and then SCM_PATH_MODIFIER is one directory up from that
export WORKSPACE=`pwd`/..

ant -DSCM_PATH_MODIFIER=.. $@

