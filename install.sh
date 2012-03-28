#!/bin/sh

set -e

git submodule update --init --recursive

mv ~/.vimrc ~/.vimrc.backup
ln -s .vim/vimrc ~/.vimrc

# Compile Command-T
(cd bundle/Command-T/ruby/command-t && ruby extconf.rb && make)
