{ config,
lib,
pkgs,
inputs,
...
}:{
  imports =
    [
      ./hardware-configuration.nix
      inputs.mangowm.nixosModules.mango
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.systemd.tpm2.enable = false;
  systemd.tpm2.enable = false;

  networking.hostName = "nixos-dell"; 
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  time.timeZone = "America/New_York";

  services.printing.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.displayManager.ly.enable = true;
  services.libinput.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

 programs.hyprland = {
   enable = true;
   xwayland.enable = true;
 };

programs.zsh.enable = true;
  users.extraUsers.jay = {
    shell = pkgs.zsh;
  };

programs.yazi.enable = true;
programs.mango.enable = true;

 users.users.jay = {
   isNormalUser = true;
   extraGroups = [ "wheel" ];
   packages = with pkgs; [
     bibata-cursors
     luaPackages.fennel
     foot
     fuzzel
     git
     kitty
     nwg-look
     thunar
     tree
     vis
     stow
   ];
 };

 security.sudo = {
   enable = true;
   extraRules = [
     {
       users = [ "jay" ];
       commands = [
         {
           command = "ALL";
           options = [ "NOPASSWD" ];
         }
       ];
     }
   ];
 };


  environment.systemPackages = with pkgs; [
    _7zz
    afetch
    arc-theme
    bat
    brave
    eza
    fd
    ffmpeg
    fzf
    helix
    imagemagick
    jq
    pavucontrol
    poppler
    qalculate-gtk
    quickshell
    resvg
    ripgrep
    tmux
    trash-cli
    wget
    wl-clipboard
    xclip
    xdg-desktop-portal-hyprland
    xz
    zoxide 
    zsh

    inputs.helium.packages.${system}.default
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

   system.stateVersion = "25.11";
}

