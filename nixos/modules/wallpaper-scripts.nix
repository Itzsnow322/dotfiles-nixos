{ pkgs, config, ... }:
let
  wallpaperScript = pkgs.writeShellScriptBin "niri-random-wallpaper" ''
    pkill -f swaybg 2>/dev/null || true
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    pkill waybar; ${pkgs.waybar}/bin/waybar &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  selectWallpaper = pkgs.writeShellScriptBin "niri-select-wallpaper" ''
    walp=$(find "$HOME/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" \) | ${pkgs.bemenu}/bin/bemenu)
    [ -n "$walp" ] && pkill -f swaybg 2>/dev/null || true
    [ -n "$walp" ] && echo "$walp" > ~/.cache/current-wallpaper
    [ -n "$walp" ] && ${pkgs.swaybg}/bin/swaybg -m "fill" -i "$walp" &
    [ -n "$walp" ] && ${pkgs.matugen}/bin/matugen image "$walp" --mode dark
    [ -n "$walp" ] && ${pkgs.pywal}/bin/wal -i "$walp" -n -q
    [ -n "$walp" ] && bash ~/.config/matugen/templates/btop/gen-pywal-btop.sh
    [ -n "$walp" ] && bash ~/.config/matugen/templates/cava/gen-pywal-cava.sh
    pkill waybar; ${pkgs.waybar}/bin/waybar &
    [ -n "$walp" ] && pkill -USR1 cava 2>/dev/null || true
    [ -n "$walp" ] && pkill -USR1 kitty 2>/dev/null || true
  '';

  toggleWaybarNiri = pkgs.writeShellScriptBin "niri-toggle-waybar" ''
    if pgrep -f "bin/waybar" > /dev/null; then
      pkill -f "bin/waybar"
    else
      ${pkgs.waybar}/bin/waybar &
    fi
  '';
in
{
  environment.systemPackages = [ wallpaperScript selectWallpaper toggleWaybarNiri ];
}
