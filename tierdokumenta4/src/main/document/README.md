# Hinweise zur Entwicklung

## Werkzeuge
* Scribus 1.4.0
* thinkingstone.de
   * PdfToolkit

## PDF Export

1. Scribus: Dokumenteinstellung & Copyrighthinweis aktualisieren.
   Insbesondere muss das Versionsdatum angepasst werden
2. Scribus: PDF Export nach: ${workspace_loc:tierdokumenta4}/target/tmp/Tierdokument.original.pdf
3. Eclipse: "FixBrokenForm - Tier A4" nach ${workspace_loc:tierdokumenta4}/src/intermediate/document/Tierdokument.pdf
   PdfToolkit: de.thinkingstone.pdftoolkit.FixBrokenForm --source ${workspace_loc:tierdokumenta4}/target/tmp/Tierdokument.original.pdf --result ${workspace_loc:tierdokumenta4}/src/intermediate/document/Tierdokument.pdf

### PDF Einstellungen
**Wichtig:** Beim PDF Export müssen folgende Einstellungen gewählt werden. 
Scribus speichert die Exporteinstellungn leider nicht in der Datei ab. 

#### Allgemein
* Kompatibilität: PDF 1.5 (Acrobat 6)
* Vorschaubilder erzeugen
* Lesezeichen integrieren
* Auflösung für EPS-Dateien: 300 dpi
* Komprimierungsmethode: automatisch
* Kompressuinsqualität: Maximal
* Höchste Auflösung: 300 dpi

#### Schriftarten
* alle vollständig einbetten; insbesondere:
   * Mason Regular
   * Linux Libertine 0 Regular
   * Mason Bold

### Farbe
* Ausgabe vorsehen für: Graustufen; "Drucker" führt zu sehr großen Dateien
