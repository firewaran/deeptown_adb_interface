german version: [README_DE.md](https://github.com/firewaran/deeptown_adb_interface/blob/main/README_DE.md)

# DeepTown ADB interface

DeepTown is a moblie game by RockBite.

The scripts help to manage
* drones
* mines

# How to use

## Requisites 

* Installed ADB client
For ADB client setup i recommend this [article](https://www.xda-developers.com/install-adb-windows-macos-linux/) on [xda-developers.com](https://www.xda-developers.com/)

* Connected Android Tablet or Phone 
Connected android device.

* Alternativley an Android Emulator with ADB support
example: Emulator included in Android Studio

## Files

### load_env.cmd

This file contains all the display positions that are needed by the various scripts.
To gather the coordinates from your devices you need to enable the Developer Settings on your phone and activate "pointer location".

to edit the file load_env.cmd right click it and open it in any editor, i recommend [notepad++](https://notepad-plus-plus.org/downloads/).

Currently only one setup is predefined:
* 1080x1920 420 dpi

### bot_tasker.cmd

Once you setup the load_env.cmd you can use this "application" to send the drones on predefines tasks including collecting oil and water.
The script will run until you stop it manually. 

### select_*.bat

These are the commands that are currently supported.
You can start the savely get an explanation.

A brief summuary:
File | Description
---- | ----
select_action | This handles the actions the drones can execute.
select_bot | Will select a bot and abort its current task.
select_building | Used the mine buildings from the menu accessable in the first underground floor.
select_chem_search | Select a ressource for a pre-selected chemical mine.
select_floors | Responsible for navigating the different floors.
select_func | The four main functions of each floor can be accessed by this script..
select_ress | Selects a ressource for a selected bot to send it to direct mine.

### mines_*.txt and arrange_mines.cmd

The mines_*.txt files can be edited and are configuartion files for the arrange_mines.cmd which moves the mines/chemical mines and even selects a given ressource - only chemical mines.

The files get overwritten by arrange_mines.cmd to reflect current position.

These files are only examples, you need to edit them with your current mine spots.

When you done that just drag your file over the arrange_mines.cmd to execute it with that setting.

### testing.cmd

used for internal testing of the different *.cmd-files

