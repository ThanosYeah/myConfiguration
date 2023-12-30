{ config, pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    ls = "eza --icons -l -T -L=1";
#    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild switch --flake ~/myConfiguration/#myNixos";
 #   home-manager = "systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=16000M -p CPUQuota=60% home-manager switch";
  };
in
{
 # programs.zsh = {
#    enable = true;
#  enableAutosuggestions = true;
 #   enableCompletion = true;
  #  syntaxHighlighting.enable = true;
   # shellAliases = myAliases;
    #initExtra = ''
   # PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
   #  %F{green}→%f "
   # RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
   # [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
   # '';
  #};

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
      eza     direnv nix-direnv
  ];

  programs.direnv.enable = true;
  #programs.direnv.enableZshIntegration = true; Enable this if using zsh
  programs.direnv.nix-direnv.enable = true;
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = pkgs.lib.importTOML ./starship.toml;
  };


}
