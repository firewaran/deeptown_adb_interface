@echo off
setlocal
call .\load_env.cmd

REM +==============================================================+
REM I    PARAMETER:     name of ressource the mine should search   I
REM +==============================================================+
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

:CASE_silicon
:CASE_silizium
  call :lng_silicon_%dtadb_lang%
  %touchscreen% %chemRes1%
  GOTO END_CASE
:CASE_sulfur
:CASE_schwefel
  call :lng_sulfur_%dtadb_lang%
  %touchscreen% %chemRes2%
  GOTO END_CASE
:CASE_sodium
:CASE_natrium
  call :lng_sodium_%dtadb_lang%
  %touchscreen% %chemRes3%
  GOTO END_CASE
:CASE_nitrogen
:CASE_stickstoff
  call :lng_nitrogen_%dtadb_lang%
  %touchscreen% %chemRes4%
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
  echo Parameter 1: Use the following names to specify a ressearch to search for:
  echo     silicon sulfur sodium nitrogen
goto :EOF
:lng_usage_DE
  echo.
  echo Parameter 1: Verwende einen der folgende Rohstoffe nach der gesucht werden soll:
  echo     silizium schwefel natrium stickstoff
goto :EOF
:lng_wrong_input_EN
  echo Parameter 1: Not supported ressource selected: "%choice%".
goto :EOF
:lng_wrong_input_DE
  echo Parameter 1: Unbekannter Rohstoff ausgewaehlt: "%choice%".
goto :EOF
:lng_silicon_EN
  echo Search silicon
goto :EOF
:lng_silicon_DE
  echo Suche Silizium
goto :EOF
:lng_sulfur_EN
  echo Search sulfur
goto :EOF
:lng_sulfur_DE
  echo Suche Schwefel
goto :EOF
:lng_sodium_EN
  echo Search sodium
goto :EOF
:lng_sodium_DE
  echo Suche Natrium
goto :EOF
:lng_nitrogen_EN
  echo Search nitrogen
goto :EOF
:lng_nitrogen_DE
  echo Suche Stickstoff
goto :EOF