{-# LANGUAGE LambdaCase #-}
--------------------------------------------------------------------------------
module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import Control.Monad (forM_)
import XMonad
import XMonad.Actions.RotSlaves
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig

import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import System.Taffybar.Support.PagerHints (pagerHints)

--------------------------------------------------------------------------------
main = do
  xmonad $ 
       docks $
       ewmh $
       pagerHints $
       desktopConfig
         { modMask    = mod4Mask -- Use the "Win" key for the mod key
         , manageHook = myManageHook <+> manageHook desktopConfig
         , layoutHook = desktopLayoutModifiers $ myLayouts
         , logHook    = dynamicLogString def >>= xmonadPropLog
         }
         `additionalKeysP` myKeyBindings

--------------------------------------------------------------------------------
-- | Customize layouts.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $ TwoPane (3/100) (1/2)

--------------------------------------------------------------------------------
-- | Customize the way 'XMonad.Prompt' looks and behaves.  It's a
-- great replacement for dzen.
myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:monospace:size=9"
  }

-------------------------------------------------------------------------------
-- | Customize keybindings
myKeyBindings = 
  [ ("M-S-q",                  confirmPrompt myXPConfig "exit" (io exitSuccess))
  , ("M-S-p",                  shellPrompt myXPConfig)
  , ("M-<Esc>",                sendMessage (Toggle "Full"))
  , ("M-q",                    restart "xmonad" True)
  , ("M-S-<Return>",           return ())
  , ("M-S-j",                  rotSlavesDown)
  , ("M-S-k",                  rotSlavesUp)
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 0 -10%")
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 0 +10%")
  ] ++
  [("M-p " ++ k, spawn app) | (k,app) <- hotApps] ++
  [("M-r " ++ k, rotate dir) | (k,dir) <- rotateKeys]

hotApps =
  [ ("w", "firefox")
  , ("d", "inkscape")
  , ("e", "emacsclient -c")
  , ("t", "alacritty")
  , ("u", "passmenu")
  , ("p", "zathura")
  , ("a", "astroid")
  , ("v", "pavucontrol")
  ]

wacomDevices = [
    "Wacom Pen and multitouch sensor Finger touch"
  , "Wacom Pen and multitouch sensor Pen stylus"
  , "Wacom Pen and multitouch sensor Pen eraser"
  ]

data Direction = DownSideUp | UpSideUp | LeftSideUp | RightSideUp

dirToXrandr :: Direction -> String
dirToXrandr = show . \case
  DownSideUp -> 2
  UpSideUp -> 0
  LeftSideUp -> 1
  RightSideUp -> 3

dirToXsetWacom :: Direction -> String
dirToXsetWacom = \case
  DownSideUp -> "half"
  UpSideUp -> "none"
  LeftSideUp -> "ccw"
  RightSideUp -> "cw"

rotate :: Direction -> X ()
rotate dir = do
  spawn $ "xrandr -o " ++ dirToXrandr dir
  forM_ wacomDevices $ \device -> do
    spawn $ "xsetwacom set \"" ++ device ++ "\" Rotate " ++ dirToXsetWacom dir

rotateKeys = [
    ("u", UpSideUp)
  , ("d", DownSideUp)
  , ("r", RightSideUp)
  , ("l", LeftSideUp)
  ]

--------------------------------------------------------------------------------
-- | Manipulate windows as they are created.  The list given to
-- @composeOne@ is processed from top to bottom.  The first matching
-- rule wins.
--
-- Use the `xprop' tool to get the info you need for these matches.
-- For className, use the second value that xprop gives you.
myManageHook = composeOne
  [ isDialog              -?> doCenterFloat

    -- Move transient windows to their parent:
  , transience
  ]
