#!/usr/bin/env bash


echo "UPDATING WAIT CONDITION WITH STATUS: $1"
CONTINUE_URL --data-binary '{"status": "$1"}'

