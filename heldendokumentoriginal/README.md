# Original DSA Heldendokument Erweiterung für die Helden-Software

Diese Erweiterung stellt eine Export Funktion in das Original [Das Schwarze Auge](http://www.dasschwarzeauge.de/) Heldendokument aus der [Helden-Software](http://www.helden-software.de/) bereit.

## Funktionen 
* Automatische Befüllung des Original DSA 4.1 Heldenbogen
* Die Felder des Heldendokuments können nachträglich mit einem PDF Reader geändert werden.
* Sonderfertigkeiten, die als Ankreuzfeld auf dem Dokument dargestellt werden, werden nicht nochmal aufgelistet. Beispiele: Ausweichen, Linkhand, Rüstungsgewöhnung, Kampfreflexe.
* Unterstützung für die Druckoptionen der Helden-Software:
   * Metatalente drucken; Die Metatalente werden neu berechnet und wegen Platzmangel als "Nahrung/Kräuter sammeln", "Jagd + 1/5 Fernkanpfwaffe" und "Wache halten" zusammengefasst.
   * Geldkreise

## Voraussetzungen
Folgende Software und Plugins werden benötigt, wenn das Dokument zusammen mit der Helden-Software genutzt werden soll: 
* [Helden-Software](http://www.helden-software.de/) (getestet mit Version 5.2.7)
* [Heldenbogen-Plugin](http://wiki.helden-software.de/wiki/Erweiterungen/Heldenbogen) (getestet mit Version 1.01)
* [Wege-der-Helden_Heldendokument-edit_20b4.pdf](http://www.ulisses-spiele.de/download/559/Wege-der-Helden_Heldendokument-edit_20b4.pdf) von der [Ulisses Webseite](http://www.ulisses-spiele.de/).

## Installation in die Helden-Software
Für die Installation dieser Erweiterung müssen folgende Schritte ausgeführt werden: 

1. Voraussetzungen installieren
2. Das Paket herunterladen
3. In das Verzeichnis "../helden/plugins/heldenboegen" als "heldendokumenta4" entpacken
4. [Wege-der-Helden_Heldendokument-edit_20b4.pdf](http://www.ulisses-spiele.de/download/559/Wege-der-Helden_Heldendokument-edit_20b4.pdf) in dieses Verzeichnis kopieren
5. Helden-Software neu starten
6. Neuer Menüpunkt: "Erweiterungen => Heldenbögen erstellen => PDF - Original A4"

## Bekannte Probleme
Folgende Probleme sind bekannt und nach einer Lösung wird gesucht: 
* Das Orginaldokument enthält zwei Varianten der Seite "Waffen und Kampfwerte". Auf einer der beiden Seiten sind die Felder "Astralenergie" und "Karmaenergie" vertauscht.
* Eine Silbentrennung für Vorteile und Sonderfertigkeiten ist leider nicht automatisch möglich. Bei mehrzeiligen Feldern wird versucht, eine Zeile so weit wie möglich zu füllen.

## Fortgeschrittene Nutzung
Das Verhalten dieser Erweiterung kann teilweise den eigenen Wünschen angepasst werden. 

### Mögliche Änderungen
* Gegenstände eintragen
* Kommentare eintragen
* Talentwerte / Zauberwerte eintragen
* Metatalente selbst berechnen / von der Helden-Software übernehmen
* Tierfelder eintragen

### Vorgehen
1. "../helden/plugins/heldenboegen/heldendokumenta4/helden.xfdf.xsl" in einem Texteditor öffnen
2. Die Parameter am Beginn der Datei können geändet werden. Bitte die Hinweise in der Datei beachten. 
Achtung: die einfachen Hochkomma sind wichtig!
