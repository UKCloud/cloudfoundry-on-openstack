#!/usr/bin/env bash

sudo -H -u ubuntu /tmp/prepare.sh

status=$?
if [ $status -ne 0 ]; then
  CONTINUE_URL --data-binary '{"status": "FAILURE"}'
else
  CONTINUE_URL --data-binary '{"status": "SUCCESS"}'
fi

