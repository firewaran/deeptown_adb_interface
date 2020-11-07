@echo off
setlocal

set dtadb_lang=%1

:retry_ress
call :lng_select_resource_%dtadb_lang%
call :%input_ress%
if errorlevel 1 (
  echo.
  call :lng_ressource_unknown_%dtadb_lang%
  goto :retry_ress
)

endlocal & (
  set "input_ress=%input_ress%"
)

goto :EOF
REM Language -EN-
:obsidian
:amber
:gold
:aluminium
:copper
:silver
:sapphire
:titanium
:amethyst
:diamond
:topaz
:iron
:uranium
:helium
:ruby
:platinum
:coal
:alexandrite
:emerald
:sapphire
REM Language -DE-
:obsidian
:bernstein
:gold
:aluminium
:kupfer
:silber
:saphir
:titanerz
:amethyst
:diamant
:topas
:eisen
:uran
:helium
:rubin
:platin
:kohle
:alexandrit
:smaragd
goto :EOF
:lng_ressource_unknown_EN
  echo Ressrouce "%input_ress%" not valid.
goto :EOF
:lng_ressource_unknown_DE
  echo Rohstoff "%input_ress%" ungueltig."
goto :EOF
:lng_select_resource_EN
  echo Use the following names of a ressource that you like to gather directly:
  echo     obsidian     titanium    helium
  echo     amber        amethyst    ruby
  echo     gold         diamond     platinum
  echo     aluminium    topaz       coal
  echo     copper       iron        alexandrite
  echo     silver       uranium     emerald
  echo     sapphire
  set /P input_ress=select ressource: 
goto :EOF
:lng_select_resource_DE
  echo Verwende einen der folgenden Rohstoff-Namen welche Du direkt abbauen lassen moechtest:
  echo     obsidian     titanerz    helium
  echo     bernstein    amethyst    rubin
  echo     gold         diamant     platin
  echo     aluminium    topas       kohle
  echo     kupfer       eisen       alexandrit
  echo     silber       uran        smaragd
  echo     saphir
  set /P input_ress=Waehle Ressource: 
goto :EOF