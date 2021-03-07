#!/bin/bash

set -xe

runtime=$1

source $(dirname "$0")/tc-tests-utils.sh

source $(dirname "$0")/tf_tc-vars.sh

BAZEL_TARGETS="
//native_client:libstt.so
"

if [ "${runtime}" = "tflite" ]; then
  BAZEL_BUILD_TFLITE="--define=runtime=tflite"
fi;

BAZEL_BUILD_FLAGS="${BAZEL_BUILD_TFLITE} ${BAZEL_OPT_FLAGS} ${BAZEL_EXTRA_FLAGS}"

BAZEL_ENV_FLAGS="TF_NEED_CUDA=0"
SYSTEM_TARGET=host

do_bazel_build "dbg"

export EXTRA_LOCAL_CFLAGS="-ggdb"
do_deepspeech_binary_build
