-- xmonad config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config
{-# LANGUAGE OverloadedStrings #-}

import System.IO
import System.Exit
import System.Environment (lookupEnv, setEnv)
import Control.Concurrent (threadDelay)
import Graphics.X11.ExtraTypes.XF86
import XMonad hiding ( (|||) ) -- for JumpToLayout
import XMonad.Core
import XMonad.Prompt
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Named
import XMonad.Layout.Renamed
import XMonad.Layout.Fullscreen
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.NoBorders
import XMonad.Layout.BoringWindows
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.Accordion
import XMonad.Layout.DragPane
import XMonad.Hooks.Minimize
import XMonad.Layout.Minimize
import XMonad.Actions.Minimize
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle
import XMonad.Layout.Circle
import XMonad.Layout.Cross
import XMonad.Layout.Magnifier
import XMonad.Layout.IfMax
import XMonad.Layout.MagicFocus
-- import XMonad.Layout.Hidden
import XMonad.Layout.Maximize
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.PerWorkspace
import XMonad.Actions.Commands
import XMonad.Actions.Submap
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.SpawnOn
import XMonad.Actions.FloatKeys
import XMonad.Actions.OnScreen (viewOnScreen)
import XMonad.Util.Run(spawnPipe, safeSpawn, runProcessWithInput)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Ungrab (unGrab)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Control.Monad.Fix
import Control.Lens.Tuple
import Control.Lens
import Data.Text (Text)
import Data.Maybe (fromMaybe)
-- import DBusWrapper
-- import RingDBus

------------------------------------------------------------------------

(?) :: Bool -> a -> a -> a
True ? a = const a
False ? a = id

instance Read a => Read (Layout a) where
  readsPrec = readsPrec

myTerminal = "alacritty"
myAltTerminal = "emacsclient -c -e '(+eshell/here)'"
myEditor = "emacsclient -c"
myAltEditor = myTerminal ++ " -e nvim"
myImageEditor = "gimp"
myAltImageEditor = "inkscape"
myWebBrowser = "firefox"
myAltWebBrowser = "chromium"
myAltShiftWebBrowser = "google-chrome-stable"
myPreviewer = "zathura"
myMusic = "spotify"
myMail = "astroid"
-- mySignal = "chromium --profile-directory=Default --app-id=bikioccmkafdpakkkcpdbppfkghcmihk"
mySignal = "signal-desktop"
myDringctrlAll s = "dringctrl --get-call-list | xargs -I _ dringctrl " ++ s ++ " _"
myRenameWindow name = "xdotool getactivewindow set_window --name " ++ name

-- The command to lock the screen or show the screensaver.
myScreensaver = ""

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "$(yeganesh -x -- -fn '-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*' -nb '#000000' -nf '#FFFFFF' -sb '#7C7C7C' -sf '#CEFFAC')"


------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces =
   ["E"] ++
   map (("F" ++) . show) [1..12]
   ++
   map show [1..9]
   ++
   ["0"]
   ++
   ["-","="]
   ++
   map (:[]) ['a'..'z']
   ++
   ["_"]
   ++
   ["[","]","\\",";","'",",",".","/"]

myWorkSpaceKeys =
   [xK_F1..xK_F11] ++ [xK_F12]
   ++
   [xK_1..xK_9]
   ++
   [xK_0]
   ++
   [xK_minus,xK_equal]
   ++
   [xK_a..xK_z]
   ++
   [xK_space]
   ++
   [xK_bracketleft,xK_bracketright,xK_backslash,xK_semicolon,xK_apostrophe,xK_comma,xK_period,xK_slash]


------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll [isFullscreen --> (doF W.focusDown <+> doFullFloat)]
    -- [ className =? "Chromium"       --> doShift "2:web"
    -- , className =? "Google-chrome"  --> doShift "2:web"
    -- , resource  =? "desktop_window" --> doIgnore
    -- , className =? "Galculator"     --> doFloat
    -- , className =? "Steam"          --> doFloat
    -- , className =? "Gimp"           --> doFloat
    -- , resource  =? "gpicview"       --> doFloat
    -- , className =? "MPlayer"        --> doFloat
    -- , className =? "VirtualBox"     --> doShift "4:vm"
    -- , className =? "Xchat"          --> doShift "5:media"
    -- , className =? "stalonetray"    --> doIgnore
    -- , isFullscreen --> (doF W.focusDown <+> doFullFloat)]


------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

-- instance Read (Layout a) where
--   readsPrec d r = readsPrec d r
--
--
--

myLayout =
  -- foldl (\a x -> (\l -> Layout (onWorkspace x (renamed [Append x] l) $ a l))) id myWorkspaces $
  -- Layout $
  -- workspaceDir "~" $
  foldl1 (\a x -> Layout (a ||| x)) $
    map (\(n,w) -> Layout $ named n 
                          . maximize 
                          . minimize 
                          . boringWindows 
                          $ w) $
                            [ ("Full",        Layout (avoidStruts Full))
                            , ("Tabs",        Layout (avoidStruts $ tabbed shrinkText tabConfig))
                            , ("FFull",       Layout (noBorders $ fullscreenFull Full))
                            ]
                         ++ map (\(n,w) -> (n, Layout ((IfMax 1 <*> magnifiercz mag) . avoidStruts $ w)))
                              [ ("Spiral",      Layout (spiral (6/7)))
                              , ("ThreeColumn", Layout (ThreeColMid 1 (3/100) (1/3)))
                              , ("ThreeRow",    Layout (Mirror (ThreeColMid 1 (3/100) (1/3))))
                              , ("Vertical",    Layout (Tall 1 (3/100) (1/2)))
                              , ("Horizontal",  Layout (Mirror (Tall 1 (3/100) (1/2))))
                              , ("Grid",        Layout (Grid))
                              , ("Flip Grid",   Layout (Mirror Grid))
                              , ("Accordion",   Layout (Accordion))
                              , ("TwoColumn",   Layout (TwoPane 0.1 0.5))
                              , ("TwoRow",      Layout (Mirror (TwoPane 0.1 0.5)))
                              , ("Circle",      Layout (Circle))
                              , ("Cross",       Layout (simpleCross))
                              -- , ("Magic",       Layout (magicFocus . Mirror $ Tall 1 (3/100) (4/5)))
                              ]
    where mag = 1 --0.996

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
-- myNormalBorderColor  = "#7c7c7c"
-- myFocusedBorderColor = "#ffb6b0"
myNormalBorderColor  = "#9c9c9c"
myFocusedBorderColor = "#CEFFAC"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- Width of the window border in pixels.
myBorderWidth = 1


------------------------------------------------------------------------
-- Key bindings
myModMask = mod4Mask
altMask = mod1Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  -- Lock the screen using command specified by myScreensaver.
  -- , ((modMask .|. controlMask, xK_l),
  --    spawn myScreensaver)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  [ ((modMask .|. shiftMask, xK_p),
     unGrab >> spawn myLauncher)

  , ((modMask, xK_Print),
     spawn "scrot")

  , ((modMask .|. controlMask, xK_Print),
     spawn "scrot /tmp/%y-%m-%d.png -e 'xclip -selection clipboard -t image/png $f'")

  , ((modMask .|. altMask, xK_Print),
     spawn "scrot -u")

  , ((modMask .|. altMask .|. controlMask, xK_Print),
     spawn "scrot /tmp/%y-%m-%d.png -u -e 'xclip -selection clipboard -t image/png $f'")

  , ((modMask .|. shiftMask, xK_Print),
     unGrab >> spawn "scrot -s")

  , ((modMask .|. shiftMask .|. controlMask, xK_Print),
     unGrab >> spawn "scrot /tmp/%y-%m-%d.png -s -e 'xclip -selection clipboard -t image/png $f'")

  -- brightness down/up
  , ((modMask .|. controlMask, xK_j),
     spawn "mybacklight - 10")
  , ((modMask .|. controlMask, xK_k),
     spawn "mybacklight + 10")

  -- Music
  -- Mute volume.
  , ((modMask .|. altMask, xK_m),
     spawn "amixer -q set Master toggle")
  , ((0, xF86XK_AudioMute),
     spawn "amixer -q set Master toggle")

  -- Mute microphone.
  , ((modMask .|. controlMask, xK_m),
     spawn "amixer -q set Capture toggle")
  , ((0, xF86XK_AudioMicMute),
     spawn "amixer -q set Capture toggle")

  -- Decrease volume.
  , ((modMask .|. altMask, xK_j),
     spawn "amixer -q set Master 5%-")
  , ((0, xF86XK_AudioLowerVolume),
     spawn "amixer -q set Master 5%-")

  -- Increase volume.
  , ((modMask .|. altMask, xK_k),
     spawn "amixer -q set Master 5%+")
  , ((0, xF86XK_AudioRaiseVolume),
     spawn "amixer -q set Master 5%+")

  -- Windows
  -- Close focused window.
  , ((modMask, xK_BackSpace),
     kill)
  -- flip colors
  , ((modMask, xK_Tab),
     spawn "xrandr-invert-colors")

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp)

  -- Move focus to the master window.
  , ((modMask, xK_Return),
     windows W.focusMaster)

  -- Swap the focused window and the master window.
  , ((modMask .|. shiftMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- mod-t      -- Enters floating-window-manipulation mode
  -- <ESC>      -- exit mode
  -- hjkl       -- move window
  -- shift-hjkl -- resize window
  -- t          -- sink into tiling layer and exit mode
  -- TODO: Make <escape> cancel movement (and move it back) and <space> confirm and drop it where it is
  , ((modMask, xK_t),
     fix (\cmd ->
       submap . M.fromList $
         map (\(a,b,c) -> (a, b >> (c ? cmd $ return ())))
         [ ((0, xK_Escape),    return (),                                        False)
         , ((0, xK_h),         withFocused $ keysMoveWindow (-10,   0),          True)
         , ((0, xK_j),         withFocused $ keysMoveWindow (  0,  10),          True)
         , ((0, xK_k),         withFocused $ keysMoveWindow (  0, -10),          True)
         , ((0, xK_l),         withFocused $ keysMoveWindow ( 10,   0),          True)
         , ((shiftMask, xK_h), withFocused $ keysResizeWindow (-10,   0) (0, 0), True)
         , ((shiftMask, xK_j), withFocused $ keysResizeWindow (  0,  10) (0, 0), True)
         , ((shiftMask, xK_k), withFocused $ keysResizeWindow (  0, -10) (0, 0), True)
         , ((shiftMask, xK_l), withFocused $ keysResizeWindow ( 10,   0) (0, 0), True)
         , ((0, xK_t),         withFocused $ windows . W.sink,                   False)
         ]))

  -- mod-m         -- Enters mouse-move mode
  -- <ESC>         -- exit mode
  -- hjkl          -- move mouse
  -- shift-hjkl    -- mouse move fast
  -- alt-hjkl      -- mouse move precise
  -- m             -- move mouse to center of screen
  -- alt-m         -- move mouse to center of active window
  -- space         -- mouse click 1
  -- alt-space     -- mouse click 2
  -- shift-space   -- mouse click 2
  -- alt-shift-j/k -- scroll up/down
  , ((modMask, xK_m),
     fix (\cmd ->
       submapDefault (cmd) . M.fromList $
         map (\(a,b,c) -> (a, b >> (c ? cmd $ return ())))
         [ ((0, xK_Escape),                return (),                                                        False)
         , ((0, xK_h),                     spawn "xdotool mousemove_relative -- -30 0",                      True)
         , ((0, xK_j),                     spawn "xdotool mousemove_relative --  0  30",                     True)
         , ((0, xK_k),                     spawn "xdotool mousemove_relative --  0 -30",                     True)
         , ((0, xK_l),                     spawn "xdotool mousemove_relative --  30 0",                      True)
         , ((shiftMask, xK_h),             spawn "xdotool mousemove_relative -- -80 0",                      True)
         , ((shiftMask, xK_j),             spawn "xdotool mousemove_relative --  0  80",                     True)
         , ((shiftMask, xK_k),             spawn "xdotool mousemove_relative --  0 -80",                     True)
         , ((shiftMask, xK_l),             spawn "xdotool mousemove_relative --  80 0",                      True)
         , ((altMask, xK_h),               spawn "xdotool mousemove_relative -- -5  0",                      True)
         , ((altMask, xK_j),               spawn "xdotool mousemove_relative --  0  5",                      True)
         , ((altMask, xK_k),               spawn "xdotool mousemove_relative --  0 -5",                      True)
         , ((altMask, xK_l),               spawn "xdotool mousemove_relative --  5  0",                      True)
         , ((0, xK_m),                     spawn "xdotool mousemove --polar  0 0",                           True)
         , ((altMask, xK_m),               spawn "xdotool getwindowfocus mousemove --window %1 --polar 0 0", True)
         , ((0, xK_space),                 spawn "xdotool click --clearmodifiers 1",               False)
         -- , ((0, xK_space),                 runProcessWithInput "xdotool" ["click", "--clearmodifiers", "1"] "" >>= (\_ -> return ()),    True)
         -- , ((0, xK_space),                 runProcessWithInput "sleep" ["4"] "" >>= (\a -> io . spawn $ "echo " ++ show a),    True)
         , ((altMask, xK_space),           spawn "xdotool click --clearmodifiers 2",           True)
         , ((altMask .|. shiftMask, xK_j), spawn "xdotool click --clearmodifiers 4",           True)
         , ((altMask .|. shiftMask, xK_k), spawn "xdotool click --clearmodifiers 5",           True)
         ]))

  , ((modMask .|. shiftMask, xK_m),
     unGrab >> spawn "keynav start")

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  , ((modMask .|. shiftMask, xK_grave),
     changeDir def)

  --  minimize window
  , ((modMask .|. shiftMask, xK_minus),
     withFocused minimizeWindow)

  -- restore minimized window
  , ((modMask, xK_minus),
     withLastMinimized maximizeWindow)

  -- maximize window
  , ((modMask .|. shiftMask, xK_equal),
     withFocused (sendMessage . maximizeRestore))

  -- switch to window layouts
  , ((modMask, xK_backslash), submap . M.fromList $
    map (over _2 (sendMessage . JumpToLayout))
    [ ((shiftMask, xK_2),             "Spiral")
    , ((0, xK_3),                     "ThreeColumn")
    , ((altMask, xK_3),               "ThreeRow")
    , ((0, xK_slash),                 "Vertical")
    , ((0, xK_minus),                 "Horizontal")
    , ((0, xK_t),                     "Tabs")
    , ((0, xK_f),                     "Full")
    , ((0, xK_1),                     "Full")
    , ((shiftMask, xK_3),             "Grid")
    , ((shiftMask .|. altMask, xK_3), "Flip Grid")
    , ((0, xK_2),                     "TwoColumn")
    , ((altMask, xK_2),               "TwoRow")
    , ((shiftMask, xK_f),             "FFull")
    , ((0, xK_o),                     "Circle")
    , ((0, xK_equal),                 "Accordion")
    , ((shiftMask, xK_equal),         "Cross")
    -- , ((shiftMask, xK_minus),         "Magic")
    ])

  -- start prompt for emojis
  , ((modMask .|. shiftMask, xK_o),
     unGrab >> spawn "emoji")

  -- copy preset emojis to clipboard
  , ((modMask, xK_o), submap . M.fromList $
    map (over _2 $ \e -> spawn ("printf \'" ++ e ++ "\' | xsel -ib"))
      [ ((0, xK_s), "¯\\_(ツ)_/¯")
      , ((altMask, xK_s), "🤷")
      , ((0, xK_e), "<.<")
      , ((altMask, xK_e), "👀")
      ])

  -- System
  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))
  -- , ((modMask .|. shiftMask, xK_q),
  --    return ())

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  -- , ((modMask, xK_q),
  --    return ())

  -- start prompt for xmonad commands
  , ((modMask .|. shiftMask, xK_x),
     runCommand =<< defaultCommands)

  -- open preset processes
  , ((modMask, xK_p), submap . M.fromList $
    map (over _2 spawnHere)
      [ ((0,                     xK_e), myEditor)
      , ((altMask,               xK_e), myAltEditor)
      , ((0,                     xK_w), myWebBrowser)
      , ((altMask,               xK_w), myAltWebBrowser)
      , ((altMask .|. shiftMask, xK_w), myAltShiftWebBrowser)
      , ((0,                     xK_p), myPreviewer)
      , ((0,                     xK_m), myMail)
      , ((0,                     xK_t), myTerminal)
      , ((altMask,               xK_t), myAltTerminal)
      , ((0,                     xK_i), myImageEditor)
      , ((altMask,               xK_i), myAltImageEditor)
      ]
    ++ 
      [ ((0,       xK_comma), submap . M.fromList $ 
        map (\(a,b) -> (a, spawnHere b))
          [ ((shiftMask, xK_s), "skypeforlinux")
          , ((0,         xK_d), "Discord")
          , ((0,         xK_s),  mySignal)
          , ((0,         xK_m), "messengerfordesktop")
          , ((0,         xK_t), myTerminal ++ " -e ssh proqqul -t 'tmux attach-session -t talk'")
          ])
      ])

  , ((modMask .|. shiftMask, xK_y),
    spawnHere  "LAYOUT=$(cat /run/current-system/sw/share/X11/xkb/rules/base.lst | sed '/! layout/,/^$/!d' | sed '1d' | dmenu | awk '{print $1}') if $LAYOUT; then setxkbmap us,$LAYOUT && xkb-switch -s $LAYOUT; fi")

  -- switch to preset languages
  , ((modMask, xK_y), submap . M.fromList $
    map (over _2 $ spawnHere . (\la -> "setxkbmap us," -- "us" so that keyboard shortcuts work properly
                                        ++ la 
                                        ++" && xkb-switch -s " ++ la)) -- switch to that layout
      [ ((0, xK_y), "us") -- english (y is default)
      , ((0, xK_h), "il") -- hebrew
      , ((0, xK_e), "epo") -- esperanto
      -- , ((0, xK_k), "sy") -- kurdish
      ])

  -- copy
  , ((modMask, xK_c),
     spawn "xsel -op | xsel -ib")

  -- paste
  , ((modMask, xK_v),
     spawn "sleep 0.5; xdotool getwindowfocus type --delay 30 --clearmodifiers --window %@ \"$(xsel -ob)\"")

  ]
  ++

  -- mod-N, Switch to workspace N
  -- mod-shift-N, Move client to workspace N
  [ ((m .|. modMask, k), removeEmptyWorkspaceAfterExcept myWorkspaces $ windows $ f i)
  | (i, k) <- zip (map show [0..9]) [xK_0..xK_9]
  , (f, m) <- [(viewOnScreen 0, 0), (W.shift, altMask), (swapWithCurrent, controlMask)]]
  ++

  -- mod-space <letter>, Switch to workspace <letter>
  -- mod-shift-space <letter>, Move client to workspace <letter>
  [((m .|. modMask, xK_space), submap . M.fromList $
                            [ ((0, k), removeEmptyWorkspaceAfterExcept myWorkspaces $ windows $ f i)
                            | (i, k) <- zip (tail myWorkspaces) myWorkSpaceKeys]
   )
  | (f, m) <- [(viewOnScreen 0, 0), (W.shift, altMask), (swapWithCurrent, controlMask)]]
  ++

  [((m .|. shiftMask .|. modMask, xK_space),
    removeEmptyWorkspaceAfterExcept myWorkspaces $ withWorkspace defaultXPConfig $ (>>) <$> addHiddenWorkspace <*> (windows . f))
  | (f, m) <- [(viewOnScreen 0, 0), (W.shift, altMask), (swapWithCurrent, controlMask)]]
  ++

  -- mod-` will swap workspaces F1..F10 with 1..0
  [((modMask, xK_grave),
    windows . foldl (.) id $ 
      map (uncurry swapWorkspaces) $
        zip (map (("F" ++) . show) [1..10]) 
            (map show [1..9] ++ ["0"])
   )]
  ++
  

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, altMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]


------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--


------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    screenWorkspace 1 >>= flip whenJust (windows . W.view)
    windows $ W.greedyView "E"
    screenWorkspace 0 >>= flip whenJust (windows . W.view)

myHandleEventHook = docksEventHook <+> minimizeEventHook


------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  -- TODO: don't hard code home folder
  path <- lookupEnv "PATH"
  setEnv "PATH" (fromMaybe "" path ++ ":/home/qolen/bin") 

  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad . ewmh $ defaults {
      logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "
      }
      , manageHook = manageDocks <+> manageSpawn <+> myManageHook
      , startupHook = setWMName "LG3D" <+> myStartupHook
  }


------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = smartBorders $ myLayout,
    manageHook         = myManageHook,
    startupHook        = myStartupHook,
    handleEventHook    = myHandleEventHook
}
