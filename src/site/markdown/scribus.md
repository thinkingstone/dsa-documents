# Scribus

Das Dokument selbst wird in Scribus erstellt und dort als PDF exportiert. 

### Skripte

Für Skribus stehen ein paar Skripte zur Verfügung, die das Entwickeln einfacher machen.

* **Umbenennen.py** kann mehrere Felder umbenennen
* **Formularfeld.py** und **Formularfeld_center.py** setzt für die gesamte Selektion den Style
* **FindObject.py** ermöglicht das Suchen nach einem Feldnamen

### PDF Export

Das Scribus Dokument kann als PDF exportiert werden. Scribus erstellt allerdings ein fehlerhaftes Formular. 
Beim Ausfüllen mit iText werden Formualrfelder teilweise mit schwarzem Hintergrund angelegt.
Um dies zu umgehen enthält das PdfToolkit die Klasse FixBrokenForm. Das Scribus PDF wird in ein tmp Verzeichnis erstellt.
Das FixBrokenForm korrigiert das Formular und speichert das PDF in dem intermediate/document Verzeichnis.

1. Scribus: Dokumenteinstellung & Copyrighthinweis aktualisieren.
   Insbesondere muss das Versionsdatum angepasst werden
2. Scribus: PDF Export nach: ${workspace_loc:heldendokumenta5}/target/tmp/Heldendokument.pdf
3. Eclipse: "heldendokumenta5 - FixBrokenForm" nach ${workspace_loc:heldendokumenta5}/src/intermediate/document/Heldendokument.pdf

```
de.thinkingstone.pdftoolkit.FixBrokenForm --source ${workspace_loc:heldendokumenta5}/target/tmp/Heldendokument.pdf --result ${workspace_loc:heldendokumenta5}/src/intermediate/document/Heldendokument.pdf
```

#### PDF Einstellungen

**Wichtig:** Beim PDF Export müssen folgende Einstellungen gewählt werden. 
Scribus speichert die Exporteinstellungn leider nicht in der Datei ab. 

**Legende**

* x Feld ankreuzen
* o Feld nicht ankreuzen

##### Allgemein
* x Alle Seiten
* Rotation 0°
* o Auf Druckränder beschneiden
* Kompatibilität: PDF 1.5 (Acrobat 6)
* Bindung: Linker Rand
* x Vorschaubilder erzeugen
* o Verkettete Textrahmen als PDF-Artikel speichern
* x Lesezeichen integrieren
* o Ebenen exportieren
* Auflösung für EPS-Dateien: 300 dpi
* o PDF- und EPS-Dateien einbetten
* x Text- und Vektorgrafiken komprimieren 
* Komprimierungsmethode: automatisch
* Kompressionsqualität: Maximal
* x Höchste Auflösung: 300 dpi

![Allgemein](images/scribus/allgemein.png "Allgemein")

##### Schriftarten

* alle vollständig einbetten; insbesondere:
    * Mason Regular
    * Linux Libertine O Regular
    * Mason Bold
* in Kurven umwandeln:
    * Linux Libertine O Semibold

![Schriftarten](images/scribus/schriftarten.png "Schriftarten")

##### Farben

* Ausgabe vorsehen für: Graustufen; "Drucker" führt zu sehr großen Dateien

![Farben](images/scribus/farben.png "Farben")
