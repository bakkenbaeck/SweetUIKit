#! /usr/bin/env bash

command="${SRCROOT}/Others/swiftformat"

OUTPUT=$($command \
--stripunusedargs closure-only \
--disable redundantReturn \
*)

if [ "$OUTPUT" ]; then
echo "$OUTPUT" >&2
fi
