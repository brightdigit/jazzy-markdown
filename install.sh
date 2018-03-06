main() {
  if [ ! -n "$JMD" ]; then
    JMD=~/.jazzy-markdown
  fi

  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }

  hash jazzy >/dev/null 2>&1 || {
    echo "Error: jazzy is not installed"
    exit 1
  }

  printf "${BLUE}Cloning Oh My Jazzy Markdown...${NORMAL}\n"
  env git clone --depth=1 https://github.com/brightdigit/jazzy-markdown.git $JMD || {
    printf "Error: git clone of jazzy-markdown repo failed\n"
    exit 1
  }

  cp $JMD/build-docs.sh .
}

main