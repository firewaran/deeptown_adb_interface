@echo off
setlocal EnableDelayedExpansion
set script_home="%CD%"

call %script_home%\detect_devices.cmd %script_home%

:start
cls
echo.
echo +===========================+
echo I Interface Testing Suite   I
echo +===========================+
echo.
echo   [de] deutsch
echo   [en] english
echo.
echo   [e] exit testing Suite
echo.
set /P choice=Option: 

Call :CASE_%choice%
if errorlevel 1 (
  goto :start
)

EXIT /B

goto :EOF
:CASE_de
  echo.
  echo Stelle die Ansicht auf Ebene 0, weiter mit beliebieger Taste wenn bereit...
  echo.
  PAUSE > nul
  set newLang=DE
  call :switch_language
  call :start_test
goto :EOF
:CASE_en
  echo.
  echo Focus the view on Area 0, continue with any key when ready...
  echo.
  PAUSE > nul
  set newLang=EN
  call :switch_language
  call :start_test
goto :EOF
:CASE_e

goto :EOF
:start_test
  call :select_floor_%choice%
  call :select_building_%choice%  
  call :select_bot_%choice%
  call :select_action_%choice%
  call :select_chem_search_%choice%
  call :select_ress_%choice%

goto :EOF
:select_chem_search_en
echo **************** select action
set func1=search
set param1=silicon sulfur sodium nitrogen
call %script_home%\select_floor.cmd underground 0
call %script_home%\select_building.cmd chemi 1
call :test_select_chem_search
call %script_home%\select_floor.cmd base %curFloor%

echo please rate the result, then press any key to continue
pause > nul

goto :EOF
:select_chem_search_de
echo **************** waehle aktionen
set func1=suchen
set param1=silizium schwefel natrium stickstoff
call %script_home%\select_floor.cmd untergrund 0
call %script_home%\select_building.cmd chemi 1
call :test_select_chem_search
call %script_home%\select_floor.cmd basis %curFloor%

echo bitte beurteile das Ergebnis, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

goto :EOF
:test_select_chem_search
  for %%a in (%param1%) do (
	call %script_home%\select_func.cmd %func1%
	call %script_home%\select_chem_search.cmd %%a
  )

goto :EOF
:select_ress_en
echo **************** select ressource
REM +--------------------------------------------+
set func1=actions
set func2=mine

call %script_home%\select_floor.cmd dronebay 0

set param1="obsidian" "titanium skip" "helium skip" "amber" "amethyst skip" "ruby skip" "gold" "diamond skip"
call :test_select_ress
echo please verify bots assignment, then press any key to continue
pause > nul

set param1="platinum skip" "aluminium" "topaz skip" "coal skip" "copper" "iron skip" "alexandrite skip" "silver"
call :test_select_ress
echo please verify bots assignment, then press any key to continue
pause > nul

set param1="uranium skip" "emerald skip" "sapphire"
call :test_select_ress
call %script_home%\select_floor.cmd base %curFloor%

echo please verify bots assignment, then press any key to continue
pause > nul

goto :EOF
:select_ress_de
echo **************** waehle rohstoff
REM +--------------------------------------------+
set func1=aktionen
set func2=abbauen
call %script_home%\select_floor.cmd drohnenbucht 0

set param1="obsidian" "titanerz skip" "helium skip" "bernstein" "amethyst skip" "rubin skip" "gold" "diamant skip"
call :test_select_ress
echo bitte pruefe die Bots ob sie die Aufgaben erledigen, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

set param1="platin skip" "aluminium" "topas skip" "kohle skip" "kupfer" "eisen skip" "alexandrit skip" "silber"
call :test_select_ress
echo bitte pruefe die Bots ob sie die Aufgaben erledigen, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

set param1="uran skip" "smaragd skip" "saphir"
call :test_select_ress
call %script_home%\select_floor.cmd base %curFloor%

echo bitte pruefe die Bots ob sie die Aufgaben erledigen, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

goto :EOF
:test_select_ress
  set bot=1
  REM get a bunch of values "ress" "ress skip" "ress skip"
  REM each "" group will be one loop
  for %%a in (%param1%) do (
    set entry=%%a
    set entry=!entry:~1,-1!
    set ress=none
    set skip=noskip	
	set i=1
	REM prepared one group item and removed "" to parse each element
    for %%b in (!entry!) do ( 
	  if !i! EQU 1 set ress=%%b
	  if !i! EQU 2 set skip=%%b
	  set /A i+=1
	)
    call %script_home%\select_bot.cmd !bot!
	call %script_home%\select_func.cmd %func1%
	call %script_home%\select_action.cmd %func2% 
    call %script_home%\select_ress.cmd !ress! !skip!
	set /A bot+=1
  )  

goto :EOF
:select_action_en
echo **************** select action
set func1=actions
set param1=collect smelt craft garden water oil jewel chemi
call %script_home%\select_floor.cmd dronebay 0
call :test_select_action
call %script_home%\select_floor.cmd base %curFloor%

echo please verify bots assignment and position back on Area 0, then press any key to continue
pause > nul

:select_action_de
echo **************** waehle aktionen
set func1=aktionen
set param1=sammeln schmelzen handwerk gartenbau wasser oel juwelen chemi
call %script_home%\select_floor.cmd drohnenbucht 0
call :test_select_action
call %script_home%\select_floor.cmd basis %curFloor%

echo bitte pruefe die Bots ob sie die Aufgaben erledigen und wieder auf Ebene 0 fukusieren, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

goto :EOF
:test_select_action
  set bot=1
  for %%a in (%param1%) do (
    call %script_home%\select_bot.cmd !bot!
	call %script_home%\select_func.cmd %func1%
	call %script_home%\select_action.cmd %%a
	set /A bot+=1
  )

goto :EOF
:select_bot_en
echo **************** select drone
set param1=1 2 3 4 5 6 7 8 9
call %script_home%\select_floor.cmd dronebay 0
call :test_select_bot
call %script_home%\select_floor.cmd base %curFloor%

echo please verify drones are idling and position back on Area 0, then press any key to continue
pause > nul

goto :EOF
:select_bot_de
echo **************** waehle drohne
set param1=1 2 3 4 5 6 7 8 9
call %script_home%\select_floor.cmd drohnenbucht 0
call :test_select_bot
call %script_home%\select_floor.cmd basis %curFloor%

echo bitte pruefe das die Drohnen keine Aufgaben erledigen und kehre auf Ebene 0 zurueck, anschliessend mit druecken beliebieger Taste fortsetzen.
pause > nul

goto :EOF
:test_select_bot
  for %%a in (%param1%) do (
    call %script_home%\select_bot.cmd %%a
  )

goto :EOF
:select_floor_en
echo **************** select floor
set param1=dronebay underground water base
set curFloor=0
call :test_select_floor

echo check results, then press any key to continue
pause > nul

set param3=-3 +5 +8 0 +1 -3 -5 0
set func1=relocate
call :test_select_floor_relocate

echo check results, then press any key to continue
pause > nul

goto :EOF
:select_floor_de
echo **************** waehle etage
set param1=drohnenbucht untergrund wasser basis
set curFloor=0
call :test_select_floor

echo bitte pruefe die ergebnise, anschliessend beliebige Taste druecken.
pause > nul

set curFloor=0

set param3=-3 +5 +8 0 +1 -3 -5 0
set func1=verschieben
call :test_select_floor_relocate

echo bitte pruefe die ergebnise, anschliessend beliebige Taste druecken.
pause > nul

goto :EOF
:test_select_floor
  for %%a in (%param1%) do (
    call %script_home%\select_floor.cmd %%a !curFloor!
  )
  
goto :EOF
:test_select_floor_relocate
  for %%a in (%param3%) do (
    call %script_home%\select_floor.cmd %func1% !curFloor! %%a
  )

goto :EOF
:select_building_en
echo **************** select building
set param1=oil
set param2=1 2
call %script_home%\select_floor.cmd underground 0
call :test_select_building
call %script_home%\select_floor.cmd base %curFloor%

echo check results, then press any key to continue
pause > nul

goto :EOF
:select_building_de
echo **************** waehle gebaude
set param1=oel
set param2=1 2
call %script_home%\select_floor.cmd untergrund 0
call :test_select_building
call %script_home%\select_floor.cmd basis %curFloor%

echo bitte pruefe die ergebnise, anschliessend beliebige Taste druecken.
pause > nul

goto :EOF
:test_select_building
  for %%a in (%param1%) do (
    for %%b in (%param2%) do (
	  call %script_home%\select_building.cmd %%a %%b
	)    
  )

REM +--------------------------------------------+
REM I Rewrite the language setting in the config I
REM +--------------------------------------------+
goto :EOF
:switch_language
  echo ---------------- loading test environment [%newLang%] -----------------
  call update_env.cmd %script_home%\load_env.cmd dtadb_lang %newLang%
goto :EOF