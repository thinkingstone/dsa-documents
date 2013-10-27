# Zusätzlich benötigte Dateien
"Das Scharze Auge Heldendokument" muss von http://www.ulisses-spiele.de/download/559/Wege-der-Helden_Heldendokument-edit_20b4.pdf geladen werden und unter /heldendokumentoriginal/src/intermediate/document/Wege-der-Helden_Heldendokument-edit_20b4.pdf gespeichert werden.  
Das Originaldokument darf nicht Teil einer Distribution sein!

"mvn wagon:download-single" lädt das Dokument automatisch

# Releases
Releases werden mit Maven durchgeführt. 

## einmalige Vorbereitung

1. Die SCM developer connection benitzt das SSH Protokoll. Auf Github muss daher der SSH Key eingerichtet sein.
2. In die settings.xml müssen die bintray credentials eingetragen werden. Die Bintray REST API benötigt API keys!:

<server>
  <id>bintray</id>
  <username>bintray-user</username>
  <password>bintray-api-key</password>
</server>

## Release durchführen
Es muss eine lokale Maven Installation genutzt werden. Das Eclipse embedded Maven funktioniert nicht!

1. lokales Maven: Release vorbereiten:
mvn release:prepare
 
2. lokales Maven: Release durchführen
mvn release:perform

3. Bintray: Publish der neuen Version
