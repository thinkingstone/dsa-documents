# Hinweise zur Entwicklung

## Werkzeuge
* Scribus 1.4.3
* thinkingstone.de
   * PdfToolkit

## PDF Export

1. Scribus: Dokumenteinstellung & Copyrighthinweis aktualisieren.
   Insbesondere muss das Versionsdatum angepasst werden
2. Scribus: PDF Export nach: ${workspace_loc:tierdokumenta5}/target/tmp/Tierdokument.pdf
3. Eclipse: "FixBrokenForm - Tier A4" nach ${workspace_loc:tierdokumenta5}/src/intermediate/document/Tierdokument.pdf

```
de.thinkingstone.pdftoolkit.FixBrokenForm --source ${workspace_loc:tierdokumenta5}/target/tmp/Tierdokument.pdf --result ${workspace_loc:tierdokumenta5}/src/intermediate/document/Tierdokument.pdf
```

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
   * Linux Libertine O Semibold

#### Farbe
* Ausgabe vorsehen für: Graustufen; "Drucker" führt zu sehr großen Dateien

## Notizen

* Reittiere:
  * Tragkraft TK
  * Zugkraft ZK
  * Futterbedarf
  * AU (Anzahl möglicher Spielrunden in Trab/Galopp)
  * Ausbildung

 * Rüstungen siehe ZBA 29
   * nur für Pferde definiert
   * 10 verfügbare Rüstungsteile; starke Einschränkungen der Kombination/Nutzbarkeit
   * RS
   * BE
 
 * Vertrautentiere:
   * Zauber	WdZ 121
  * AsP
  * Ritualkenntnis (Vertrautenmagie)
  * Zauber Zwiegespräch (automatisch)
  * Abenteuerpunkte gesamt, eingesetzt, Guthaben 
  * 12 verfügbare Zauber
    * Probe
    * Zauberdauer
    * AsP Kosten
    * Zielobjekt
    * Reichweite
    * Wirkungsdauer
    * Merkmal
    * Kommentar/Anmerkungen
    * => siehe auch Zauberbogen
