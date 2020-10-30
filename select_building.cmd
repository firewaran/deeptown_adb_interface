@echo off
setlocal
call .\load_env.cmd

REM +====================================================+
REM I    PARAMETER:       building type | visit-button # I
REM +====================================================+
set choice=%1
set visit=%2

if "%choice%" EQU "" (
  call :lng_usage_%dtadb_lang%
  PAUSE
  EXIT /B
)

if %visit% GEQ 1 (
  if %visit% LEQ 5 (
    goto :check_visit_valid
  )
)

:check_visit_invalid
echo.
call :lng_wrong_input_2_%dtadb_lang%
call :lng_usage_%dtadb_lang%
PAUSE > nul
EXIT /B

:check_visit_valid
CALL :CASE_%choice%
IF ERRORLEVEL 1 (
  echo.
  call :lng_wrong_input_1_%dtadb_lang%
  call :lng_usage_%dtadb_lang%
  PAUSE > nul
)
EXIT /B

:CASE_oil
:CASE_oel
  call :lng_visit_station_%dtadb_lang%  
  %touchscreen% %mine_buildings%
  %timeout%
  %touchscreen% %oil_stations%
  %timeout%
  CALL :CASE_VISIT_%visit%
  GOTO END_CASE
:CASE_chemi
:CASE_chemi
  call :lng_visit_station_%dtadb_lang%  
  %touchscreen% %mine_buildings%
  %timeout%
  %touchscreen% %chemical_mines%
  %timeout%
  CALL :CASE_VISIT_%visit%
  GOTO END_CASE
:END_CASE
  %timeout%
  GOTO :EOF # return from CALL

:CASE_VISIT_1
  %touchscreen% %visit1%
  GOTO :EOF
:CASE_VISIT_2
  %touchscreen% %visit2%
  GOTO :EOF
:CASE_VISIT_3
  %touchscreen% %visit3%
  GOTO :EOF
:CASE_VISIT_4
  %touchscreen% %visit4%
  GOTO :EOF
:CASE_VISIT_5
  %touchscreen% %visit5%
  GOTO :EOF

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_usage_EN
  echo Info       : only works when view is positions underground
  echo.
  echo Parameter 1: Use the following names to specify which mine building you want
  echo     oil chemi
  echo.
  echo Parameter 2: define which visit-button you want to press
  echo     1 - 5
goto :EOF
:lng_usage_DE
  echo Info       : Funktioniert nur wenn die Ansicht im untergrund positioniert ist.
  echo.
  echo Parameter 1: Verwende einen der folgenden Bezeichnungen zur auswahl unterstuetzer gebaeude
  echo     oel chemi
  echo.
  echo Parameter 2: wahle einen besuchen button
  echo     1 - 5
goto :EOF
:lng_wrong_input_1_EN
  echo Parameter 1: not supported building selected: "%choice%"
goto :EOF
:lng_wrong_input_1_DE
  echo Parameter 1: Nicht unterstuetzes Gebaeude gewaehlt: "%choice%"
goto :EOF
:lng_wrong_input_2_EN
  echo Parameter 2: Invalid value: "%visit%"
goto :EOF
:lng_wrong_input_2_DE
  echo Parameter 2: Unzulaessige Wert angegeben: "%visit%"
goto :EOF
:lng_visit_station_EN
  echo Visit building %choice% %visit%
goto :EOF
:lng_visit_station_DE
  echo Besuche Gebaeude %choice% %visit%
goto :EOF