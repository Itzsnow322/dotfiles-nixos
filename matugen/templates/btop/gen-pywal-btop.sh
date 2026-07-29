#!/usr/bin/env bash
# genera btop theme desde pywal
WAL="$HOME/.cache/wal/colors.json"
OUT="$HOME/.config/btop/themes/pywal.theme"

bg=$(jq -r '.special.background' "$WAL" | sed 's/#//')
fg=$(jq -r '.special.foreground' "$WAL" | sed 's/#//')
c0=$(jq -r '.colors.color0'  "$WAL" | sed 's/#//')
c1=$(jq -r '.colors.color1'  "$WAL" | sed 's/#//')
c2=$(jq -r '.colors.color2'  "$WAL" | sed 's/#//')
c3=$(jq -r '.colors.color3'  "$WAL" | sed 's/#//')
c4=$(jq -r '.colors.color4'  "$WAL" | sed 's/#//')
c5=$(jq -r '.colors.color5'  "$WAL" | sed 's/#//')
c6=$(jq -r '.colors.color6'  "$WAL" | sed 's/#//')
c7=$(jq -r '.colors.color7'  "$WAL" | sed 's/#//')

cat > "$OUT" << EOF
theme[main_bg]="#$bg"
theme[main_fg]="#$fg"
theme[title]="#$c6"
theme[hi_fg]="#$c4"
theme[selected_bg]="#$c2"
theme[selected_fg]="#$bg"
theme[inactive_fg]="#$c0"
theme[graph_text]="#$fg"
theme[meter_bg]="#$c0"
theme[proc_misc]="#$c5"
theme[cpu_box]="#$c1"
theme[mem_box]="#$c1"
theme[net_box]="#$c1"
theme[proc_box]="#$c1"
theme[div_line]="#$c0"
theme[temp_start]="#$c2"
theme[temp_mid]="#$c3"
theme[temp_end]="#$c1"
theme[cpu_start]="#$c4"
theme[cpu_mid]="#$c5"
theme[cpu_end]="#$c6"
theme[free_start]="#$c2"
theme[free_mid]="#$c4"
theme[free_end]="#$c6"
theme[cached_start]="#$c3"
theme[cached_mid]="#$c5"
theme[cached_end]="#$c7"
theme[used_start]="#$c1"
theme[used_mid]="#$c3"
theme[used_end]="#$c5"
theme[download_start]="#$c4"
theme[download_mid]="#$c6"
theme[download_end]="#$c2"
theme[upload_start]="#$c5"
theme[upload_mid]="#$c3"
theme[upload_end]="#$c1"
theme[process_start]="#$c4"
theme[process_mid]="#$c5"
theme[process_end]="#$c6"
EOF