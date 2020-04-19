--------------------------------------------------------------------------------
module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders (noBorders)
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
--
-- This layout configuration uses two primary layouts, 'ResizableTall'
-- and 'BinarySpacePartition'.  You can also use the 'M-<Esc>' key
-- binding defined above to toggle between the current layout and a
-- full screen layout.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others = TwoPane (3/100) (1/2)

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
  [ ("M-S-q",   confirmPrompt myXPConfig "exit" (io exitSuccess))
  , ("M-S-p",     shellPrompt myXPConfig)
  , ("M-<Esc>", sendMessage (Toggle "Full"))
  , ("M-q",     restart "xmonad" True)
  , ("M-S-<Return>", return ())
  ] ++
  [("M-p " ++ k, spawn app) | (k,app) <- hotApps]

hotApps =
  [ ("w", "firefox")
  , ("d", "inkscape")
  , ("e", "emacsclient -c")
  , ("t", "alacritty")
  , ("u", "passmenu")
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
