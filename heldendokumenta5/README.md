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
   * Metatalente drucken
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

## Als A5 Broschüre drucken

Die Seiten sind im A5 Format definiert und es müssen jeweils zwei Seiten auf ein A4 Blatt gedruckt werden. 
Der Adobe Acrobat Reader bietet dazu die Option Broschürendruck. 
Das ausgefüllte Dokument aus der Helden-Software enthält am Ende das Zauberdokument in A4. 
Da dies nicht Als A5 in die Broschüre gedruckt werden soll müssen die beiden letzten Seiten vom Druck ausgeschlossen werden. 

Wer keinen Duplexdrucker besitzt muss zuerst die Vorderseiten/ungeraden ausdrucken. 
Dann das ausgedruckte Papier erneut in den Drucker einlegen. Die Seiten müssen in der Regel gedreht werden. 
Dies hängt allerdings vom genutzten Druckermodell ab. Daher muss die korrekte Ausrichtung der Seiten ausprobiert werden. 
Als letztes die Rückseiten/geraden drucken. 

### Adobe Acrobat Reader

Im Acrobat Reader können folgende Einstellungen zum Drucken genutzt werden.

#### Vorderseiten drucken

1. Druckbereich
 * Seiten: 1-16
2. Seiteneinstellungen
 * Anpassen der Seitengröße: Broschürendruck
 * Seitenauswahl: Nur Vorderseite
4. OK zum Drucken der Vorderseiten

#### Rückseiten drucken

1. Druckbereich
 * Seiten: 1-16
2. Seiteneinstellungen
 * Anpassen der Seitengröße: Broschürendruck
 * Seitenauswahl: Nur Rückseite
4. OK zum Drucken der Rückseiten

#### Zauberdokument Vorderseiten drucken

1. Druckbereich
 * Seiten: 17
2. Seiteneinstellungen
 * Anpassen der Seitengröße: keine
4. OK zum Drucken der Vorderseite

#### Zauberdokument Rückseiten drucken

1. Druckbereich
 * Seiten: 18
2. Seiteneinstellungen
 * Anpassen der Seitengröße: keine
4. OK zum Drucken der Rückseite

### Falten und Heften

Die ausgedruckten Seiten so aufeinander legen, dass beim Zusammenfalten folgende Reihenfolge entsteht: 

1. Heldendokument Deckblatt
2. Eigenschaften & Basiswerte, Abenteuerpunkte
3. Vorteile, Nachteile & Sonderfertigkeiten
4. Talente & Gaben
5. Körperliche Talente, Gesellschaftliche Talente
6. Natur-Talente, Wissenstalente
7. Sprachen & Schriften, Handwerkliche Talente
8. Waffen & Kampfwerte
9. Schild / Parierwaffe, Rüstung, Ausweichen, Initiative
10. Ausrüstung I
11. Ausrüstung II
12. Vermögen, Verbindungen
13. Magie, Magische Vorteile & Nachteile, Magische Sonderfertigkeiten
14. Liturgie-/ Ritualkenntnisse
15. Notizen
16. Notizen

Die Blätter können jetzt entlang der Faltkante miteinander verbunden werden. Dazu können die Seiten mit Nadel und Faden zusammen genäht werden. 

### Zauberdokument

Das Zauberdokument mit allen Zaubern ist zu kompakt um sinnvoll auf A5 verkleinert zu werden. 
Daher ist ein passendes Zauberdokument im A4 Format enthalten. Dieses kann ebenfalls beidseitig gedruckt und auf A5 gefaltet werden. 
Wer dieses Blatt nicht lose haben möchte, kann es in die A5 Broschüre einkleben. Dazu von jeder Seite einen Streifen Tesafilm einkleben. 
Damit die zusätzliche Seite nicht stört, kann diese innen an die letzte Seite geklebt werden. 


## Bekannte Probleme

Folgende Probleme sind bekannt und nach einer Lösung wird gesucht: 

* Eine Silbentrennung für Vorteile und Sonderfertigkeiten ist leider nicht automatisch möglich. 
  Bei mehrzeiligen Feldern wird versucht, eine Zeile so weit wie möglich zu füllen.
* Zu viele Talente:
  Wenn für ein Talent nicht genügend Platz vorhanden ist, dann wird der Text nicht komplett ausgegeben. 
  Beispiel: Wenn der Charakter mehr als die zur Verfügung stehenden handwerklichen Talente beherrscht, 
  werden nur die Basistalente und so viele weitere Talente wie möglich ausgedruckt.
* Zu viele Sonderfertigkeiten:
  Die Sonderfertigkeiten werden je nach Typ in unterschiedliche Felder positioniert. 
  Wenn allerdings von einem Typ zu viele Sonderfertigkeiten angegeben sind, dann wird der Text nicht komplett ausgegeben. 
  Beispiel: Wenn der Charakter sehr viele waffenlose Sonderfertigkeiten bzw. Manöver beherrscht, werden so viele wie möglich ausgedruckt.
* Magische Begabungen:
  Die magischen Begabungen werden nicht automatisch in das Begabungen Feld eingetragen sondern bei den magischen Vorteilen. 
  Bei Begabungen für einzelne Zauber wird das Begabungen Feld sehr schnell zu klein. 
* Magieresistenzberechnung:
  Die Berechnung der Magieresistenz enthält bei Modifikationen auch die zugekaufte Magieresistenz. 
* Ausrüstung:
  Bei der Ausrüstung werden die angelegten Waffen und Rüstungen nicht nochmals aufgelistet. 
  Eine weitere Aufteilung in Kleidung, Munition, Proviant, etc ist nicht möglich, da die Helden-Software diese Unterscheidung ebenfalls nicht kennt. 
* Aussehen und Hintergrund:
  Die Texte für Aussehen und Hintergrund werden zusammenhängend ausgegeben. Die Helden-Software sieht hier allerdings eine Aufteilung vor. 

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
 * Getestet mit Helden-Software 5.2.7
 * Neues Design des Heldenbogens
 * Metatalent "Wache halten" entfernt. Die Berechnung ist zu kompliziert um sie nur mit XSLT durchzuführen. Die Helden-Software übergibt dieses Metatalent nicht an die Erweiterung.
 * Anzahl der Zeilen für Talente, Sonderfertigkeiten, Waffen etc wurden erhöht
 * Berechnung von Initiative und Ausweichen umgestaltet
 * Felder für aktuelle Werte für LE, AU, ASP, KE eingefügt
 * Ankreuzbare Sonderfertigkeitten sind keine Checkboxen mehr, sondern können mit einem beliebigen Zeichen gefüllt werden 
 * Tierfelder sind entfallen
 * Edelsteine sind entfallen; bitte in "Sonstiger Besitz" eintragen
 * Hintergrund ist entfernt; bitte in "Aussehen & Hintergrund" eintragen
 * Feldnamen:
    * Geld-Felder umbenannt: neu: Geld_D_1 alt: D_1 , etc.
    * Eigenschaften CH, FF, etc auf dem zauberdokument heißen jetzt CH_z1, CH_z2, etc
    * Notizen: notizen umbenant in notizen1 und notizen2
