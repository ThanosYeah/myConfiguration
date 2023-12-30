{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.65";
    cursor = lib.mkForce "#f1c232";
    cursor_shape = lib.mkForce "block";
    font_size = lib.mkForce "12";
  };
}
