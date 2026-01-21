{ pkgs, ... }:

{
  home.username = "aori";
  home.homeDirectory = "/home/aori";

  home.packages = with pkgs; [
    # Tools
    p7zip
    unzip
    nodejs
    neovim
    ripgrep
    fd
    gcc
    gnumake
    wget
    tree
    fastfetch
    # Browsers
    firefox
    mullvad-browser
    tor-browser
    # Programming
    jdk25_headless
    jetbrains-toolbox
    jetbrains.idea
    jetbrains.pycharm
    python3
    jetbrains.rust-rover
    rustup
    # Cyber Security
    nmap
    openvpn
    sqlmap
    torsocks
    wireshark-qt
    burpsuite
    macchanger
    firejail
    htb-toolkit
    # Media
    mpv
    pear-desktop
    ffmpeg
    # Documents
    onlyoffice-desktopeditors
    obsidian
    # Internet
    discord
    whatsapp-electron
    thunderbird
    zenity
    # Gaming
    mangohud
  ];

  programs.git = {
    enable = true;
    settings.user.name = "aori";
    settings.user.email = "aori@nixos-btw.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
