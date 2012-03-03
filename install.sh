#!/bin/sh

set -e

git submodule update --init --recursive

mv ~/.vimrc ~/.vimrc.backup
ln -s .vim/vimrc ~/.vimrc
