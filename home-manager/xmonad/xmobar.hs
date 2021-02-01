-- xmobar config used by Taeer Bar-Yam
-- Author: Taeer Bar-Yam

-- Config { font = "xft:Fira Code-8,unifont:size=10"
Config { font = "xft:GohuFont:size=8:antialias=false,Fira Code-8:antialias=true,unifont:size=10:antialias=true"
       , bgColor = "#000000"
       , fgColor = "#ffffff"
       , position = Static { xpos = 0, ypos = 0, width = 1920, height = 15 }
       , lowerOnStart = True
       , commands = [ Run StdinReader
                    -- , Run Memory ["-t","Mem: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFC0"] 200
                    , Run Date "%0Y年%m月%d日 星期%u  <fc=#FFFFFF>%H:%M</fc>" "date" 10
                    , Run BatteryN ["BAT0"] [ "-t","<acstatus>"
                                            , "-L","35"
                                            , "-H","85"
                                            , "-l","#FFB6B0"
                                            , "-h","#CEFFAC"
                                            , "-n","#FFFFC0"
                                            , "-W","15"
                                            , "-b","□"
                                            , "-f","■"
                                            , "--"
                                            , "-O","<fc=#CEFFAC>⚡</fc><leftbar>"
                                            , "-o","<fc=#FF594A>⧗</fc><leftbar>"
                                            , "-i","<leftbar>"
                                            ] 20 "battery0"
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       -- , template = "%StdinReader% }{ [%kbd%] %mutestate% %mail_notifications% <fc=#CBCBCB>%battery0%%battery1%</fc> <fc=#DDDDDD>%date_formatted%</fc> <fc=#FFB6B0>%shabbat%</fc>%suspend_if_late%"
       -- , template = "%StdinReader% }{ [%kbd%] %mutestate% %mail_notifications% <fc=#DDDDDD>%date_formatted%</fc> <fc=#FFB6B0>%shabbat%</fc>%suspend_if_late%"
       , template = "%StdinReader% }{  <fc=#CBCBCB>%battery0%</fc> %date%"
       }
