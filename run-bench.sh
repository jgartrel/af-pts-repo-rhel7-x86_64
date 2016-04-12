#!/bin/bash

##
# Function to upload test-results to s3
#
upload_results () {
  file=$(basename "$1")
  bucket=af-pts-storage
  resource="/${bucket}/test-results/${file}"
  contentType="application/x-compressed-tar"
  dateValue=`date +"%a, %d %b %Y %H:%M:%S %z"`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  s3Key=AKIAJWUYPQLEXM3UHFDA
  s3Secret=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
  signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
  curl -X PUT -T "${file}" \
    -H "Host: ${bucket}.s3.amazonaws.com" \
    -H "Date: ${dateValue}" \
    -H "Content-Type: ${contentType}" \
    -H "Authorization: AWS ${s3Key}:${signature}" \
        https://${bucket}.s3.amazonaws.com/test-results/${file}
}


# Create Base Variables
SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)
SCRIPT_NAME=$(basename "$0")
PID=$$
NOW=$(date -u +"%Y-%m-%d-%H%M")

# Phoronix Specific Settings
export TEST_RESULTS_IDENTIFIER=${HOSTNAME}-baseline-${NOW}
export TEST_RESULTS_NAME=${TEST_RESULTS_IDENTIFIER}
export MONITOR=all

# Establish some run time variables
PTS=${SCRIPT_PATH}/pts/phoronix-test-suite
RESULTS_DIR=${SCRIPT_PATH}/test-results/${TEST_RESULTS_NAME}
RUN_LOG=${SCRIPT_PATH}/test-results/${TEST_RESULTS_NAME}.log

# Run the benchmark suite
${PTS} enterprise-setup > /dev/null
${PTS} detailed-system-info > ${RUN_LOG} 2>&1
${PTS} batch-run local/af-system >> ${RUN_LOG} 2>&1
cd ${RESULTS_DIR}/..
tar -czf ${TEST_RESULTS_NAME}.tgz ${TEST_RESULTS_NAME}.log ${TEST_RESULTS_NAME}

# Upload to S3
upload_results ${TEST_RESULTS_NAME}.tgz
