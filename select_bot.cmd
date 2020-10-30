@echo off
setlocal
call .\load_env.cmd

REM +==========================================+
REM I    PARAMETER:   1 - 8                    I
REM +==========================================+
set choice=%1

if "%choice%" EQU "" (
  call :lng_usage_%dtadb_lang%
  PAUSE
  EXIT /B
)

if %choice% GTR %maxDrones% (
  EXIT /B
)

CALL :CASE_%choice%
IF ERRORLEVEL 1 (
  echo.
  call :lng_wrong_input_1_%dtadb_lang%
  call :lng_usage_%dtadb_lang%
  PAUSE > nul
)
EXIT /B

:CASE_1
  set bot_name=%bot1%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station1_tap%
  GOTO END_CASE
:CASE_2
  set bot_name=%bot2%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station2_tap%
  GOTO END_CASE
:CASE_3
  set bot_name=%bot3%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station3_tap%
  GOTO END_CASE
:CASE_4
  set bot_name=%bot4%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station4_tap%
  GOTO END_CASE
:CASE_5
  set bot_name=%bot5%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station5_tap%
  GOTO END_CASE
:CASE_6
  set bot_name=%bot6%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station6_tap%
  GOTO END_CASE
:CASE_7
  set bot_name=%bot7%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station7_tap%
  GOTO END_CASE
:CASE_8
  set bot_name=%bot8%
  call :lng_select_%dtadb_lang%
  %touchscreen% %station8_tap%
  GOTO END_CASE
:END_CASE
  %timeout%
  %touchscreen% %bot_job_cancel_tap%
  GOTO :EOF # return from CALL

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_usage_EN
  echo Parameter 1: Select the number of the bot you want to select for a task.
  echo     1 - 8
goto :EOF
:lng_usage_DE
  echo Parameter 1: Waehle mit der Nummer den Bot den Du auswaehlen moechtest.
  echo     1 - 8  
goto :EOF
:lng_wrong_input_1_EN
  echo Parameter 1: not supported bot station selected: "%choice%"
goto :EOF
:lng_wrong_input_1_DE
  echo Parameter 1: Nicht unterstuetzes Drohnenbucht gewaehlt: "%choice%"
goto :EOF
:lng_select_EN
  echo Select %bot_name%
goto :EOF
:lng_select_DE
  echo Waehle %bot_name%
goto :EOF