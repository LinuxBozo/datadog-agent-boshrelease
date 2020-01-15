#!/usr/bin/env bash

# Unless explicitly stated otherwise all files in this repository are licensed under the Apache 2.0 License.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2017-Present Datadog, Inc.

set -e # exit immediately if a simple command exits with a non-zero status
set -u # report the usage of uninitialized variables

export NAME=${1:-$JOB_NAME}
export HOME=${HOME:-/home/vcap}
export JOB_DIR="/var/vcap/jobs/$NAME"
export PACKAGES="$JOB_DIR/packages"

export COMPONENT=${2:-$NAME}

# Setup the PATH
export PATH="$PACKAGES/$NAME/checks.d:$PACKAGES/$NAME/bin:$PACKAGES/$NAME/embedded/bin:$PATH"

# Setup the LD_LIBRARY_PATH
LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-''}
LD_LIBRARY_PATH="$PACKAGES/$NAME/embedded/lib:$LD_LIBRARY_PATH"
LD_LIBRARY_PATH="$PACKAGES/$NAME/embedded/lib/python3.7/lib-dynload:$LD_LIBRARY_PATH"
LD_LIBRARY_PATH="$PACKAGES/$NAME/embedded/lib/python3.7/site-packages:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# Python modules
PYTHONPATH=${PYTHONPATH:-''}
PYTHONPATH="$PACKAGES/$NAME/embedded/lib/python3.7:$PYTHONPATH"
PYTHONPATH="$PACKAGES/$NAME/embedded/lib/python3.7/site-packages:$PYTHONPATH"
PYTHONPATH="$PACKAGES/$NAME/checks.d:$PYTHONPATH"
PYTHONPATH="$PACKAGES/$NAME/agent/checks/libs:$PYTHONPATH"
PYTHONPATH="$PACKAGES/$NAME/agent:$PYTHONPATH"
PYTHONPATH="$PACKAGES/$NAME/embedded/lib/python3.7/lib-dynload:$PYTHONPATH"
export PYTHONPATH="$PACKAGES/$NAME/bin/agent/dist:$PYTHONPATH"

export PYTHONHOME="$PACKAGES/$NAME/embedded/"

# export directories
export LOG_DIR="/var/vcap/sys/log/$NAME"
export RUN_DIR="/var/vcap/sys/run/$NAME"
export PIDFILE="$RUN_DIR/$COMPONENT.pid"
export TMP_DIR="/var/vcap/sys/tmp/$NAME"
export TMPDIR=$TMP_DIR
export CONFD_DIR="$JOB_DIR/config/conf.d"

export LANG=POSIX

export DD_AGENT_PYTHON="$PACKAGES/$NAME/embedded/bin/python3"

set +e
set +u
