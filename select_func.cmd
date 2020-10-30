@echo off
setlocal
call .\load_env.cmd

REM +=====================================================+
REM I    PARAMETER:  one of the four functions of a floor I
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
  call :lng_wrong_input_%dtadb_lang%
  CALL :lng_usage_%dtadb_lang%
  PAUSE > nul
)

EXIT /B

:CASE_upgrade
  echo %choice%
  %touchscreen% %action1%
  GOTO END_CASE
:CASE_move2
:CASE_bewegen2
:CASE_boost
:CASE_erhoehen
  echo %choice%
  %touchscreen% %action2%
  GOTO END_CASE
:CASE_setup
:CASE_konfig
:CASE_move3
:CASE_bewegen3
:CASE_tech
:CASE_technologie
  echo %choice%
  %touchscreen% %action3%
  GOTO END_CASE
:CASE_actions
:CASE_aktionen
:CASE_claim
:CASE_sammeln
:CASE_craft
:CASE_handwerk
:CASE_make
:CASE_machen
:CASE_smelt
:CASE_schmelzen
:CASE_grow
:CASE_wachsen
:CASE_enrich
:CASE_anreichern
:CASE_search
:CASE_suchen
:CASE_execute
:CASE_ausfuehren
:CASE_open
:CASE_oeffnen
  echo %choice%
  %touchscreen% %action4%
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
  echo Parameter 1: Use the following names to specify which button you like to press
  echo              Depending on floor the buttons have different names.
  echo                 dronebay     : upgrade / move2 / setup / actions
  echo                 craft        : upgrade / boost / move3 / craft
  echo                 jewel        : upgrade / boost / move3 / craft
  echo                 water        : upgrade / boost / move3 / claim
  echo                 chemistry    : upgrade / boost / move3 / make
  echo                 smelting     : upgrade / boost / move3 / smelt
  echo                 green        : upgrade / boost / move3 / grow
  echo                 uranium      : upgrade / boost / move3 / enrich  
  echo                 tech         : upgrade / move2 / tech  / execute
  echo                 beacon       : -       / -     / -     / open  
  echo                 mine         : upgrade / boost / move3 / claim
  echo                 chemical mine: upgrade / boost / move3 / search  
  
goto :EOF
:lng_usage_DE
  echo Parameter 1: Waehle einen der folgenden Namen um den jeweiligen Knopf zu druecken
  echo              Abhaegig der Etage haben ise verschiedene Namen.
  echo                 drohnenbuch     : upgrade / bewegen2 / konfig      / aktionen
  echo                 handwerksgebaude: upgrade / erhoehen / bewegen3    / handwerk
  echo                 juwelier        : upgrade / erhoehen / bewegen3    / handwerk
  echo                 wasserkollektor : upgrade / erhoehen / bewegen3    / sammeln
  echo                 chemieetage     : upgrade / erhoehen / bewegen3    / machen
  echo                 schmelzhuette   : upgrade / erhoehen / bewegen3    / schmelzen
  echo                 treibhaus       : upgrade / erhoehen / bewegen3    / wachsen
  echo                 urananlage      : upgrade / erhoehen / bewegen3    / anreichern
  echo                 signalstation   : -       / -        / -           / oeffnen  
  echo                 Technologie     : upgrade / bewegen2 / technologie / ausfuehren
  echo                 chemische Mine  : upgrade / erhoehen / bewegen3    / suchen  
  echo                 normale Mine    : upgrade / erhoehen / bewegen3    / sammeln
  
goto :EOF
:lng_wrong_input_EN
  echo Parameter 1: Not supported building function selected: "%choice%"
goto :EOF
:lng_wrong_input_DE
  echo Parameter 1: Nicht unterstuetzte Gebaeudefunkion gewaehlt: "%choice%"
goto :EOF
