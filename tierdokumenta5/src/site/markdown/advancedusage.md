# Fortgeschrittene Nutzung

Das Verhalten dieser Erweiterung kann teilweise den eigenen Wünschen angepasst werden. 

## Mögliche Änderungen

* Kommentare eintragen

## Vorgehen

1. "../helden/plugins/heldenboegen/tierdokumenta4/helden.xfdf.xsl" in einem Texteditor öffnen
2. Die Parameter am Beginn der Datei können geändet werden. Bitte die Hinweise in der Datei beachten. 

Achtung: die einfachen Hochkomma sind wichtig!

Beispiel: 

```xml
<!-- 
	includeKommentare:
	'true': Kommentare werden in Klammer angegeben.
	'false': keine Kommentare eintragen 
-->
<xsl:param name="includeKommentare" select="'true'" />
```