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

  echo $1

  CURRENT_BRANCH=`git symbolic-ref -q --short HEAD || git describe --tags --exact-match`
  DEFAULT_BRANCH=${CURRENT_BRANCH:-master}
  BRANCH=${1:-$DEFAULT_BRANCH}

  echo $BRANCH
  printf "${BLUE}Cloning Oh My Jazzy Markdown...${NORMAL}\n"
  env git clone --depth=1  -b $BRANCH https://github.com/brightdigit/jazzy-markdown.git $JMD || {
    printf "Error: git clone of jazzy-markdown repo failed\n"
    exit 1
  }

  cp $JMD/build-docs.sh .
}

main $1