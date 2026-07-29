{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
     ./modules/wallpaper-scripts.nix
  ];
  system.stateVersion = "24.11";
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nixpkgs.config.allowUnfree = true;
  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true; # necesario por el ESP compartido con Ventoy
  boot.loader.efi.canTouchEfiVariables = true;
  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Time & Locale
  time.timeZone = "America/Bogota";
  i18n.defaultLocale = "es_CO.UTF-8";
  # User
  users.users.mj = {
    isNormalUser = true;
    description = "mj";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };
  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      export STARSHIP_CONFIG=/etc/starship.toml
      starship init fish | source
    '';
  };


  # Niri
  programs.niri.enable = true;
  # uwsm para manejo de sesión (recomendado para niri)
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.niri = {
    prettyName = "Niri";
    comment = "Niri compositor managed by uwsm";
    binPath = "/run/current-system/sw/bin/niri-session";
  };
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
services.displayManager.defaultSession = "niri-uwsm";
  # Audio
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  # AMD
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.gamemode.enable = true;
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.10"
  ];
  # Gnome services
  services.gnome.gnome-keyring.enable = true;
  services.tumbler.enable = true;
  services.gnome.gnome-software.enable = true;
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Misc services
  services.flatpak.enable = true;
  services.fwupd.enable = true;
  services.fstrim.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.xwayland.enable = true;
  programs.dconf.enable = true; 
  services.earlyoom.enable = true;
  # AppImage
  # AppImage / Wine / Proton
programs.nix-ld = {
  enable = true;
  libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    nspr
    openssl
    curl
    expat
    vulkan-loader
    libGL
    libxkbcommon
    xorg.libX11
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    alsa-lib
    dbus
  ];
};

  # PAM - swaylock reemplaza a hyprlock
  security.pam.services.swaylock = {};
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.niri.default = [ "gnome" "gtk" ];
    config.common.default = [ "gtk" ];
  };

   # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # Wayland env
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
  environment.etc."starship.toml".source = ./starship.toml;
  environment.systemPackages = with pkgs; [
    # Shell
    starship
    fish
    # Terminal
    kitty
    fastfetch
    btop
    git
    curl
    wget
    unzip
    eza
    bat
    ripgrep
    fzf
    zoxide
    cava
    tty-clock
    mapscii
    cmatrix
    gtop
    ani-cli
    gparted
    anydesk
    wlogout    

#Pentesting / Cibersecurity 
   nmap
   hydra
   metasploit
   radare2 yara
   chntpw  
   nodejs_20

    # Niri ecosystem 
    swaybg          
    swaylock       
    swayidle        
    xwayland-satellite 
    waybar
    fuzzel
    swaynotificationcenter
    cliphist
    wl-clipboard
    playerctl
    bibata-cursors
    papirus-icon-theme
    brightnessctl
    quickshell
    matugen
    swayosd
    rofi
    socat
    jq
    # File manager
    nautilus
    file-roller
    loupe
    ffmpegthumbnailer
    gnome-disk-utility
    glib
    gsettings-desktop-schemas
    papirus-icon-theme
    nwg-look
    # Browser / Apps
    firefox
    vscode
    mpv
    spotify
    discord
    brave

    # Audio
    pavucontrol
    wireplumber


    # Network
    networkmanagerapplet
    # Screenshots (grim+slurp funcionan igual en niri)
    grim
    slurp
    libnotify
    # Gaming
    lutris
    mangohud
    vulkan-tools
    nspr
    nss
    steam-run
    jdk17
    
    # AppImage
    appimage-run
    fuse
    fuse3
    desktop-file-utils
    xdg-utils
    wineWowPackages.stable
    nspr
    nss
 ];

}
