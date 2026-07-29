#!/usr/bin/env bash
COLORS="$HOME/.config/matugen/colors.json"
HYPR_COLORS="$HOME/.config/hypr/colors.conf"

if [ ! -f "$COLORS" ]; then
  echo "No colors file found"
  exit 1
fi

PRIMARY=$(jq -r '.primary' "$COLORS" | sed 's/#//')
OUTLINE=$(jq -r '.outline_variant' "$COLORS" | sed 's/#//')

cat > "$HYPR_COLORS" << EOF
general {
  col.active_border = rgba(${PRIMARY}33)
  col.inactive_border = rgba(${OUTLINE}22)
}
EOF

# Reload hyprland
hyprctl reload

# Reload kitty
kill -SIGUSR1 $(pgrep kitty) 2>/dev/null || true

# Reload waybar
pkill waybar && waybar &