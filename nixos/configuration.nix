# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     inputs.home-manager.nixosModules.home-manager
     inputs.auto-cpufreq.nixosModules.default
     inputs.hyprland.nixosModules.default     	
       ./vm.nix
       ./podman.nix
         
    ];
  home-manager = {
   extraSpecialArgs = { inherit inputs; };
   users = {
     debian = import ../home.nix;
   };
  };
  

  # Better battery life https://github.com/AdnanHodzic/auto-cpufreq
  programs.auto-cpufreq.enable = true;
   programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "powersave";
      turbo = "auto";
    };
  };
  programs.hyprland = {
   enable = true;
   xwayland.enable = true;
 };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
 # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.theme = "${import ./sddm-theme.nix {inherit pkgs;}}";
  # services.xserver.desktopManager.plasma5.enable = true;
  # Disable KDE Plasma default apps

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  elisa
  gwenview
  okular
  oxygen
  khelpcenter
  konsole
  plasma-browser-integration
  print-manager
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
 
  # Enable CUPS to print documents.
#  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.debian = {
    isNormalUser = true;
    description = "debian";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
    #  firefox
	    #  kate
    #  thunderbird
    ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak
  services.flatpak.enable = true;
  
 
 environment.sessionVariables = {
 
  WLR_NO_HARDWARE_CURSORS = "1";
  
  NIXOS_OZONE_WL = "1";
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     home-manager
     hyprland
     libsForQt5.qt5.qtquickcontrols2 
     libsForQt5.qt5.qtgraphicaleffects
 
   ];
   xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   xdg.portal.config.common.default = "*";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

   # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.openssh.enable = false; # Disabling ssh since i dont use it
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
