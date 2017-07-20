#!/usr/bin/env bash

docs_header=$3
docs_footer=$4
README_OUT=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
README_DIR=$(dirname $README_OUT)
docs_dir=$2
docs_relative_name=$(python -c "import os.path; print os.path.relpath('$docs_dir', '$README_DIR')")
docs_relative=$([ "$docs_relative_name" == "." ] && echo "" || echo "$docs_relative_name/")
depth=${5-2}
echo "Prepending README Header..."

cat $docs_header > $README_OUT

echo "\n\n" >> $README_OUT
yes "#" | head -n $depth | tr -d '\n' >> $README_OUT
echo " Categories\n" >> $README_OUT

echo "Outputting All Type Categories..."

rm -rf $docs_dir/css
rm -rf $docs_dir/img
rm -rf $docs_dir/js

find $docs_dir -type f -regex "$docs_dir/[^ /]*.md" -print | sed -e "s;$docs_dir;\.;g;s;[^/]*\/;;g;h;G;s;\n;]($docs_relative;;s;^;* [;g;s;$;);g;s;\.md];];g" >> $README_OUT
find $docs_dir -type f -regex "$docs_dir/Other.*.md" -print | sed -e "s;$docs_dir;\.;g;s;[^/]*\/;;g;h;G;s;\n;]($docs_relative;;s;$;);g;s;\.md];];g;s; ;%20;g;s;^;* [;g" >> $README_OUT

echo "\n"  >> $README_OUT
yes "#" | head -n $depth | tr -d '\n' >> $README_OUT
echo " Types" >> $README_OUT
for D in `find $docs_dir -type d -mindepth 1`
do
	echo "Outputting All $(basename $D)..."
	echo "\n"  >> $README_OUT
	yes "#" | head -n $((depth+1)) | tr -d '\n' >> $README_OUT
	echo " $(basename $D)\n" >> $README_OUT
    find $D/*.md -print | sed -e "s;$docs_dir/.;\.;g;s;[^/]*\/;;g;h;G;s;\n;]($docs_relative$(basename $D)\/;;s;^;* [;g;s;$;);g;s;\.md];];g" >> $README_OUT
done

[[ ! -z "$docs_footer" ]] && cat $docs_footer >> $README_OUT

rm $docs_dir/.gitignore
