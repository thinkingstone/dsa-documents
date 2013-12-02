# Bekannte Probleme

Folgende Probleme sind bekannt und nach einer Lösung wird gesucht: 

* Eine **Silbentrennung** für Vorteile und Sonderfertigkeiten ist leider nicht automatisch möglich. 
  Bei mehrzeiligen Feldern wird versucht, eine Zeile so weit wie möglich zu füllen.
* **Zu viele Talente:**
  Wenn für ein Talent nicht genügend Platz vorhanden ist, dann wird der Text nicht komplett ausgegeben. 
  Beispiel: Wenn der Charakter mehr als die zur Verfügung stehenden handwerklichen Talente beherrscht, 
  werden nur die Basistalente und so viele weitere Talente wie möglich ausgedruckt.
* **Zu viele Sonderfertigkeiten:**
  Die Sonderfertigkeiten werden je nach Typ in unterschiedliche Felder positioniert. 
  Wenn allerdings von einem Typ zu viele Sonderfertigkeiten angegeben sind, dann wird der Text nicht komplett ausgegeben. 
  Beispiel: Wenn der Charakter sehr viele waffenlose Sonderfertigkeiten bzw. Manöver beherrscht, werden so viele wie möglich ausgedruckt.
* **Magische Begabungen:**
  Die magischen Begabungen werden nicht automatisch in das Begabungen Feld eingetragen sondern bei den magischen Vorteilen. 
  Bei Begabungen für einzelne Zauber wird das Begabungen Feld sehr schnell zu klein. 
* **Magieresistenzberechnung:**
  Die Berechnung der Magieresistenz enthält bei Modifikationen auch die zugekaufte Magieresistenz. 
* **Ausrüstung:**
  Bei der Ausrüstung werden die angelegten Waffen und Rüstungen nicht nochmals aufgelistet. 
  Eine weitere Aufteilung in Kleidung, Munition, Proviant, etc ist nicht möglich, da die Helden-Software diese Unterscheidung ebenfalls nicht kennt. 
* **Aussehen und Hintergrund:**
  Die Texte für Aussehen und Hintergrund werden zusammenhängend ausgegeben. Die Helden-Software sieht hier allerdings eine Aufteilung vor. 
