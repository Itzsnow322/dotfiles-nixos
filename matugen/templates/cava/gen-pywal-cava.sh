#!/usr/bin/env bash
WAL="$HOME/.cache/wal/colors.json"
OUT="$HOME/.config/cava/config"

fg=$(jq -r '.colors.color4' "$WAL")
bg=$(jq -r '.special.background' "$WAL")

# replace the [color] section in the config
sed -i '/^\[color\]/,/^\[/{/^\[color\]/!{/^\[/!d}}' "$OUT"

sed -i '/^\[color\]/{
  n
  /^background/d
  /^foreground/d
}' "$OUT"

sed -i "s/^\[color\]/[color]\nbackground = '$bg'\nforeground = '$fg'/" "$OUT"