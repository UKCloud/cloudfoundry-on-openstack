#!/usr/bin/env bash

sudo  -i -H -u ubuntu /tmp/prepare.sh

status=$?
if [ $status -ne 0 ]; then
  echo "SCRIPT FAILED WITH STATUS $status"
  CONTINUE_URL --data-binary '{"status": "FAILURE", "data" : "BOSH_MICRO_ERROR"}'
else
  echo "SCRIPT COMPLETED SUCCESFULLY"
  CONTINUE_URL --data-binary '{"status": "SUCCESS", "data" : "BOSH_MICRO_SUCCESS" }'
fi

