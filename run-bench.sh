#!/bin/bash

# Create Base Variables
SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)
SCRIPT_NAME=$(basename "$0")
PID=$$
NOW=$(date -u +"%Y-%m-%d-%H%M")

# Phoronix Specific Settings
export TEST_RESULTS_IDENTIFIER=${HOSTNAME}-baseline
export TEST_RESULTS_NAME=${TEST_RESULTS_IDENTIFIER}-${NOW}
export MONITOR=all

# Establish some run time variables
PTS=${SCRIPT_PATH}/pts/phoronix-test-suite
RESULTS_DIR=${SCRIPT_PATH}/test-results/${TEST_RESULTS_NAME}
RUN_LOG=${SCRIPT_PATH}/test-results/${TEST_RESULTS_NAME}.log

# Run the benchmark suite
${PTS} enterprise-setup
${PTS} detailed-system-info > ${RUN_LOG} 2>&1
${PTS} batch-run local/af-system >> ${RUN_LOG} 2>&1
cd ${RESULTS_DIR}/..
tar -czf ${TEST_RESULTS_NAME}.tgz ${TEST_RESULTS_NAME}.log ${TEST_RESULTS_NAME}
