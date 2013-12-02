# Fortgeschrittene Nutzung

Das Verhalten dieser Erweiterung kann teilweise den eigenen Wünschen angepasst werden. 

## Mögliche Änderungen

* Gegenstände eintragen
* Gegenstände Anzahl eintragen
* Kommentare eintragen
* Talentwerte / Zauberwerte eintragen
* Metatalente selbst berechnen / von der Helden-Software übernehmen

## Vorgehen

1. "../helden/plugins/heldenboegen/heldendokumentoriginal/helden.xfdf.xsl" in einem Texteditor öffnen
2. Die Parameter am Beginn der Datei können geändet werden. Bitte die Hinweise in der Datei beachten. 

Achtung: die einfachen Hochkomma sind wichtig!

Beispiel: 

```xml
<!-- 
	includeGegenstandAnzahl:
	'true': Für jeden Gegenstand wird die Anzahl eingetragen; Praktisch für Pfeile, Papier, etc. 
	'false': Die Anzahl wird nicht eingetragen
-->
<xsl:param name="includeGegenstandAnzahl" select="'true'" />
```