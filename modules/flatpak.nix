{ config, inputs, pkgs, lib, ... }:

{
  options = {
    flatpakPackages = lib.mkOption {
      default = "com.usebottles.bottles";
      type = lib.types.str;
      description = ''
        Packages to be installed from flathub
      '';
    };
  };

  config = {
    home.file."flatpak.sh".source =
      let
        script = pkgs.writeShellScriptBin "flatpak.sh" ''
          ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &
          ${pkgs.flatpak}/bin/flatpak install flathub ${config.flatpakPackages}
        '';
      in
      "${script}/bin/flatpak.sh";
  };
}
