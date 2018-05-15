#!/usr/bin/env bash

rm -rf tars
mkdir tars

tar -cz \
--exclude='node_modules' --exclude='scripts' --exclude='test' \
--exclude='.idea' --exclude='.vscode' --exclude='coverage' --exclude='.nyc_output' \
--exclude='build/Release' --exclude='src' --exclude='.editorconfig' --exclude='.gitattributes' \
--exclude='.gitignore' --exclude='.npmignore' --exclude='.travis.yml' --exclude='suman.conf.js' \
--exclude='*.log' --exclude='*.md' --exclude='*.json' --exclude='*.DS_Store' \
. > archive.tar.gz

