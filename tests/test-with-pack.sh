#!/usr/bin/env bash
set -e

tag=test

docker build -t "$tag" - << EOF_DOCKERFILE
from debian:buster

run apt-get update

run apt-get install -y locales
run echo en_US.UTF-8 UTF-8 > /etc/locale.gen
run dpkg-reconfigure locales --frontend=noninteractive

run apt-get install -y vim
run apt-get install -y git
run apt-get install -y screen

run useradd -m -s /bin/bash user
env SHELL /bin/bash
env LANG en_US.UTF-8
env LC_CTYPE en_US.UTF8

user user
run mkdir -p ~/.vim/pack/vim-haskellConcealPlus/start && \
    cd ~/.vim/pack/vim-haskellConcealPlus/start && \
    git clone https://github.com/enomsg/vim-haskellConcealPlus
run echo "syn on\nsetlocal conceallevel=2\nset concealcursor=nciv" > ~/.vimrc
# Run in screen as it handles terminal capabilities better than most of the raw
# terminals.
cmd screen vim ~/.vim/pack/vim-haskellConcealPlus/start/vim-haskellConcealPlus/demo.hs
#cmd bash
EOF_DOCKERFILE

docker run \
    -e TERM="$TERM" \
    -w /home/user \
    -it "$tag" "$@"
