jazzy --config .jazzy.yml -o .tmp/htmldocs
cp -rf .tmp/htmldocs docs && sh ~/.jazzy-markdown/markdown.sh docs
sh ~/.jazzy-markdown/readme.sh README.md docs docs-header.md