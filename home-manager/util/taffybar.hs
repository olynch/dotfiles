{-# LANGUAGE OverloadedStrings #-}

import System.Taffybar
import System.Taffybar.Context (TaffybarConfig(..))
import System.Taffybar.Hooks
import System.Taffybar.Information.CPU
import System.Taffybar.Information.Memory
import System.Taffybar.SimpleConfig
import System.Taffybar.Widget
import System.Taffybar.Widget.Generic.PollingGraph

main = dyreTaffybar myTaffybarConfig

transparent, yellow1, yellow2, green1, green2, taffyBlue
  :: (Double, Double, Double, Double)
transparent = (0.0, 0.0, 0.0, 0.0)
yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)
yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)
green1 = (0, 1, 0, 1)
green2 = (1, 0, 1, 0.5)
taffyBlue = (0.129, 0.588, 0.953, 1)

myTaffybarConfig :: TaffybarConfig
myTaffybarConfig =
  let myWorkspacesConfig =
        defaultWorkspacesConfig
        { minIcons = 1
        , widgetGap = 0
        , showWorkspaceFn = hideEmpty
        }
      workspaces = workspacesNew myWorkspacesConfig
      clock = textClockNewWith $ defaultClockConfig { clockFormatString = "%a %b %_d %k:%M" }
      layout = layoutNew defaultLayoutConfig
      windowsW = windowsNew defaultWindowsConfig
      -- See https://github.com/taffybar/gtk-sni-tray#statusnotifierwatcher
      -- for a better way to set up the sni tray
      tray = sniTrayNew
      myConfig = defaultSimpleTaffyConfig
        { startWidgets =
            workspaces : map (>>= buildContentsBox) [ layout, windowsW ]
        , endWidgets = map (>>= buildContentsBox)
          [ textBatteryNew "$percentage$%"
          , batteryIconNew
          , clock
          , tray
          , mpris2New
          ]
        , barPosition = Top
        , barPadding = 0
        , barHeight = 30
        , widgetSpacing = 5
        }
  in withBatteryRefresh $ withLogServer $
     withToggleServer $ toTaffyConfig myConfig
