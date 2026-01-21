{ pkgs, ... }:

{
  home.username = "aori";
  home.homeDirectory = "/home/aori";

  home.packages = with pkgs; [
    p7zip
    unzip
    nodejs
    neovim
    ripgrep
    fd
    gcc
    gnumake
    wget
    firejail
    htb-toolkit
    firefox
    jdk25_headless
    jetbrains-toolbox
    jetbrains.idea
    jetbrains.pycharm
    tree
    gamemode
    python3
    jetbrains.rust-rover
    onlyoffice-desktopeditors
    rustup
    tor-browser
    brave
    discord
    nmap
    mpv
    pear-desktop
    yt-dlp
    ffmpeg
    openvpn
    sqlmap
    thunderbird
    whatsapp-electron
    torsocks
    wireshark-qt
    burpsuite
    obsidian
    macchanger
    fastfetch
    zenity
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

    shellAliases = {
      yt-mp3 = "yt-dlp -x --audio-format mp3 --audio-quality 0";
      yt-premium = "yt-dlp --cookies-from-browser firefox";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
