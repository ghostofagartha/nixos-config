{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # --- SILENT GHOST BOOT SETTINGS ---
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0; # Press Space or Arrow keys at boot to show menu

    consoleLogLevel = 0;
    initrd.verbose = false;
    
    # Enable Plymouth (The graphical splash screen)
    plymouth = {
      enable = true;
      theme = "breeze";
    };

    # Kernel parameters to hide all terminal text
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # --- SYSTEM CORE ---
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  time.timeZone = "Asia/Karachi";
  i18n.defaultLocale = "en_GB.UTF-8";

  # --- HARDWARE OPTIMIZATION ---
  services.fstrim.enable = true;
  zramSwap.enable = true; 
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Crucial for many Steam/Wine games
  };

  # 1. High Performance Governor
  powerManagement.cpuFreqGovernor = "performance";

  # 2. Intel Thermal Management (The Windows 11 "Secret")
  services.thermald.enable = true;

  # --- DESKTOP ENVIRONMENT (GNOME) ---
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "gb";

  # Remove GNOME Bloat
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour gnome-maps gnome-weather geary epiphany
    gnome-characters totem iagno tali hitori atomix
  ]);
  services.gnome.gcr-ssh-agent.enable = false;

  # --- GLOBAL WINE SETTINGS ---
  environment.variables = {
    WINEARCH = "win64";
    WINEPREFIX = "/home/aori/.wine"; # This makes the default prefix permanent
  };

  # Gaming Optimization
  programs.gamemode.enable = true;
  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };

  # --- AUDIO & INPUT ---
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;

  # --- USER CONFIGURATION ---
  users.users.aori = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [
    ];
  };

  # --- SYSTEM PACKAGES ---
  environment.systemPackages = with pkgs; [
    vim
    git
    wineWowPackages.stable
  ];
  
  # --- System Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];

  # --- SSH Services ---
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # --- NIX MAINTENANCE ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- NIX SETTINGS ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
