#!/usr/bin/env bash

mkdir $HOME/Dropbox/Yuri-Notes/!Journal/ -p && cd $HOME/Dropbox/Yuri-Notes/!Journal
noteFilename="$HOME/Dropbox/Yuri-Notes/!Journal/note-$(date +%Y-%m-%d).md"

if [ ! -f "$noteFilename" ]; then
  touch "$noteFilename"
  echo "# Notes for $(date +%Y-%m-%d)" >"$noteFilename"
fi

nvim -c "norm Go" \
	-c "norm Go## $(date +%H:%M)" \
	-c "norm G2o" \
	-c "norm zz" \
	-c "startinsert" "$noteFilename"
