# DeepTown ADB-Schnittstelle

DeepTown ist ein Moblie-Spiel von RockBite.

Die Skripte helfen bei der Verwaltung von
* Drohnen
* Minen

# Wie funktioniert es

## Vorbereitungen 

* Installieren eines ADB-Clients
Für die Einrichtung des ADB-Clients empfehle ich diesen [Artikel](https://www.xda-developers.com/install-adb-windows-macos-linux/) auf [xda-developers.com](https://www.xda-developers.com/)

Für den Fall das Sie eine bestimmte ADB Version benötigen, verwenden sie folgenden link und paasen sie die Version an: https://dl.google.com/android/repository/platform-tools_r27.0.0-windows.zip

* Angeschlossenes Android-Tablet oder Telefon 
Angeschlossenes Android-Gerät.

* Alternativ ein Android-Emulator mit ADB-Unterstützung
Beispiel: Emulator in Android Studio enthalten

## Dateien

### load_env.cmd

Diese Datei enthält alle Positionen, die von den verschiedenen Skripten benötigt werden.
Um die Koordinaten von Ihren Geräte zu erfassen, müssen Sie die Entwicklereinstellungen auf Ihrem Telefon aktivieren und "Zeigerposition" aktivieren.

Um die Datei load_env.cmd zu bearbeiten, klicken Sie mit der rechten Maustaste darauf und öffnen Sie sie in einem beliebigen Editor, ich empfehle [notepad++](https://notepad-plus-plus.org/downloads/).

Zur Zeit ist nur ein Setup vordefiniert:
* 1080x1920 420 dpi

### bot_tasker.cmd

Sobald Sie die load_env.cmd eingerichtet haben, können Sie diese "Anwendung" verwenden, um die Drohnen über vordefinierte Aufgaben einschließlich des Sammelns von Öl und Wasser.
Das Skript läuft so lange, bis Sie es manuell stoppen. 

### select_*.bat

Dies sind die Befehle, die derzeit unterstützt werden.
Sie können das ohne Gefahr starten, um eine Erklärung zu erhalten.

Eine kurze Zusammenfassung:
Datei | Beschreibung
---- | ----
select_action | Hier werden die Aktionen behandelt, die die Drohnen ausführen können.
select_bot | Wählt einen Bot aus und bricht seine aktuelle Aufgabe ab.
select_building | Benutzt das Gebäude auswählen Menü im ersten Untergeschoss.
select_chem_search | Wählt eine Ressource für ein vorgewähltes chemisches Bergwerk aus.
select_floors | Verantwortlich für die Navigation durch die verschiedenen Stockwerke.
select_func | Auf die vier Hauptfunktionen jedes Stockwerks kann mit diesem Skript zugegriffen werden...
select_ress | Wählt eine Ressource für Direktabbauch einen ausgewählten Bot.

### mines_*.txt und arrange_mines.cmd

Die Dateien mines_*.txt können bearbeitet werden und sind Konfigurationsdateien für die Datei arrange_mines.cmd, die die Minen/chemischen Minen verschiebt und sogar eine bestimmte Ressource auswählt - nur chemische Minen.

Die Dateien werden von arrange_mines.cmd überschrieben, um die aktuelle Position wiederzugeben.

Diese Dateien sind nur Beispiele, Sie müssen sie mit Ihren aktuellen Minenspots bearbeiten.

Wenn Sie das getan haben, ziehen Sie einfach Ihre Datei über die Datei arrange_mines.cmd, um sie mit dieser Einstellung auszuführen.

### create_script.cmd

Interaktives Script zum erstellen Benutzerspezifischer Scripte.

### other files
File | Beschreibung
---- | ----
detect_devices.cmd | erkennen verbundener android geraete.
testing.cmd | für interne Tests der verschiedenen *.cmd-Dateien verwendet
update_env.cmd | intern verwendet zum aktualisieren der load_env.cmd
get_input_ress.cmd | Eingabe von Rohstoffen abfragen und auf gueltigkeit pruefen.