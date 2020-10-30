@echo off
setlocal
call .\load_env.cmd

REM +==========================================+
REM I    PARAMETER:    ressource | [skip]
REM I ----------------------------------------
REM I Use skip when the ressouce was seletect
REM I just before, e.g. all bots should mine
REM I the same ressource, only the first needs
REM I to position the ressouce window.
REM +==========================================+
set choice=%1
set skip=%2

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
REM +==========================================+
REM I Ressource locations:
REM I Lvl. left         middle      right
REM +-------------------------------------------
REM I   1. obsidian 	titanium 	helium
:CASE_obsidian
  call :SCROLL_TO_BEGIN
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_titanium
:CASE_titanerz
  call :SCROLL_TO_BEGIN
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_helium
  call :SCROLL_TO_BEGIN
  %touchscreen% %select_resource_right%
  GOTO END_CASE	
REM +==========================================+
REM I   2. amber 		amethyst 	ruby
:CASE_amber
:CASE_bernstein
  call :SCROLL_TO_BEGIN
  set times=1
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_amethyst
  call :SCROLL_TO_BEGIN
  set times=1
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_ruby
:CASE_rubin
  call :SCROLL_TO_BEGIN
  set times=1
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_right%
  GOTO END_CASE
REM +==========================================+
REM I   3. gold 		diamond 	platinum
:CASE_gold
  call :SCROLL_TO_BEGIN
  set times=2
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_diamond
:CASE_diamant
  call :SCROLL_TO_BEGIN
  set times=2
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_platinum
:CASE_platin
  call :SCROLL_TO_BEGIN
  set times=2
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_right%
  GOTO END_CASE	
REM +==========================================+
REM I   4. aluminium 	topaz 		coal
:CASE_aluminium
  call :SCROLL_TO_BEGIN
  set times=3
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_topaz
:CASE_topas
  call :SCROLL_TO_BEGIN
  set times=3
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_coal
:CASE_kohle
  call :SCROLL_TO_BEGIN
  set times=3
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_right%
  GOTO END_CASE	
REM +==========================================+
REM I   5. copper 		iron 		alexandrite
:CASE_copper
:CASE_kupfer
  call :SCROLL_TO_BEGIN
  set times=4
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_iron
:CASE_eisen
  call :SCROLL_TO_BEGIN
  set times=4
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_alexandrite
:CASE_alexandrit
  call :SCROLL_TO_BEGIN
  set times=4
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_right%
  GOTO END_CASE	
REM +==========================================+
REM I   6. silver		uranium 	emerald
:CASE_silver
:CASE_silber
  call :SCROLL_TO_BEGIN
  set times=5
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row1_left%
  GOTO END_CASE
:CASE_uranium
:CASE_uran
  call :SCROLL_TO_BEGIN
  set times=5
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_middle%
  GOTO END_CASE
:CASE_emerald
:CASE_smaragd
  call :SCROLL_TO_BEGIN
  set times=5
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_right%
  GOTO END_CASE	
REM +==========================================+
REM I   7. sapphire
:CASE_sapphire
:CASE_saphir
  call :SCROLL_TO_BEGIN
  set times=5
  call :SCROLL_DOWN_n_TIMES
  %touchscreen% %select_resource_row2_left%
  GOTO END_CASE	
:END_CASE
  %timeout%
  GOTO :EOF # return from CALL


:SCROLL_TO_BEGIN
  echo %choice%
  if "%skip%" NEQ "skip" (
    %touchscreen% %swipe_mine_resource_down%
    %touchscreen% %swipe_mine_resource_down%
    %timeout%
  )
  GOTO :EOF

:SCROLL_DOWN_n_TIMES
  FOR /L %%b IN (1,1,%times%) DO (
    call :SCROLL_DOWN
  )
  GOTO :EOF

:SCROLL_DOWN
  if "%skip%" NEQ "skip" (
    %touchscreen% %swipe_mine_resource_up% 5000
    %timeout%
  )
  GOTO :EOF

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_usage_EN
  echo.
  echo Parameter 1: Use the following names of a ressource that you like to gather directly:
  echo     obsidian     titanium    helium
  echo     amber        amethyst    ruby
  echo     gold         diamond     platinum
  echo     aluminium    topaz       coal
  echo     copper       iron        alexandrite
  echo     silver       uranium     emerald
  echo     sapphire
  echo.
  echo Paramter 2: [optional] Use the word "skip" if the ressource row was previously selected
goto :EOF
:lng_usage_DE
  echo.
  echo Parameter 1: Verwende einen der folgenden Rohstoff-Namen welche Du direkt abbauen lassen moechtest:
  echo     obsidian     titanerz    helium
  echo     bernstein    amethyst    rubin
  echo     gold         diamant     platin
  echo     aluminium    topas       kohle
  echo     kupfer       eisen       alexandrit
  echo     silber       uran        smaragd
  echo     saphir
  echo.
  echo Paramter 2: [optional] Verwende das Wort "skip" wenn die zeile des Rohstoffs bereits zuvor ausgewaehlt wurde.
goto :EOF
:lng_wrong_input_EN
  echo Parameter 1: Not supported ressource selected: "%choice%"
goto :EOF
:lng_wrong_input_DE
  echo Parameter 1: Nicht unterstuezten Rohstoff ausgewaehlt: "%choice%"
goto :EOF
