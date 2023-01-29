# Hinweise zur Entwicklung

## Werkzeuge

Folgende Werkzeuge werden zur Entwicklung benötigt:

* [Scribus](https://www.scribus.net/) 1.4.3 
* thinkingstone.de [PdfToolkit](https://github.com/thinkingstone/dsa-documents/tree/master/pdftoolkit)
* [Eclipse](https://www.eclipse.org) 4.3.1
* [Maven](https://maven.apache.org/) 3.0.4
* [Git](https://git-scm.com/) 1.7.9.5
* [Imagemagick](https://www.imagemagick.org) 6.6.9 für die Thumbnails
* [XFDF Format Spec](https://partners.adobe.com/public/developer/en/xml/XFDF_Spec_3.0.pdf)


---

## Webseite

Die Webseite wird mit Maven generiert und bei Github veröffentlicht. 

### Thumbnails erzeugen

1. toimage.sh ausführen: 
   Dazu kann auch die Eclipse External Tools Configuration "heldendokumenta5 - shell -  convert image" genutzt werden. 
   Das Skript nutzt eine Linux Shell und ImageMagick und ist daher nur unter Linux lauffähig.

    ```
    .../dsa-documents/src/main/scripts/toimage.sh .../dsa-documents/heldendokumenta5/src/intermediate/document/Heldendokument.pdf .../dsa-documents/heldendokumentoriginal/src/site/resources/images/document/Heldendokument 80
    ```
2. Thumbnails kontrollieren.

---

## Releases

Releases werden mit Maven durchgeführt. 

### einmalige Vorbereitung

1. Die SCM developer connection benutzt das SSH Protokoll. Auf Github muss daher der SSH Key eingerichtet sein.
2. In die settings.xml müssen die bintray credentials eingetragen werden. Die Bintray REST API benötigt API keys!:

```xml
<server>
  <id>bintray</id>
  <username>(bintray-user)</username>
  <password>(bintray-api-key)</password>
</server>
```

### Release durchführen

Es muss eine lokale Maven Installation genutzt werden. Das Eclipse embedded Maven funktioniert nicht!

1. changes.xml: Änderungshistorie ergänzen

2. lokales Maven: Release vorbereiten:
    
    ```
    mvn release:prepare
    ```

	Evtl vorher auch mit "-DdryRun=true".

3. Ergebnis kontrollieren

4. lokales Maven: Release durchführen
    
    ```
    mvn release:perform
    ```

5. Bintray: Publish der neuen Version: 
   Auf Bintray einloggen und im "dsa-documents" Repository die Dateien freigeben.