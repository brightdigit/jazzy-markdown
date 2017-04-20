#!/usr/bin/env bash

DIR=$1

find $DIR -name "*.html" -exec bash -c 'mv "$1" "${1%.html}".md' - '{}' \;

rm -r -f $DIR/docsets
rm -f $DIR/index.md

find $DIR -type f -exec sed -i '' -e 's/\.html)/\.md)/g; s/\.html"/\.md"/g; s/\.html#/\.md#/g;' {} \;