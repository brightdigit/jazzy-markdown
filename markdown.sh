#!/usr/bin/env bash

DIR=$1

echo "Convert Files from HTML to Markdown..."

find $DIR -name "*.html" -exec bash -c 'mv "$1" "${1%.html}".md' - '{}' \;

rm -r -f $DIR/docsets
rm -f $DIR/index.md
rm -f $DIR/README.md

echo "Fixing All URL Links..."

find $DIR -type f -exec sed -i '' -e 's/\.html)/\.md)/g; s/\.html"/\.md"/g; s/\.html#/\.md#/g;' {} \;