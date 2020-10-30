@echo off
setlocal EnableDelayedExpansion
call .\load_env.cmd

REM +=============================================================+
REM I    PARAMETER:    floor name | current floor | target floor  I
REM +=============================================================+
set choice=%1
set curFloor=%2
set targetFloor=%3

if "%curFloor%" EQU "" (
  call :lng_usage_%dtadb_lang%
  PAUSE > nul
  EXIT /B
)

CALL :CASE_%choice%
IF ERRORLEVEL 1 (
  echo.
  call :lng_wrong_input_%dtadb_lang%
  call :lng_usage_%dtadb_lang%
  PAUSE > nul
  EXIT /B
)

endlocal & (
set "curFloor=%curFloor%"
)
goto :EOF

:CASE_relocate
:CASE_verschieben
  call :lng_change_floor_no_%dtadb_lang%
  if "%targetFloor%" EQU "" (
    call :lng_usage_%dtadb_lang%
    PAUSE > nul
    EXIT /B
  )
  if %targetFloor% GTR 0 (
    if %curFloor% LSS 0 call :Floor0
    set from=!curFloor!
    set to=%targetFloor%
    call :CHANGE_OVERGROUND_FLOOR
  ) else (
    if %targetFloor% LSS 0 (
      if %curFloor% GTR 0 call :Floor0
      set from=!curFloor!
      set to=%targetFloor%
      call :CHANGE_UNDERGROUND_FLOOR
	) else (
	  call :Floor0
	)
  )
  GOTO END_CASE
:CASE_base
:CASE_basis
  call :lng_change_floor_%dtadb_lang%
  CALL :Floor0
  GOTO END_CASE
:CASE_underground
:CASE_untergrund
  call :lng_change_floor_%dtadb_lang%
  CALL :Floor0
  call :SWIPE_UP
  GOTO END_CASE
:CASE_water
:CASE_wasser
  call :lng_change_floor_%dtadb_lang%
  CALL :Floor0
  set from=%curFloor%
  set to=%water_collector%
  call :CHANGE_OVERGROUND_FLOOR
  GOTO END_CASE
:CASE_dronebay
:CASE_drohnenbucht
  call :lng_change_floor_%dtadb_lang%
  CALL :Floor0
  set from=%curFloor%
  set to=%drones_floor%
  call :CHANGE_OVERGROUND_FLOOR
  GOTO END_CASE
:END_CASE
  GOTO :EOF # return from CALL

:SWIPE_UP
  set /A curFloor-=1
  %touchscreen% %swipe_down%
  %timeout%
  GOTO :EOF

:SWIPE_DOWN
  set /A curFloor+=1
  %touchscreen% %swipe_up%
  %timeout%
  GOTO :EOF

:Floor0
  if %curFloor% LSS 0 (
    %touchscreen% %return_to_floor0%
	%timeout%
  ) ELSE (
    if %curFloor% GTR 0 (
	  %touchscreen% %base_double_down%
	  %timeout%
	)
  )
  set curFloor=0
  GOTO :EOF

:CHANGE_OVERGROUND_FLOOR
  set floor_down=%above_floor_down%
  set floor_up=%above_floor_up%
  call :CHANGE_FLOOR
  GOTO :EOF

:CHANGE_UNDERGROUND_FLOOR
  set floor_down=%below_floor_down%
  set floor_up=%below_floor_up%
  call :CHANGE_FLOOR
  GOTO :EOF

:CHANGE_FLOOR
  if !from! LSS !to! (
    set step=+1
	set /A to-=1
  ) else (
    set step=-1
	set /A to+=1
  )
  for /L %%b in (!from!, !step!, !to!) do (
    if %%b EQU 0 (
REM Floor = 0 has no buttons for naviation
      if "!step!" EQU "+1" (
	    call :SWIPE_DOWN
	  ) else (
	    call :SWIPE_UP
	  )
	) else (
REM Floors <> 0 have buttons to go up/down
      if "!step!" EQU "+1" (
	    %touchscreen% %floor_up%
		set /A curFloor+=1
	  ) else (
	    %touchscreen% %floor_down%
		set /A curFloor-=1
	  )
	  %timeout%
	)	
  )
  goto :EOF

REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_usage_EN
  echo Parameter 1: Use the following names to specify which floor to navigate too.
  echo     base dronebay water underground relocate
  echo.
  echo Parameter 2: The current floor
  echo     positive or negative number to identify if you are over ground or under ground
  echo     use 0 if you are already in the base.
  echo.
  echo Parameter 3: only for "relocate": specifiy the floor to move by
  echo       negativ number: move to unterground floor
  echo       positiv number: move to overground floor
  echo.
  echo return:      sets a variable curFloor with the current floor.
goto :EOF
:lng_usage_DE
  echo Parameter 1: Waehle einen der folgende Namen zur Wahl der entsprechenden Etage
  echo     basis drohnenbucht wasser untergrund verschieben
  echo.
  echo Parameter 2: die aktuelle Etage
  echo     positive bzw. negative Zahl wenn die aktuelle Etage oberirdisch oder unterirdisch ist.
  echo     verwende die 0 wenn du in der Basis stehst.
  echo.
  echo Parameter 3: nur bei "verschieben": angebe der Zieletage:
  echo     negative Nummer: bewegen zur oberirdischen Ebene
  echo     positive Nummer: bewegen zur unterirdischen Ebene
  echo.
  echo rueckgabe:   setzt die Variable curFloor auf die aktulle Etage
goto :EOF
:lng_wrong_input_EN
  echo Parameter 1: Not supported floor selected: "%choice%"
goto :EOF
:lng_wrong_input_DE
  echo Parameter 1: Nicht unterstueste Etage gewaehlt: "%choice%"
goto :EOF
:lng_change_floor_EN
  echo Changing from floor %curFloor% to %choice%
goto :EOF
:lng_change_floor_DE
  echo Wechlse von Etage %curFloor% zu %choice%
goto :EOF
:lng_change_floor_no_EN
  echo Changing from floor %curFloor% to %targetFloor%
goto :EOF
:lng_change_floor_no_DE
  echo Wechlse von Etage %curFloor% zu %targetFloor%
goto :EOF