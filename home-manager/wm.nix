{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  term = "${pkgs.alacritty}/bin/alacritty";
  wm_menu = "swaymsg -t get_workspaces -r | ${pkgs.jq}/bin/jq --raw-output 'map(.name) | reduce .[] as $item (\"\";. + \"\\n\" + $item)' | dmenu -b";
  left = "h";
  right = "l";
  down = "j";
  up = "k";
  waybar-mpris = pkgs.callPackage ./waybar-mpris {  };
  quickdraw = pkgs.writeShellScriptBin "quickdraw" ''
    file="/tmp/quick_draw.$RANDOM.png"
    cp ~/g/dotfiles/resources/scratch.png $file
    ${pkgs.drawing}/bin/drawing $file
    ${pkgs.wl-clipboard}/bin/wl-copy < $file
    rm $file
  '';
in
{
  xsession.windowManager.xmonad = {
    enable = false;

    extraPackages = hpkgs: with hpkgs; [
      xmonad-contrib
    ];

    enableContribAndExtras = true;
  };
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    config = {
      output."*" = {
        bg = "~/g/dotfiles/resources/nightmode.png fill";
      };
      bars = [ {
        command = "${pkgs.waybar}/bin/waybar";
      }];
      modifier = "${mod}";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };
        "1386:20808:Wacom_Pen_and_multitouch_sensor_Pen" = {
          map_to_output = "eDP-1";
        };
        "1386:20808:Wacom_Pen_and_multitouch_sensor_Finger" = {
          map_to_output = "eDP-1";
        };
      };
      floating.criteria = [
        { "app_id" = "com.github.maoschanz.drawing"; }
      ];
      keybindings = {
        "${mod}+Return" = "exec ${term}";

        # Kill focused window
        "${mod}+Backspace" = "kill";

        # Start your launcher
        "${mod}+Shift+p" = "exec \"${pkgs.rofi}/bin/rofi -modi drun,run -show drun\"";

        # Reload the configuration file
        # Exit sway (logs you out of your Wayland session)
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
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
        "${mod}+1" = "workspace \"1:comm\"";
        "${mod}+2" = "workspace \"2:media\"";
        "${mod}+3" = "workspace \"3:sys\"";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
        # Move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace \"1:comm\"";
        "${mod}+Shift+2" = "move container to workspace \"2:media\"";
        "${mod}+Shift+3" = "move container to workspace \"3:sys\"";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";
        # Note: workspaces can have any name you want, not just numbers.
        # We just use 1-10 as the default.


        "${mod}+Space" = "exec ${wm_menu} | xargs swaymsg workspace --";
        "${mod}+Shift+Space" = "exec ${wm_menu} | xargs swaymsg move container to workspace --";
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

        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";

        "${mod}+c" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";

        "${mod}+t" = "mode transform";
        "${mod}+m" = "mode music";

        "${mod}+p" = "mode launcher";

        "${mod}+o" = "mode open";

        "${mod}+q" = "mode reconfigure";
      };
      modes = {
        transform = {
          "h" = "output eDP-1 transform 270; mode default";
          "l" = "output eDP-1 transform 90; mode default";
          "k" = "output eDP-1 transform 180; mode default";
          "j" = "output eDP-1 transform 0; mode default";
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
          "Space" = "exec playerctl play-pause; mode default";
          "n" = "exec playerctl next; mode default";
          "p" = "exec playerctl previous; mode default";
        };
        launcher =  {
          "w" = "exec \"firefox\"; mode default";
          "t" = "exec ${term}; mode default";
          "e" = "exec \"emacsclient -c\"; mode default";
          "p" = "exec \"zathura\"; mode default";
          "r" = "exec \"xournalpp\"; mode default";
          "u" = "exec \"rofi-pass\"; mode default";
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

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 22;
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ ];
        modules-right = [ "custom/waybar-mpris" "tray" "network" "pulseaudio" "battery" "clock" ];
        modules = {
          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            numeric-first = true;
          };
          "pulseaudio" = {
            format = "墳 {volume}%";
          };
          "custom/waybar-mpris" = {
            "return-type" = "json";
            "exec" = "${waybar-mpris}/bin/waybar-mpris --autofocus";
            "on-click" = "${waybar-mpris}/bin/waybar-mpris --send toggle";
            "escape" = true;
          };
          "network" =  {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ifname}: {ipaddr}/{cidr} ";
            "format-disconnected" =  "Disconnected ⚠";
          };
          "battery" = {
            "interval" = 60;
            "format-icons" = ["" "" "" "" "" "" "" "" "" ""];
            "format-discharging" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% ";
            "format-unknown" = "{capacity}% ";
            "states" = {
              "critical" = 7;
            };
          };
          "tray" = {
            "spacing" = 12;
          };
        };
      }
    ];
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "Iosevka Nerd Font";
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background: transparent;
          color: white;
      }

      #window {
          font-weight: bold;
          font-family: "Ubuntu";
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: white;
          border-top: 2px solid transparent;
      }

      #workspaces button.focused {
          color: #c9545d;
          border-top: 2px solid #c9545d;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
          padding: 0 10px;
          margin: 0 2px;
      }

      #clock {
          font-weight: bold;
      }

      #battery {
      }

      #battery.critical {
          color: red
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #cpu {
      }

      #memory {
      }

      #network {
      }

      #network.disconnected {
          background: #f53c3c;
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
      }

      #custom-spotify {
          color: rgb(102, 220, 105);
      }

      #tray {
      }
   '';
  };

  programs.mako.enable = false;

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND="1";
    MOZ_USE_XINPUT2="1";
  };

  home.packages = with pkgs; [
    gnome3.adwaita-icon-theme
    rofi
    rofi-pass
    pamixer
    playerctl
    brightnessctl
    sway-contrib.grimshot
  ];
}
