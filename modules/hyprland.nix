{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
# See https://wiki.hyprland.org/Configuring/Monitors/

monitor=,highres,auto,1

exec-once = kitty & brave
# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
#exec-once = hyprpaper --config ~/myConfiguration/modules/hyprpaper.conf


# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf



# Some default env vars.
env = XCURSOR_SIZE,24

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us,gr
    kb_model =
    kb_options = 
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 3
    gaps_out = 4
    border_size = 3
    col.active_border = rgba(242424ff) rgba(d29a6bff) -180deg
    col.inactive_border = rgba(595959aa) rgba(525f66ff) -180deg
    layout = master
}

decoration {
   rounding = 2
    blur {
        enabled = false
       size = 3
       passes = 1
    }
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    bezier = testBez, 0.38, -0.6, -0.15, 1.2
    bezier = Bez, 0.36, 0, 0.66, -0.56
    bezier = best, 0.34, 1.56, 0.64, 1
    animation = windows, 1, 7, testBez
    animation = windowsOut, 1, 7, best
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
    animation = specialWorkspace, 1, 6, default, slidevert
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}
misc {

disable_hyprland_logo = true

}


# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

# Fix games
#windowrule=nomaxsize,class:^(*\.exe)$

windowrulev2 = nomaxsize, title:^(*.exe)$
windowrulev2 = tile, title:^(Wine configuration)$
windowrulev2 = forceinput, title:^(Wine configuration)$
windowrule = opacity 1.0,title:^(test)$

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = alt

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, D, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next
bind = $mainMod, Return, exec, foot
bind = $mainMod, Q, exec, kitty 
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating, 
bind = $mainMod, S, exec, rofi -show drun -show-icons
#bind = $mainMod, P, pseudo, # dwindle
#bind = $mainMod, J, togglesplit, # dwindle
bind =     , Print, exec, grim -g "$(slurp)"
bind = $mainMod, C, killactive
bind = $mainMod, F, fullscreen

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
exec-once=bash ~/myConfiguration/modules/start.sh
    '';
  };
}
