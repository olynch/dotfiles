{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  term = "${pkgs.alacritty}/bin/alacritty";

  left = "h";
  right = "l";
  down = "j";
  up = "k";

  quickdraw = pkgs.writeShellScriptBin "quickdraw" ''
    file="/tmp/quick_draw.$RANDOM.png"
    cp ~/g/dotfiles/resources/scratch.png $file
    ${pkgs.drawing}/bin/drawing $file
    ${pkgs.wl-clipboard}/bin/wl-copy < $file
    rm $file
  '';
  wm_menu = cmd:
    "${
      pkgs.writeShellScriptBin "wm_menu" ''
        i3-msg -t get_workspaces | ${pkgs.jq}/bin/jq --raw-output 'map(.name) | reduce .[] as $item ("";. + "\n" + $item)' | dmenu -b | ${cmd}
      ''
    }/bin/wm_menu";
  dirTrans = {
    left = "0 -1 1 1 0 0 0 0 1";
    right = "0 1 0 -1 0 1 0 0 1";
    normal = "0 0 0 0 0 0 0 0 0";
    inverted = "-1 0 1 0 -1 1 0 0 1";
  };
  xinputRotatableDevices = [
    "Wacom Pen and multitouch sensor Finger"
    "Wacom Pen and multitouch sensor Pen Pen (0xb010846f)"
    "Wacom Pen and multitouch sensor Pen Eraser (0xb010846f)"
  ];
  xinputCmd = transform: dev:
    "xinput --set-prop '${dev}' --type=float 'Coordinate Transformation Matrix' ${transform}";
  rotate = dir:
    "${
      pkgs.writeShellScriptBin "rotate-${dir}" ''
        xrandr --output eDP-1 --rotate ${dir}
        ${builtins.concatStringsSep "\n"
        (map (xinputCmd (builtins.getAttr dir dirTrans))
          xinputRotatableDevices)}
      ''
    }/bin/rotate-${dir}";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      startup = [
        { command = "i3-msg workspace 1:comm"; }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ~/.background-image";
          always = true;
          notification = false;
        }
      ];
      bars = [ ];
      modifier = "${mod}";
      keybindings = {
        "${mod}+Return" = "exec ${term}";

        # Kill focused window
        "${mod}+BackSpace" = "kill";

        # Start your launcher
        "${mod}+Shift+x" = ''exec "${pkgs.rofi}/bin/rofi -show drun"'';

        # Reload the configuration file
        # Exit sway (logs you out of your Wayland session)
        "${mod}+Shift+e" = "exit";
        #
        # Moving around:
        #
        # Move your focus around
        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";
        # Or use ${mod}+[up|down|left|right]
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move the focused window with the same, but add Shift
        "${mod}+Shift+${left}" = "move left";
        "${mod}+Shift+${down}" = "move down";
        "${mod}+Shift+${up}" = "move up";
        "${mod}+Shift+${right}" = "move right";
        # Ditto, with arrow keys
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        #
        # Workspaces:
        #
        # Switch to workspace
        "${mod}+1" = ''workspace "1:comm"'';
        "${mod}+2" = ''workspace "2:media"'';
        "${mod}+3" = ''workspace "3:sys"'';
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
        # Move focused container to workspace
        "${mod}+Shift+1" = ''move container to workspace "1:comm"'';
        "${mod}+Shift+2" = ''move container to workspace "2:media"'';
        "${mod}+Shift+3" = ''move container to workspace "3:sys"'';
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
        # Note: workspaces can have any name you want, not just numbers.
        # We just use 1-10 as the default.

        "${mod}+space" = "exec ${wm_menu "xargs i3-msg workspace --"}";
        "${mod}+Shift+space" =
          "exec ${wm_menu "xargs i3-msg move container to workspace --"}";
        #
        # Layout stuff:
        #
        # You can "split" the current object of your focus with
        # ${mod}+b or ${mod}+v, for horizontal and vertical splits
        # respectively.
        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";

        # Switch the current container between different layout styles
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # Make the current focus fullscreen
        "${mod}+f" = "fullscreen";

        # # Toggle the current focus between tiling and floating mode
        # "${mod}+Shift+space" = "floating toggle";

        # # Swap focus between the tiling area and the floating area
        # "${mod}+space" = "focus mode_toggle";

        # Move focus to the parent container
        "${mod}+a" = "focus parent";
        #
        # Scratchpad:
        #
        # Sway has a "scratchpad", which is a bag of holding for windows.
        # You can send windows there and get them back later.

        # Move the currently focused window to the scratchpad
        "${mod}+Shift+minus" = "move scratchpad";

        # Show the next scratchpad window or hide the focused scratchpad window.
        # If there are multiple scratchpad windows, this command cycles through them.
        "${mod}+minus" = "scratchpad show";
        "${mod}+r" = "mode resize";

        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" =
          "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";

        "${mod}+c" =
          "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";

        "${mod}+t" = "mode transform";
        "${mod}+m" = "mode music";

        "${mod}+x" = "mode launcher";

        "${mod}+o" = "mode open";

        "${mod}+q" = "mode reconfigure";
      };
      modes = {
        transform = {
          "h" = "exec ${rotate "left"}; mode default";
          "l" = "exec ${rotate "right"}; mode default";
          "j" = "exec ${rotate "normal"}; mode default";
          "k" = "exec ${rotate "inverted"}; mode default";
          "Escape" = "mode default";
        };
        resize = {
          # left will shrink the containers width
          # right will grow the containers width
          # up will shrink the containers height
          # down will grow the containers height
          "${left}" = "resize shrink width 10px";
          "${down}" = "resize grow height 10px";
          "${up}" = "resize shrink height 10px";
          "${right}" = "resize grow width 10px";

          # Ditto, with arrow keys
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";

          # Return to default mode
          "Return" = "mode default";
          "Escape" = "mode default";
        };
        music = {
          "space" = "exec playerctl play-pause; mode default";
          "n" = "exec playerctl next; mode default";
          "p" = "exec playerctl previous; mode default";
          "Escape" = "mode default";
        };
        launcher = {
          "x" = "exec texmacs; mode default";
          "w" = ''exec "firefox"; mode default'';
          "t" = "exec ${term}; mode default";
          "e" = ''exec "emacsclient -c"; mode default'';
          "p" = ''exec "zathura"; mode default'';
          "r" = ''exec "xournalpp"; mode default'';
          "u" = ''exec "rofi-pass"; mode default'';
          "s" = "exec ${quickdraw}/bin/quickdraw; mode default";
          "Escape" = "mode default";
        };
        open = {
          "p" = "exec ${term} -e fzf_zathura; mode default";
          "Escape" = "mode default";
        };
        reconfigure = {
          "s" = "exec ${term} -e sudo nixos-rebuild switch; mode default";
          "w" = "reload; mode default";
          "h" = "exec ${term} -e home-manager switch; mode default";
          "Escape" = "mode default";
        };
      };
    };
  };

  home.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };

  home.packages = with pkgs; [
    gnome3.adwaita-icon-theme
    rofi
    rofi-pass
    pamixer
    playerctl
    brightnessctl
    # sway-contrib.grimshot
  ];
}
