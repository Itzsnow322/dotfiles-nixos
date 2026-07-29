#!/usr/bin/env bash
WALL_DIR="$HOME/Pictures/Wallpapers"
wall=$(find "$WALL_DIR" -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | sort | fuzzel --dmenu --prompt "󰸉 Wallpaper > ")
[ -z "$wall" ] && exit
# Reiniciar swaybg con el nuevo fondo
pkill -x swaybg
swaybg -i "$wall" -m fill &
mkdir -p "$HOME/.cache"
echo "$wall" > "$HOME/.cache/current_wallpaper"

# Regenerar paleta de colores desde el wallpaper
matugen image "$wall" --mode dark

# Reiniciar waybar para que tome los nuevos colores
pkill waybar
waybar &
kitty @ --to unix:/tmp/kitty-socket set-colors -a ~/.config/kitty/colors.conf 2>/dev/null || true
