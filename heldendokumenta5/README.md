# Heldendokument im A5 Format und Erweiterung für die Helden-Software

Das Heldendokument ist ein ausfüllbares PDF im A5 Format für [Das Schwarze Auge](http://www.dasschwarzeauge.de/). 
In dem Dokument können die Daten eines Charakters eingetragen werden. 
Außerdem können die Daten eines Helden aus der [Helden-Software](http://www.helden-software.de/) exportiert werden. 

## Funktionen 

* Automatische Befüllung des Heldenbogens aus der Helden-Software
* Übersichtliches A5 Format.
* Als kleines Buch druckbar. Eine Druckanleitung ist enthalten.
* Die Felder des Heldendokuments können nachträglich mit einem PDF Reader geändert werden.
* Sonderfertigkeiten, die als Ankreuzfeld auf dem Dokument dargestellt werden, werden nicht nochmal aufgelistet. Beispiele: Ausweichen, Linkhand, Rüstungsgewöhnung, Kampfreflexe.
* Unterstützung für die Druckoptionen der Helden-Software:
   * Metatalente drucken; Die Metatalente werden neu berechnet und wegen Platzmangel als "Nahrung/Kräuter sammeln", "Jagd + 1/5 Fernkanpfwaffe" und "Wache halten" zusammengefasst.
   * Geldkreise

## Voraussetzungen

Folgende Software und Plugins werden benötigt, wenn das Dokument zusammen mit der Helden-Software genutzt werden soll: 

* [Helden-Software](http://www.helden-software.de/) (getestet mit Version 5.2.7)
* [Heldenbogen-Plugin](http://wiki.helden-software.de/wiki/Erweiterungen/Heldenbogen) (getestet mit Version 1.01)

## Installation in die Helden-Software

Für die Installation dieser Erweiterung müssen folgende Schritte ausgeführt werden: 

1. Voraussetzungen installieren
2. Das Paket herunterladen
3. In das Verzeichnis "../helden/plugins/heldenboegen" als "heldendokumenta5" entpacken
4. Helden-Software neu starten
5. Neuer Menüpunkt: "Erweiterungen => Heldenbögen erstellen => PDF - A5"

## Bekannte Probleme

Folgende Probleme sind bekannt und nach einer Lösung wird gesucht: 
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
1. "../helden/plugins/heldenboegen/heldendokumenta5/helden.xfdf.xsl" in einem Texteditor öffnen
2. Die Parameter am Beginn der Datei können geändet werden. Bitte die Hinweise in der Datei beachten. 
Achtung: die einfachen Hochkomma sind wichtig!

## Änderungen

### Version 1.0.0

 * Neues Versionierungsschema
 * Getested mit Helden-Software 5.2.7
 * Anzahl der Zeilen für Talente, Sonderfertigkeiten, Waffen etc wurden erhöht
 * Berechnung von Initiative und Ausweichen umgestaltet
 * Felder für aktuelle Werte für LE, AU, ASP, KE eingefügt
 * Angreuzbare Sonderfertigkeitten sind keine Checkboxen mehr, sondern können mit einem beliebigen Zeichen gefüllt werden 
 * Tierfelder sind entfallen
 * Edelsteine sind entfallen; bitte in "Sonstiger Besitz" eintragen
 * Hintergrund ist entfernt; bitte in "Aussehen & Hintergrund" eintragen
 * Feldnamen:
    * Geld-Felder umbenannt: neu: Geld_D_1 alt: D_1 , etc.
    * Eigenschaften CH, FF, etc auf dem zauberdokument heißen jetzt CH_z1, CH_z2, etc
    * Notizen: notizen umbenant in notizen1 und notizen2
