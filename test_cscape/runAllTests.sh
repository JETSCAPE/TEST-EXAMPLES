#!/bin/bash
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
STATUS=0
for CONFIG in "$HERE"/config/*.xml; do
  "$HERE/runTest.sh" "$@" -c "$CONFIG" || STATUS=1
done
exit "$STATUS"
