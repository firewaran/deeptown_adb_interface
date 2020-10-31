@echo off
setlocal
REM
REM +================================================================+
REM I Language / Sprache of the script output      ( DE / EN )
REM +================================================================+
set dtadb_lang=DE
REM
REM +================================================================+
REM I folder where the adb.exe is located
REM I ordner in dem die adb.exe sich befindet
REM +================================================================+
set adb_home="%appdata%\..\local\android\sdk\platform-tools\"
REM
REM +================================================================+
REM I FLOORS: the in-gmae floor number
REM I Etagen: die in-game etagen nummer
REM +================================================================+
set drones_floor=1
set water_collector=2
REM
REM +================================================================+
REM I DRONES: your current count
REM I Drohnen/Bots: deine aktuelle Anzahl
REM +================================================================+
set maxDrones=8
REM +================================================================+
REM I DRONES: Names, only for nicer output.
REM I Drohnen/Bots: Namen dein Bots, lediglich fuer schoenere ausgabe
REM +================================================================+
set bot1=Cliff (1)
set bot2=Bert (2)
set bot3=Carl (3)
set bot4=Sarah (4)
set bot5=Bob (5)
set bot6=Jack (6)
set bot7=Amy (7)
set bot8=Deanerys (8)
REM
REM +================================================================+
REM I Predefines Setups          ; put/remove REM at the beginning to enable/disable
REM I Vorgefertige Einstellungen ; setzen/entf. REM am beginn einer Zeile zum aktivieren/deaktivieren.
REM +================================================================+
goto :720x1280
rem goto :1080x1920_420
REM
REM
REM
REM
:1080x1920_420
REM +================================================================+
REM I IMPORTANT: COORDINATES ARE FOR DEVICES WITH 1080x1920 (420dpi)
REM I            YOU MUST UPDATE THEM IF YOU HAVE A DIFFERENT DISPLAY
REM I WICHTIG:   KOORDINATION BEI EINER AUFLOESUNG VON 1080x1920 (420dpi)
REM I            DU MUSST DIE WERTE ANPASSEN WENN DEIN DISPLAY ABWEICHT.
REM +================================================================+
REM
REM +================================================================+
REM I FORMAT = "tap X Y"
REM I   to get X and Y coordinates activate developer settings in
REM I   android and activate "pointer-location".
REM I   then you will see the coordinates if you tap and hold a
REM I   a position on your phone at the top.
REM I FORMAT = "tap X Y"
REM I   um die X und Y koordination zu erhalten aktiviere die entwickler optionen
REM I   unter Android und aktiviere "Zeigerposition"
REM I   Diese option zeigt die am oberen Bildschrimrand die Koordinateion
REM I   sobald du auf den Bildschirm tippst und gedrueckt haeltst.
REM +================================================================+
REM I FLOOR navigation (first floor on the right of the screen)
REM I ETAGE Navigation (erste Etage auf der rechten Seite)
REM +================================================================+
set base_double_down="tap 1000 1000"          # button with double arrow down
set above_floor_up="tap 1010 725"                   # button with arrow up
set above_floor_down="tap 1010 920"                 # button with arrow down
REM +================================================================+
REM I FLOOR navigation (first under ground floor
REM I ETAGE Navigation (erste unterirdische Etage)
REM +================================================================+
set return_to_floor0="tap 1000 600"
set below_floor_up="tap 1010 713"                   # button with arrow up
set below_floor_down="tap 1010 905"                 # button with arrow down
set mine_buildings="tap 60 1166"
REM +================================================================+
REM I MINE BUILIDNGS: Categories
REM I MINEN GEBAEUDE: KATEGORIEN
REM +================================================================+
set normal_mines="tap 160 470"
set chemical_mines="tap 320 470"
set oil_stations="tap 480 470"
REM +================================================================+
REM I MINE BUILIDNGS: Visit Buttons
REM I MINEN GEBAEUDE: Besuchen Knoepfe
REM +================================================================+
set visit1="tap 860 700"
set visit2="tap 860 900"
set visit3="tap 860 1100"
set visit4="tap 860 1300"
set visit5="tap 860 1500"
REM +================================================================+
REM I CHEMICAL MINE: Select button for Ressource
REM I CHEMISCHE MINE: Waehlen knopf für die Rohstoffe
REM +================================================================+
set chemRes1="tap 860 730"
set chemRes2="tap 860 870"
set chemRes3="tap 860 1010"
set chemRes4="tap 860 1150"
REM +================================================================+
REM I DRONES: Position                ( all other floors with stations are the same)
REM I DROHNEN/BOTS: Position          ( alle produktions etagen sind hier identisch)
REM +================================================================+
set station1_tap="tap 260 810"
set station2_tap="tap 450 810"
set station3_tap="tap 650 810"
set station4_tap="tap 820 810"
set station5_tap="tap 260 1110"
set station6_tap="tap 450 1110"
set station7_tap="tap 650 1110"
set station8_tap="tap 820 1110"
set bot_job_cancel_tap="tap 960 1560"    # the red "x" when a bot is working. / das rote "x" wenn ein Bot aktiv ist.
REM +================================================================+
REM I FLOOR FUNCTIONS:                 ( the four main buttons of the floor)
REM I ETAGEN FUNKTIONEN:               ( die vier haupt knoepfe der Etage)
REM +================================================================+
set action1="tap 140 1790"
set action2="tap 420 1790"
set action3="tap 670 1790"
set action4="tap 970 1790"
REM +================================================================+
REM I DRONES: Actions entries.
REM I         The naming and position applicable when all tasks are learned.
REM I DROHNEN/BOTS: Faehigkeiteneintraege
REM I         Namensgebung und Position wenn alle Aufgaben gelern wurden.
REM +================================================================+
REM I  FIRST PAGE:
set collect_tap="tap 500 670"
set smelting_tap="tap 500 815"
set crafting_tap="tap 500 960"
set garden_tap="tap 500 1095"
set water_tap="tap 500 1205"
REM I  SECOND PAGE AFTER SCROLLING DOWN:
REM I  ZWEITE SEITE NACH DEM RUNTER-SCROLLEN:
set oil_tap="tap 500 865"
set mine_tap="tap 500 993"
set jewel_tap="tap 500 1125"
set chemi_tap="tap 500 1271"
REM +================================================================+
REM I DRONE ACTION: MINE RESSOURCE, first row of ressouces, lower middle of the icon.
REM I DROHNEN/BOTS AKTION: DIREKTABBAU, Erste Reihe der Ressourcen, unteress Mittel des Icons.
REM +================================================================+
set select_resource_row1_left="tap 340 750"            # left
set select_resource_middle="tap 540 750"               # middle
set select_resource_right="tap 740 750"                # right
REM +================================================================+
REM I DRONE ACTION: MINE RESSOURCE, second row of ressouces, lower middle of the icon.
REM I DROHNEN/BOTS AKTION: DIREKTABBAU, zweite Reihe der Ressourcen, unteres Mittl des Icons.
REM +================================================================+
set select_resource_row2_left="tap 340 1023"           # left
REM +================================================================+
REM I CONFIRM-Dialog:
REM I Bestaetigungsdialog:
REM +================================================================+
set yes_tap="tap 650 1125"
set no_tap="tap 430 1125"
REM +================================================================+
REM I DRILL FLOOR:                        ( the four spells )
REM I GRABEN EBENE:                       ( die vier Zauber )
REM +================================================================+
set ability1="tap 280 1800"
set ability2="tap 440 1800"
set ability3="tap 620 1800"
set ability4="tap 790 1800"
REM +================================================================+
REM I FORMAT = "swipe X1 Y1 X2 Y2"
REM I   proceed as above, X1 and Y1 are the start and X2 and Y2 the
REM I   end point of the scroll.
REM I FORMAT = "swipe X1 Y1 X2 Y2"
REM I   vorgehensweise wie zuvor, X1 und Y1 markieren den start und X2 und Y2 den
REM I   Endpunkt des Scrollvorganges.
REM +================================================================+
set swipe_up="swipe 500 865 500 1271"
set swipe_down="swipe 500 1205 500 670"
set swipe_mine_resource_up="swipe 530 990 530 690"
set swipe_mine_resource_down="swipe 530 710 530 990"
REM
goto :continue
:720x1280
REM +================================================================+
REM I IMPORTANT: COORDINATES ARE FOR DEVICES WITH 1080x1920 (420dpi)
REM I            YOU MUST UPDATE THEM IF YOU HAVE A DIFFERENT DISPLAY
REM I WICHTIG:   KOORDINATION BEI EINER AUFLOESUNG VON 1080x1920 (420dpi)
REM I            DU MUSST DIE WERTE ANPASSEN WENN DEIN DISPLAY ABWEICHT.
REM +================================================================+
REM
REM +================================================================+
REM I FORMAT = "tap X Y"
REM I   to get X and Y coordinates activate developer settings in
REM I   android and activate "pointer-location".
REM I   then you will see the coordinates if you tap and hold a
REM I   a position on your phone at the top.
REM I FORMAT = "tap X Y"
REM I   um die X und Y koordination zu erhalten aktiviere die entwickler optionen
REM I   unter Android und aktiviere "Zeigerposition"
REM I   Diese option zeigt die am oberen Bildschrimrand die Koordinateion
REM I   sobald du auf den Bildschirm tippst und gedrueckt haeltst.
REM +================================================================+
REM I FLOOR navigation (first floor on the right of the screen)
REM I ETAGE Navigation (erste Etage auf der rechten Seite)
REM +================================================================+
set base_double_down="tap 666 666"          # button with double arrow down
set above_floor_up="tap 673 483"                   # button with arrow up
set above_floor_down="tap 673 613"                 # button with arrow down
REM +================================================================+
REM I FLOOR navigation (first under ground floor
REM I ETAGE Navigation (erste unterirdische Etage)
REM +================================================================+
set return_to_floor0="tap 666 400"
set below_floor_up="tap 673 475"                   # button with arrow up
set below_floor_down="tap 673 603"                 # button with arrow down
set mine_buildings="tap 40 777"
REM +================================================================+
REM I MINE BUILIDNGS: Categories
REM I MINEN GEBAEUDE: KATEGORIEN
REM +================================================================+
set normal_mines="tap 107 313"
set chemical_mines="tap 213 313"
set oil_stations="tap 320 313"
REM +================================================================+
REM I MINE BUILIDNGS: Visit Buttons
REM I MINEN GEBAEUDE: Besuchen Knoepfe
REM +================================================================+
set visit1="tap 573 467"
set visit2="tap 573 600"
set visit3="tap 573 733"
set visit4="tap 573 867"
set visit5="tap 573 1000"
REM +================================================================+
REM I CHEMICAL MINE: Select button for Ressource
REM I CHEMISCHE MINE: Waehlen knopf für die Rohstoffe
REM +================================================================+
set chemRes1="tap 573 487"
set chemRes2="tap 573 580"
set chemRes3="tap 573 673"
set chemRes4="tap 573 767"
REM +================================================================+
REM I DRONES: Position                ( all other floors with stations are the same)
REM I DROHNEN/BOTS: Position          ( alle produktions etagen sind hier identisch)
REM +================================================================+
set station1_tap="tap 173 540"
set station2_tap="tap 300 540"
set station3_tap="tap 433 540"
set station4_tap="tap 547 540"
set station5_tap="tap 173 740"
set station6_tap="tap 300 740"
set station7_tap="tap 433 740"
set station8_tap="tap 547 740"
set bot_job_cancel_tap="tap 640 1040"    # the red "x" when a bot is working. / das rote "x" wenn ein Bot aktiv ist.
REM +================================================================+
REM I FLOOR FUNCTIONS:                 ( the four main buttons of the floor)
REM I ETAGEN FUNKTIONEN:               ( die vier haupt knoepfe der Etage)
REM +================================================================+
set action1="tap 93 1193"
set action2="tap 280 1193"
set action3="tap 447 1193"
set action4="tap 647 1193"
REM +================================================================+
REM I DRONES: Actions entries.
REM I DROHNEN/BOTS: Faehigkeiteneintraege
REM +================================================================+
REM I  FIRST PAGE:
set collect_tap="tap 333 447"
set smelting_tap="tap 333 543"
set crafting_tap="tap 333 640"
set garden_tap="tap 333 730"
set water_tap="tap 333 803"
REM I  SECOND PAGE AFTER SCROLLING DOWN:
REM I  ZWEITE SEITE NACH DEM RUNTER-SCROLLEN:
set oil_tap="tap 333 577"
set mine_tap="tap 333 662"
set jewel_tap="tap 333 750"
set chemi_tap="tap 333 847"
REM +================================================================+
REM I DRONE ACTION: MINE RESSOURCE, first row of ressouces, lower middle of the icon.
REM I DROHNEN/BOTS AKTION: DIREKTABBAU, Erste Reihe der Ressourcen, unteress Mittel des Icons.
REM +================================================================+
set select_resource_row1_left="tap 227 500"            # left
set select_resource_middle="tap 360 500"               # middle
set select_resource_right="tap 493 500"                # right
REM +================================================================+
REM I DRONE ACTION: MINE RESSOURCE, second row of ressouces, lower middle of the icon.
REM I DROHNEN/BOTS AKTION: DIREKTABBAU, zweite Reihe der Ressourcen, unteres Mittl des Icons.
REM +================================================================+
set select_resource_row2_left="tap 227 682"           # left
REM +================================================================+
REM I CONFIRM-Dialog:
REM I Bestaetigungsdialog:
REM +================================================================+
set yes_tap="tap 433 750"
set no_tap="tap 287 750"
REM +================================================================+
REM I DRILL FLOOR:                        ( the four spells )
REM I GRABEN EBENE:                       ( die vier Zauber )
REM +================================================================+
set ability1="tap 187 1200"
set ability2="tap 293 1200"
set ability3="tap 413 1200"
set ability4="tap 527 1200"
REM +================================================================+
REM I FORMAT = "swipe X1 Y1 X2 Y2"
REM I   proceed as above, X1 and Y1 are the start and X2 and Y2 the
REM I   end point of the scroll.
REM I FORMAT = "swipe X1 Y1 X2 Y2"
REM I   vorgehensweise wie zuvor, X1 und Y1 markieren den start und X2 und Y2 den
REM I   Endpunkt des Scrollvorganges.
REM +================================================================+
set swipe_up="swipe 333 577 333 847"
set swipe_down="swipe 333 803 333 447"
set swipe_mine_resource_up="swipe 353 660 353 460"
set swipe_mine_resource_down="swipe 353 473 353 660"
goto :continue
REM
REM
REM
REM
REM
REM
REM
REM
REM
REM
REM
REM
:continue
REM +================================================================+
REM I Adjust only if you have multiple devices/emulators connected at the same time.
REM I Nur anpassen wenn mehrere geraete/emulatoren zur gleichen Zeit verbunden sind.
REM +================================================================+
set device=127.0.0.1:21523
REM
REM
REM
REM
REM
REM
REM
REM
REM +================================================================+
REM I Internal options, it should not be necessary to do changes here.
REM I Interne Optionen, es sollte nicht noetig sein aenderungen vorzunehmen.
REM +================================================================+
REM
REM
REM
REM
REM
REM
REM
REM
REM
REM
set touchscreen="".\adb.exe -s %device% shell input touchscreen""
set timeout=""timeout /t 1 ^> nul""
REM
if "%dtadb_lang%" NEQ "DE" (
if "%dtadb_lang%" NEQ "EN" (
  echo Not supported language "%dtadb_lang%", fallback to english [EN]
  echo Nicht unterstuetze Sprache "%dtadb_lang%", setze Sprache auf Englisch [EN]
  echo.
set dtadb_lang=DE
))
REM
Endlocal & (
REM +================================================================+
REM I Switch to ADB Home.
REM +================================================================+
%adb_home:~1,2%
cd \
cd %adb_home%
REM +================================================================+
REM I set-variables.
REM +================================================================+
set "chemRes1=%chemRes1%"
set "chemRes2=%chemRes2%"
set "chemRes3=%chemRes3%"
set "chemRes4=%chemRes4%"
set "dtadb_lang=%dtadb_lang%"
set "maxDrones=%maxDrones%"
set "normal_mines=%normal_mines%"
set "chemical_mines=%chemical_mines%"
set "oil_stations=%oil_stations%"
set "visit1=%visit1%"
set "visit2=%visit2%"
set "visit3=%visit3%"
set "visit4=%visit4%"
set "visit5=%visit5%"
set "mine_buildings=%mine_buildings%"
set "return_to_floor0=%return_to_floor0%"
set "ability1=%ability1%"
set "ability2=%ability2%"
set "ability3=%ability3%"
set "ability4=%ability4%"
set "bot_job_cancel_tap=%bot_job_cancel_tap%"
set "select_resource_row1_left=%select_resource_row1_left%"
set "select_resource_row2_left=%select_resource_row2_left%"
set "select_resource_middle=%select_resource_middle%"
set "select_resource_right=%select_resource_right%"
set "swipe_mine_resource_up=%swipe_mine_resource_up%"
set "swipe_mine_resource_down=%swipe_mine_resource_down%"
set "action1=%action1%"
set "action2=%action2%"
set "action3=%action3%"
set "action4=%action4%"
set "base_double_down=%base_double_down%"
set "base_double_up=%base_double_up%"
set "above_floor_up=%above_floor_up%"
set "above_floor_down=%above_floor_down%"
set "below_floor_up=%below_floor_up%"
set "below_floor_down=%below_floor_down%"
set "drones_floor=%drones_floor%"
set "water_collector=%water_collector%"
set "bot1=%bot1%"
set "station1_tap=%station1_tap%"
set "bot2=%bot2%"
set "station2_tap=%station2_tap%"
set "bot3=%bot3%"
set "station3_tap=%station3_tap%"
set "bot4=%bot4%"
set "station4_tap=%station4_tap%"
set "bot5=%bot5%"
set "station5_tap=%station5_tap%"
set "bot6=%bot6%"
set "station6_tap=%station6_tap%"
set "bot7=%bot7%"
set "station7_tap=%station7_tap%"
set "bot8=%bot8%"
set "station8_tap=%station8_tap%"
set "yes_tap=%yes_tap%"
set "no_tap=%no_tap%"
set "adb_home=%adb_home%"
set "touchscreen=%touchscreen%"
set "swipe_up=%swipe_up%"
set "swipe_down=%swipe_down%"
set "collect_tap=%collect_tap%"
set "smelting_tap=%smelting_tap%"
set "crafting_tap=%crafting_tap%"
set "garden_tap=%garden_tap%"
set "water_tap=%water_tap%"
set "oil_tap=%oil_tap%"
set "mine_tap=%mine_tap%"
set "jewel_tap=%jewel_tap%"
set "chemi_tap=%chemi_tap%"
set "timeout=%timeout%" )
