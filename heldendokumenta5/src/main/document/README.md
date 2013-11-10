# Hinweise zur Entwicklung

## Werkzeuge
* Scribus 1.4.3
* thinkingstone.de
   * PdfToolkit

## PDF Export

1. Scribus: Dokumenteinstellung & Copyrighthinweis aktualisieren.
   Insbesondere muss das Versionsdatum angepasst werden
2. Scribus: PDF Export nach: ${workspace_loc:heldendokumenta5}/target/tmp/Heldendokument.original.pdf
3. Eclipse: "heldendokumenta5 - FixBrokenForm" nach ${workspace_loc:heldendokumenta5}/src/intermediate/document/Heldendokument.pdf
   PdfToolkit: de.thinkingstone.pdftoolkit.FixBrokenForm --source ${workspace_loc:heldendokumenta5}/target/tmp/Heldendokument.original.pdf --result ${workspace_loc:heldendokumenta5}/src/intermediate/document/Heldendokument.pdf

### PDF Einstellungen
**Wichtig:** Beim PDF Export müssen folgende Einstellungen gewählt werden. 
Scribus speichert die Exporteinstellungn leider nicht in der Datei ab. 

#### Allgemein
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

#### Schriftarten
* alle vollständig einbetten; insbesondere:
   * Mason Regular
   * Linux Libertine O Regular
   * Mason Bold
* in Kurven umwandeln:
   * Linux Libertine O Regular

### Farbe
* Ausgabe vorsehen für: Graustufen; "Drucker" führt zu sehr großen Dateien
