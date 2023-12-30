{ config, pkgs, inputs, ... }:

{

 imports = [
# ./modules/flatpak.nix #Doesnt work for some reason maybe my fault?
  ./shell/sh.nix 
  ./terminal/kitty.nix
  ./modules/hyprland.nix 
  ./modules/lf.nix  
 ];
  #flatpakPackages = "com.usebottles.bottles org.prismlauncher.PrismLauncher";
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "debian";
  home.homeDirectory = "/home/debian";
  home.pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
        #  package = pkgs.adw-gtk3;
           package = pkgs.bibata-cursors;
	   name = "Bibata-Modern-Classic";
     # name = "adw-gtk3-dark";
          size = 23;
        };
  qt.enable = true;

# platform theme "gtk" or "gnome"
qt.platformTheme = "gtk";

# name of the qt theme
qt.style.name = "breeze";

# detected automatically:
# adwaita, adwaita-dark, adwaita-highcontrast,
# adwaita-highcontrastinverse, breeze,
# bb10bright, bb10dark, cde, cleanlooks,
# gtk2, motif, plastique

# package to use
 qt.style.package = pkgs.adwaita-qt;
#gtk = {
 #       enable = true;
  #      theme = {
   #       package = pkgs.flat-remix-gtk;
    #      name = "Flat-Remix-GTK-Grey-Darkest";
     #   };
      #  iconTheme = {
       #   package = pkgs.libsForQt5.breeze-icons;
        #  name = "breeze-dark";
       # };
        #font = {
        #  name = "Sans";
         # size = 11;
       # };
     # };
#gtk = {
   # enable = true;
   # theme = {
   #   name = "adw-gtk3-dark";
  #    package = pkgs.adw-gtk3;
 #   };
#  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
   nixpkgs = {
    # You can add overlays here
    overlays = [
	 (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  # Set up fonts
  fonts.fontconfig.enable = true;
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # install certain font
    (pkgs.nerdfonts.override { fonts = ["JetBrainsMono" "FiraCode" "DroidSansMono"]; })
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.nodejs_21
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
	(pkgs.discord.override {
  # remove any overrides that you don't want
 # withOpenASAR = true;
  withVencord = true;
})  pkgs.python312
    pkgs.brave
    pkgs.neofetch
    (pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  })
) 
   pkgs.qt5.qtwayland
   pkgs.qt6.qtwayland
   pkgs.dunst
   pkgs.libnotify
   pkgs.hyprpaper
   pkgs.rofi-wayland
   pkgs.networkmanagerapplet
   pkgs.onlyoffice-bin
   pkgs.vscodium
   pkgs.gh
   (pkgs.callPackage ./bun/bunjs.nix { })
   pkgs.grim
   pkgs.slurp
   pkgs.wl-clipboard  
   ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
     
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  
  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/debian/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
   programs.git = {
    enable = true;
    userName  = "Thanos Yeah";
    userEmail = "thanoszamanopoulos@gmail.com";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
 
   
#   home.activation = {
 #   linkDesktopApplications = {
  #    after = [ "writeBoundary" "createXdgUserDirectories" ];
   #   before = [ ];
    #  data = ''
     #   rm -rf ${config.xdg.dataHome}/"applications/home-manager"
      #  mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
       # cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
     # '';
    #}; 
  #}; # */ Weird highlight bug in nano
# Neovim
   programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };
# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
