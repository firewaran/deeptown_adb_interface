@echo off
setlocal
call .\load_env.cmd

REM +=====================================================+
REM I    PARAMETER:     name of task the bot should do    I                   I
REM +=====================================================+
set choice=%1

if "%choice%" EQU "" (
  CALL :lng_usage_%dtadb_lang%
  PAUSE
  EXIT /B
)

CALL :CASE_%choice%
IF ERRORLEVEL 1 (
  echo.
  CALL :lng_wrong_input_%dtadb_lang%
  CALL :lng_usage_%dtadb_lang%
  PAUSE > nul
)

EXIT /B

:CASE_collect
:CASE_sammeln
  call :lng_collect_%dtadb_lang%
  %touchscreen% %swipe_up%
  %timeout%
  %touchscreen% %collect_tap%
  GOTO END_CASE
:CASE_smelt
:CASE_schmelzen
  call :lng_smelt_%dtadb_lang%
  %touchscreen% %swipe_up%
  %timeout%
  %touchscreen% %smelting_tap%
  GOTO END_CASE
:CASE_craft
:CASE_handwerk
  call :lng_craft_%dtadb_lang%
  %touchscreen% %swipe_up%
  %timeout%
  %touchscreen% %crafting_tap%
  GOTO END_CASE
:CASE_garden
:CASE_gartenbau
  call :lng_garden_%dtadb_lang%
  %touchscreen% %swipe_up%
  %timeout%
  %touchscreen% %garden_tap%
  GOTO END_CASE
:CASE_water
:CASE_wasser
  call :lng_water_%dtadb_lang%
  %touchscreen% %swipe_up%
  %timeout%
  %touchscreen% %water_tap%
  GOTO END_CASE
:CASE_oil
:CASE_oel
  call :lng_oil_%dtadb_lang%
  %touchscreen% %swipe_down%
  %timeout%
  %touchscreen% %oil_tap%
  GOTO END_CASE
:CASE_mine
:CASE_abbauen
  call :lng_mine_%dtadb_lang%
  %touchscreen% %swipe_down%
  %timeout%
  %touchscreen% %mine_tap%
  GOTO END_CASE
:CASE_jewel
:CASE_juwelen
  call :lng_jewel_%dtadb_lang%
  %touchscreen%%swipe_down%
  %timeout%
  %touchscreen% %jewel_tap%
  GOTO END_CASE
:CASE_chemi
  call :lng_chemi_%dtadb_lang%
  %touchscreen% %swipe_down%
  %timeout%
  %touchscreen% %chemi_tap%
  GOTO END_CASE
:END_CASE
  %timeout%
  GOTO :EOF # return from CALL

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_usage_EN
  echo.
  echo Parameter 1: Use the following names to specify which task a bot should do:
  echo     collect smelt craft garden water oil mine jewel chemi
goto :EOF
:lng_usage_DE
  echo.
  echo Parameter 1: Verwende einen der folgende Begriffe zum zuweisen der Aufgabe:
  echo     sammeln schmelzen handwerk gartenbau wasser oel abbauen juwelen chemi
goto :EOF
:lng_wrong_input_EN
  echo Parameter 1: Not supported task selected: "%choice%".
goto :EOF
:lng_wrong_input_DE
  echo Parameter 1: Unbekannte Aufgabe ausgewaehlt: "%choice%".
goto :EOF
:lng_chemi_EN
  echo Boost Chemistry
goto :EOF
:lng_chemi_DE
  echo Produktion der Chemieeta
goto :EOF
:lng_jewel_EN
  echo Boost Jewelcrafting
goto :EOF
:lng_jewel_DE
  echo Erhoeht Juwelenproduk
goto :EOF
:lng_mine_EN
  echo Mine Ressources
goto :EOF
:lng_mine_DE
  echo Rohstoffe abbauen
goto :EOF
:lng_oil_EN
  echo Claim Oil
goto :EOF
:lng_oil_DE
  echo Sammelt Oel
goto :EOF
:lng_water_EN
  echo Claim Water
goto :EOF
:lng_water_DE
  echo Sammelt Wasser
goto :EOF
:lng_garden_EN
  echo Boost Gardening
goto :EOF
:lng_garden_DE
  echo Gartenbau verbessern
goto :EOF
:lng_craft_EN
  echo Boost Crafting
goto :EOF
:lng_craft_DE
  echo Handwerk verbessern
goto :EOF
:lng_smelt_EN
  echo Boost Smelting
goto :EOF
:lng_smelt_DE
  echo Schmelzen verbessern
goto :EOF
:lng_collect_EN
  echo Collect Ressources
goto :EOF
:lng_collect_DE
  echo Rohstoffe Sammeln
goto :EOF
