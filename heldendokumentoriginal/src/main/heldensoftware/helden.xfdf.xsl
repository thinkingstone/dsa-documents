<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://ns.adobe.com/xfdf/">
	<xsl:decimal-format name="de" decimal-separator="," grouping-separator="." />
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<!-- Optionen Ja: "true" Nein: "false" -->
	
	<!-- 
		includeGeld:
		'true': Anzahl Geldmünzen eintragen
		'false': Geldmünzen werden nicht eingetragen 
	-->
	<xsl:param name="includeGeld" select="/daten/config/geldkreise" />
	
	<!-- 
		includeGegenstaende:
		'true': Gegenstände eintragen
		'false': keine Gegenstände eintragen 
	-->
	<xsl:param name="includeGegenstaende" select="'true'" />
	
	<!-- 
		includeGegenstandAnzahl:
		'true': Für jeden Gegenstand wird die Anzahl eingetragen; Praktisch für Pfeile, Papier, etc. 
		'false': Die Anzahl wird nicht eingetragen
	-->
	<xsl:param name="includeGegenstandAnzahl" select="'true'" />
	
	<!-- 
		includeKommentare:
		'true': Kommentare werden in Klammer angegeben.
		'false': keine Kommentare eintragen 
	-->
	<xsl:param name="includeKommentare" select="'true'" />
	
	<!-- 
		includeLCSeite:
		'true': Seitenzahl aus dem Liber Cantiones eintragen; nur für Zauber relevant.
		'false': keine Seitenzahl eintragen
	 -->
	<xsl:param name="includeLCSeite" select="/daten/config/zauberquellen" />
	
	<!-- 
		includeTAW
		'true': Der Talentwert wird eingetragen
		'false': nicht eintragen
	 -->
	<xsl:param name="includeTAW" select="'true'" />

	<!-- 
		includeZFW
		'true': der Zaufervertigkeitswert wird eingetragen
		'false': nicht eintragen
	 -->
	<xsl:param name="includeZFW" select="'true'" />
	
	<!-- 
		allVorteileOnFrontpage
		'true': alle Vorteile und Nachteile werden auf der ersten Seiten aufgelistet. 
		'false': Auflistung nur in den entsprechenden Teilbereichen (z.B magisch, profan, etc.)
	 -->
	<xsl:param name="allVorteileOnFrontpage" select="'false'" />
	
	<!-- 
		workaroundRituale:
		Die Felder "kosten" und "wirkung" sind seit der Helden-Software 5.2.1 vertauscht. 
		Seit 5.2.3 sind die Felder wieder korrekt befüllt.
		'true': Felder nochmals Tauschen, dann werden diese korrekt gefüllt. 
		'false': Felder direkt von der Helden-Software übernehmen.
	 -->
	<xsl:param name="workaroundRituale" select="'false'" />
	
	<!-- 
		includeMetatalente
		'true': Die Metatalente werden berechnet und eingetragen
		'false': keine Metatalente berechnen
	 -->
	<xsl:param name="includeMetatalente" select="/daten/config/metatalente" />
	
	<!-- 
		workaroundMetatalente: 
		Die Metatelente werden von der Helden-Software ab 5.2.3 mitgeliefert, allerdings ohne Wert. 
		'true': Metatalente der Helden-Software ignorieren.
		'false': Metatalente der Helden-Software werden eingefügt.  
	-->
	<xsl:param name="workaroundMetatalente" select="'true'" />
	
	<!-- 
		includeTier:
		'true': Tiere eintragen
		'false': keine Tiere eintragen 
	-->
	<xsl:param name="includeTier" select="'true'" />
	
	<!-- Templates -->
	<xsl:template match="@*|text()" />
	<xsl:template match="@*|text()" mode="begabung"/>
	<xsl:template match="@*|text()" mode="sfSonstGeweiht"/>
	<xsl:template match="@*|text()" mode="sfRitual"/>
	<xsl:template match="@*|text()" mode="sfLiturgie"/>
	<xsl:template match="@*|text()" mode="sfCheckboxes"/>
	<xsl:template match="@*|text()" mode="sfRitualkenntnis"/>
	<xsl:template match="@*|text()" mode="talenteWeitere"/>
	<xsl:template match="@*|text()" mode="talenteBasis"/>
	<xsl:template match="@*|text()" mode="talenteRitualkenntnis"/>
	<xsl:template match="@*|text()" mode="talenteSpezialisierung"/>
	<xsl:template match="/">
		<xfdf xml:space="preserve">
			<f href="Document.pdf" />
			<ids original="7A0631678ED475F0898815F0A818CFA1" modified="BEF7724317B311718E8675B677EF9B4E" />
			<fields>
				<xsl:apply-templates />
			</fields>
		</xfdf>
	</xsl:template>
	<xsl:template match="/daten/angaben">
		<field name="Name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Augenfarbe">
			<value>
				<xsl:value-of select="augenfarbe" />
			</value>
		</field>
		<field name="Alter">
			<value>
				<xsl:value-of select="geburtstag" />
				<xsl:text> </xsl:text>
				<xsl:text>(</xsl:text>
				<xsl:value-of select="alter" />
				<xsl:text>)</xsl:text>
			</value>
		</field>
		<field name="Geschlecht">
			<value>
				<xsl:value-of select="geschlecht" />
			</value>
		</field>
		<field name="Grösse">
			<value>
				<xsl:value-of select="round(number(groesse) div 2)" />
				<xsl:text> Finger</xsl:text>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="groesse" />
				<xsl:text> cm)</xsl:text>
			</value>
		</field>
		<field name="Gewicht">
			<value>
				<xsl:value-of select="gewicht" />
				<xsl:text> Stein</xsl:text>
			</value>
		</field>
		<field name="Haarfarbe">
			<value>
				<xsl:value-of select="haarfarbe" />
			</value>
		</field>
		<field name="Stand">
			<value>
				<xsl:value-of select="stand" />
			</value>
		</field>
		<field name="Titel">
			<value>
				<xsl:value-of select="titel" />
			</value>
		</field>
		<field name="Rasse">
			<value>
				<xsl:value-of select="rasse" />
			</value>
		</field>
		<field name="Kultur">
			<value>
				<xsl:value-of select="kultur" />
			</value>
		</field>
		<field name="Regeneration">
			<value>
				<xsl:value-of select="aspregeneration" />
			</value>
		</field>
		<field name="Wundschwelle">
			<value>
				<xsl:value-of select="wundschwelle" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/notizen">
		<xsl:variable name="Notizen">
			<xsl:value-of select="text" />
		</xsl:variable>
		<field name="Notizen 1">
			<value>
				<xsl:value-of select="substring($Notizen, 0, 100)" />
			</value>
		</field>
		<field name="Notizen 2">
			<value>
				<xsl:value-of select="substring($Notizen, 100, 100)" />
			</value>
		</field>
		<field name="Notizen 3">
			<value>
				<xsl:value-of select="substring($Notizen, 200, 100)" />
			</value>
		</field>
		<field name="Notizen 4">
			<value>
				<xsl:value-of select="substring($Notizen, 300)" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/aussehen">
		<xsl:variable name="Aussehen">
			<xsl:value-of select="text" />
		</xsl:variable>
		<field name="Aussehen 1">
			<value>
				<xsl:value-of select="a0"></xsl:value-of>
			</value>
		</field>
		<field name="Aussehen 2">
			<value>
				<xsl:value-of select="a1"></xsl:value-of>
			</value>
		</field>
		<field name="Aussehen 3">
			<value>
				<xsl:value-of select="a2"></xsl:value-of>
			</value>
		</field>
		<field name="Aussehen 4">
			<value>
				<xsl:value-of select="a3"></xsl:value-of>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/familie">
		<xsl:variable name="Hintergrund">
			<xsl:value-of select="text" />
		</xsl:variable>
		<field name="Familie/Herkunft/Hintergrund 1">
			<value>
				<xsl:value-of select="f0"></xsl:value-of>
			</value>
		</field>
		<field name="Familie/Herkunft/Hintergrund 2">
			<value>
				<xsl:value-of select="f1"></xsl:value-of>
			</value>
		</field>
		<field name="Familie/Herkunft/Hintergrund 3">
			<value>
				<xsl:value-of select="f2"></xsl:value-of>
			</value>
		</field>
		<field name="Familie/Herkunft/Hintergrund 4">
			<value>
				<xsl:value-of select="f3"></xsl:value-of>
			</value>
		</field>
		<field name="Familie/Herkunft/Hintergrund 5">
			<value>
				<xsl:value-of select="f4"></xsl:value-of>
			</value>
		</field>
		<field name="Familie/Herkunft/Hintergrund 6">
			<value>
				<xsl:value-of select="f5"></xsl:value-of>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/profession">
		<field name="Profession">
			<value>
				<xsl:value-of select="text" />
				<xsl:if test="string-length(/daten/angaben/gilde) > 0">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="/daten/angaben/gilde" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/ap">
		<field name="Gesamt">
			<value>
				<xsl:value-of select="format-number(gesamt, '#.###', 'de')" />
			</value>
		</field>
		<field name="Eingesetzte AP">
			<value>
				<xsl:value-of select="format-number(genutzt, '#.###', 'de')" />
			</value>
		</field>
		<field name="Guthaben">
			<value>
				<xsl:value-of select="format-number(frei, '#.###', 'de')" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/gp">
		<field name="GP-Basis">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/geschwindigkeit">
		<field name="Geschwindigkeit">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Geschwindigkeit (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Geschwindigkeit (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/astralenergie">
		<xsl:if test="/daten/angaben/magisch = 'true'">
			<!-- <field name="Astralenergie (aktuell)"> <value> <xsl:value-of select="akt" /> </value> </field> -->
			<field name="Astralenergie">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<field name="Astralenergie (Start)">
				<value>
					<xsl:value-of select="muinch2" />
				</value>
			</field>
			<field name="Astralenergie (Modifikator)">
				<value>
					<xsl:value-of select="modi" />
				</value>
			</field>
			<field name="Astralenergie (Zugekauft)">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="Astralenergie (Max. Zug.)">
				<value>
					<!-- TODO korrekt? -->
					<xsl:value-of select="kaufbar" />
				</value>
			</field>
			<!-- Rechnung -->
			<field name="Astralenergie (Vor-/Nachteil)">
				<value>
					<xsl:value-of select="ausvornachteile" />
				</value>
			</field>
			<field name="Astralenergie (Sonderfertigkeiten)">
				<value>
					<xsl:value-of select="aussonderfertigkeiten" />
				</value>
			</field>
			<field name="Astralenergie (Meditationen)">
				<value>
					<xsl:value-of select="grossemeditation" />
				</value>
			</field>
			<field name="Astralenergie (Zugekauft)">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="Astralenergie (Zukauf)">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="Astralenergie (Max">
				<value>
					<xsl:value-of select="aktinklrueckkaufbarepasp" />
				</value>
			</field>
			<field name="Astralenergie (max">
				<value>
					<xsl:value-of select="aktinklrueckkaufbarepasp" />
				</value>
			</field>
			<field name="Astralenergie (max.)">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<field name="Astralenergie (Maximum)">
				<value>
					<xsl:value-of select="aktinklrueckkaufbarepasp" />
				</value>
			</field>
			<field name="Astralenergie (pAsP)">
				<value>
					<xsl:value-of select="pasprueckkaufbar" />
				</value>
			</field>
		</xsl:if>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/karmaenergie">
		<xsl:if test="/daten/angaben/geweiht = 'true'">
			<field name="Karmaenergie">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<!-- <field name="Karmaenergie (aktuell)"> <value> <xsl:value-of select="akt" /> </value> </field> -->
			<field name="Karmaenergie (Start)">
				<value>
					<xsl:value-of select="start" />
				</value>
			</field>
			<field name="Karmaenergie (Modifikator)">
				<value>
					<xsl:value-of select="modi" />
				</value>
			</field>
			<field name="Karmaenergie (Zugekauft)">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="Karmaenergie (Max. Zug.)">
				<value>
					<!-- TODO korrekt? -->
					<xsl:value-of select="kaufbar" />
				</value>
			</field>
			<field name="Karmaenergie (max.)">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
		</xsl:if>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/magieresistenz">
		<field name="Magieresistenz">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Magieresistenz (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Magieresistenz (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="Magieresistenz (Zugekauft)">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="Magieresistenz (Max. Zug.)">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<!-- Rechnung -->
		<field name="Magieresistenz (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Magieresistenz (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="Magieresistenz (Vor-/Nachteil)">
			<value>
				<xsl:value-of select="''" />
			</value>
		</field>
		<field name="Magieresistenz (Sonderfertigkeiten)">
			<value>
				<xsl:value-of select="''" />
				<xsl:text> +</xsl:text>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="Magieresistenz">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/initiative">
		<field name="INI-Basiswert">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="INI-Basiswert (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="INI-Basiswert (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/attacke">
		<field name="AT-Basiswert">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="AT-Basiswert (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="AT-Basiswert (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/parade">
		<field name="PA-Basiswert">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="PA-Basiswert (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="PA-Basiswert (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/fernkampf-basis">
		<field name="FK-Basiswert">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="FK-Basiswert (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="FK-Basiswert (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/lebensenergie">
		<field name="Lebensenergie">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Lebenspunkte (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Lebenspunkte (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="Lebenspunkte (Zugekauft)">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="Lebenspunkte (Max. Zug.)">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<field name="Lebensenergie (1/2)">
			<value>
				<xsl:value-of select="akt50" />
			</value>
		</field>
		<field name="Lebensenergie (1/3)">
			<value>
				<xsl:value-of select="akt33" />
			</value>
		</field>
		<field name="Lebensenergie (1/4)">
			<value>
				<xsl:value-of select="akt25" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/ausdauer">
		<field name="Ausdauer">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Ausdauer (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Ausdauer (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="Ausdauer (Zugekauft)">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>

		<field name="Ausdauer (Max. Zug.)">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<field name="Ausdauer (1/2)">
			<value>
				<xsl:value-of select="akt50" />
			</value>
		</field>
		<field name="Ausdauer (1/3)">
			<value>
				<xsl:value-of select="akt33" />
			</value>
		</field>
		<field name="Ausdauer (1/4)">
			<value>
				<xsl:value-of select="akt25" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/mut">
		<field name="Mut">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Mut (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Mut (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/klugheit">
		<field name="Klugheit">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Klugheit (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Klugheit (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/intuition">
		<field name="Intuition">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Intuition (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Intuition (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/charisma">
		<field name="Charisma">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Charisma (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Charisma (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/fingerfertigkeit">
		<field name="Fingerfertigkeit">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Fingerfertigkeit (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Fingerfertigkeit (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/gewandtheit">
		<field name="Gewandtheit">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Gewandtheit (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Gewandtheit (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/konstitution">
		<field name="Konstitution">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Konstitution (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Konstitution (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/koerperkraft">
		<field name="Körperkraft">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="Körperkraft (Start)">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="Körperkraft (Modifikator)">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/sozialstatus">
		<field name="Sozialstatus">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/geld">
		<xsl:if test="$includeGeld = 'true'">
			<xsl:apply-templates />
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/geld/Dukat">
		<field name="Dukaten 1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Silbertaler">
		<field name="Silbertaler 1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Heller">
		<field name="Heller 1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Kreuzer">
		<field name="Kreuzer 1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/vorteile">
		<xsl:variable name="VorteileNachteile">
			<xsl:choose>
				<xsl:when test="$allVorteileOnFrontpage = 'true'">
					<xsl:apply-templates select="vorteil" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="vorteil[not(bereich = 'Magisch')]" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<field name="Vorteile &amp; Nachteile 1">
			<value>
				<xsl:value-of select="substring($VorteileNachteile, 0, 100)" />
			</value>
		</field>
		<field name="Vorteile &amp; Nachteile 2">
			<value>
				<xsl:value-of select="substring($VorteileNachteile, 100, 100)" />
			</value>
		</field>
		<field name="Vorteile &amp; Nachteile 3">
			<value>
				<xsl:value-of select="substring($VorteileNachteile, 200, 100)" />
			</value>
		</field>
		<field name="Vorteile &amp; Nachteile 4">
			<value>
				<xsl:value-of select="substring($VorteileNachteile, 300, 100)" />
			</value>
		</field>
		<field name="Vorteile &amp; Nachteile 5">
			<value>
				<xsl:value-of select="substring($VorteileNachteile, 400)" />
			</value>
		</field>
	
		<xsl:variable name="Begabungen">
			<xsl:apply-templates select="vorteil[bereich = 'BEGABUNGMERKMAL']" mode="begabung"/>
		</xsl:variable>
		<field name="Begabungen">
			<value>
				<xsl:value-of select="$Begabungen"></xsl:value-of>
			</value>
		</field>
		
		<xsl:variable name="Unfaehigkeiten">
			<xsl:apply-templates select="vorteil[bereich = 'UNFÄHIGKEITMERKMAL']" mode="begabung"/>
		</xsl:variable>
		<field name="Unfähigkeiten">
			<value>
				<xsl:value-of select="$Unfaehigkeiten"></xsl:value-of>
			</value>
		</field>
		
		<xsl:variable name="MagVorteileNachteile">
			<xsl:apply-templates select="vorteil[bereich = 'Magisch' and not(bereich = 'BEGABUNGMERKMAL') and not(bereich = 'UNFÄHIGKEITMERKMAL')]" />
		</xsl:variable>
		<field name="Magische Vor- / Nachteile.0">
			<value>
				<xsl:value-of select="substring($MagVorteileNachteile, 0, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Vor- / Nachteile.1">
			<value>
				<xsl:value-of select="substring($MagVorteileNachteile, 60, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Vor- / Nachteile.2">
			<value>
				<xsl:value-of select="substring($MagVorteileNachteile, 155, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Vor- / Nachteile.3">
			<value>
				<xsl:value-of select="substring($MagVorteileNachteile, 245, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Vor- / Nachteile.4">
			<value>
				<xsl:value-of select="substring($MagVorteileNachteile, 335)"></xsl:value-of>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil">
		<xsl:value-of select="name" />
		<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
			<xsl:text> </xsl:text>
			<xsl:text>(</xsl:text>
			<xsl:value-of select="kommentar" />
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:if test="not(position() = last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil" mode="begabung">
		<xsl:apply-templates select="auswahlen" mode="begabung"/>
		<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
			<xsl:text> </xsl:text>
			<xsl:text>(</xsl:text>
			<xsl:value-of select="kommentar" />
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil/auswahlen" mode="begabung">
		<xsl:apply-templates select="auswahl" mode="begabung">
			<xsl:sort select="name" order="ascending" />
		</xsl:apply-templates>
		<xsl:if test="not(position() = last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil/auswahlen/auswahl" mode="begabung">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="auswahlen">
		<xsl:apply-templates select="auswahl">
			<xsl:sort select="name" order="ascending" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="auswahlen/auswahl">
		<xsl:value-of select="name" />
		<xsl:if test="not(position() = last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten">
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstGeweiht']" mode="sfSonstGeweiht" />
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'Ritual']" mode="sfRitual" />
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'Liturgie']" mode="sfLiturgie" />

		<xsl:variable name="SonderfertigkeitenAusserKampf">
			<xsl:apply-templates
				select="sonderfertigkeit[not(bereich = 'Kampf') and not(bereich = 'Ritual')  and not(bereich = 'Ritualkenntnis') and not(bereich = 'Liturgie') and not(bereich = 'Merkmalskenntnis') and not(bereich = 'Repräsentation') and not(bereich = 'SonstMagisch')]" />
		</xsl:variable>
		<field name="Sonderfertigkeiten (ausser Kampf) 1">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 0, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 2">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 60, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 3">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 120, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 4">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 180, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 5">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 240, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 6">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 300, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Sonderfertigkeiten (ausser Kampf) 7">
			<value>
				<xsl:value-of select="substring($SonderfertigkeitenAusserKampf, 360)"></xsl:value-of>
			</value>
		</field>

		<xsl:variable name="MagSonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstMagisch' and not(bereich = 'Talentspezialisierung')]" />
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstGeweiht' and not(bereich = 'Talentspezialisierung')]" />
		</xsl:variable>
		<field name="Magische Sonderfertigkeiten.0">
			<value>
				<xsl:value-of select="substring($MagSonderfertigkeiten, 0, 60)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Sonderfertigkeiten.1">
			<value>
				<xsl:value-of select="substring($MagSonderfertigkeiten, 60, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Sonderfertigkeiten.2">
			<value>
				<xsl:value-of select="substring($MagSonderfertigkeiten, 155, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Sonderfertigkeiten.3">
			<value>
				<xsl:value-of select="substring($MagSonderfertigkeiten, 245, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Magische Sonderfertigkeiten.4">
			<value>
				<xsl:value-of select="substring($MagSonderfertigkeiten, 335)"></xsl:value-of>
			</value>
		</field>

		<field name="Merkmale">
			<value>
				<xsl:for-each select="sonderfertigkeit[bereich = 'Merkmalskenntnis']">
					<xsl:value-of select="name" />
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</value>
		</field>
		<field name="Repräsentationen">
			<value>
				<xsl:for-each select="sonderfertigkeit[bereich = 'Repräsentation']">
					<xsl:value-of select="name" />
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</value>
		</field>

		<xsl:variable name="NK_Sonderfertigkeiten">
			<xsl:apply-templates
				select="sonderfertigkeit[bereich = 'Nahkampf' and not(bezeichner='Linkhand') and not(bezeichner='Rüstungsgewöhnung II') and not(bezeichner='Rüstungsgewöhnung III') and not(bezeichner='Ausweichen I') and not(bezeichner='Ausweichen II')  and not(bezeichner='Ausweichen III') and not(bezeichner='Schildkampf I') and not(bezeichner='Schildkampf II') and not(bezeichner='Parierwaffen I') and not(bezeichner='Parierwaffen II') and not(bezeichner='Kampfreflexe') and not(bezeichner='Kampfgespür')]" />
		</xsl:variable>
		<field name="Nahkampf (Sonderfertigkeiten) 1">
			<value>
				<xsl:value-of select="substring($NK_Sonderfertigkeiten, 0, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Nahkampf (Sonderfertigkeiten) 2">
			<value>
				<xsl:value-of select="substring($NK_Sonderfertigkeiten, 95, 100)"></xsl:value-of>
			</value>
		</field>
		<field name="Nahkampf (Sonderfertigkeiten) 3">
			<value>
				<xsl:value-of select="substring($NK_Sonderfertigkeiten, 195)"></xsl:value-of>
			</value>
		</field>
		<xsl:variable name="FK_Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'Fernkampf']" />
		</xsl:variable>
		<field name="Fernkampf (Sonderfertigkeiten) 1">
			<value>
				<xsl:value-of select="substring($FK_Sonderfertigkeiten, 0, 95)"></xsl:value-of>
			</value>
		</field>
		<field name="Fernkampf (Sonderfertigkeiten) 2">
			<value>
				<xsl:value-of select="substring($FK_Sonderfertigkeiten, 95)"></xsl:value-of>
			</value>
		</field>
		<xsl:variable name="Waffenlos_Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'Manöver']" />
		</xsl:variable>
		<field name="Waffenloser Kampf (Sonderfertigkeiten) 1">
			<value>
				<xsl:value-of select="substring($Waffenlos_Sonderfertigkeiten, 0, 45)"></xsl:value-of>
			</value>
		</field>
		<field name="Waffenloser Kampf (Sonderfertigkeiten) 2">
			<value>
				<xsl:value-of select="substring($Waffenlos_Sonderfertigkeiten, 45, 80)"></xsl:value-of>
			</value>
		</field>
		<field name="Waffenloser Kampf (Sonderfertigkeiten) 3">
			<value>
				<xsl:value-of select="substring($Waffenlos_Sonderfertigkeiten, 125)"></xsl:value-of>
			</value>
		</field>
		<!-- Checkboxen -->
		<xsl:apply-templates mode="sfCheckboxes" />
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen I']" mode="sfCheckboxes">
		<field name="Ausweichen I">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen II']" mode="sfCheckboxes">
		<field name="Ausweichen II">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen III']" mode="sfCheckboxes">
		<field name="Ausweichen III">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung I']" mode="sfCheckboxes">
		<field name="Rüstungsgewöhnung I">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung II']"
		mode="sfCheckboxes">
		<field name="Rüstungsgewöhnung II">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung III']"
		mode="sfCheckboxes">
		<field name="Rüstungsgewöhnung III">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Kampfreflexe']" mode="sfCheckboxes">
		<field name="Kampfreflexe">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Kampfgespür']" mode="sfCheckboxes">
		<field name="Kampfgespür">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Linkhand']" mode="sfCheckboxes">
		<field name="Linkhand">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Schildkampf I']" mode="sfCheckboxes">
		<field name="Schildkampf I">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Schildkampf II']" mode="sfCheckboxes">
		<field name="Schildkampf II">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Parierwaffen I']" mode="sfCheckboxes">
		<field name="Parierwaffen I">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Parierwaffen II']" mode="sfCheckboxes">
		<field name="Parierwaffen II">
			<value>
				<xsl:text>Yes</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit">
		<xsl:choose>
			<xsl:when test="starts-with(name, 'Talentspezialisierung')">
				<xsl:value-of select="substring-after(name, 'Talentspezialisierung ')" />
			</xsl:when>
			<xsl:when test="starts-with(name, 'Zauberspezialisierung')">
				<xsl:value-of select="substring-after(name, 'Zauberspezialisierung ')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="bezeichner" />
				<xsl:if test="count(auswahlen/auswahl) > 0">
					<xsl:text> </xsl:text>
					<xsl:text>(</xsl:text>				
					<xsl:apply-templates select="auswahlen"/>
					<xsl:text>)</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
			<xsl:text> </xsl:text>
			<xsl:text>(</xsl:text>
			<xsl:value-of select="kommentar" />
			<xsl:text>)</xsl:text>
		</xsl:if>
		<xsl:if test="not(position() = last())">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfLiturgie">
		<xsl:variable name="POS" select="position() - 1" />
		<field name="Liturgiename.{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Liturgiegrad.{$POS}">
			<value>
				<xsl:value-of select="grad" />
			</value>
		</field>
		<field name="Liturgiewirkung.{$POS}">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="kosten" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="kommentar" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfSonstGeweiht">
		<!-- TODO: wohin damit? Vorerst in MagSonderfertigkeit; siehe dort -->
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfRitual">
		<xsl:variable name="POS" select="position() - 1" />
		<field name="Ritualname 1.{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ritualprobe 1.{$POS}">
			<value>
				<xsl:value-of select="probe" />
			</value>
		</field>
		<field name="Ritualdauer 1.{$POS}">
			<value>
				<xsl:value-of select="dauer" />
			</value>
		</field>
		<field name="Ritualkosten 1.{$POS}">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="kosten" />
				</xsl:if>
			</value>
		</field>
		<field name="Wirkung / Anmerkung 1.{$POS}">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="kosten" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="kommentar" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfRitualkenntnis">
		<xsl:variable name="POS" select="position() - 1" />
		<field name="Ritualkenntnis {$POS}.0">
			<value>
				<xsl:value-of select="substring-after(name,'Ritualkenntnis: ')" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente">
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Gaben']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Gaben'" />
			<xsl:with-param name="POSPLUS" select="0" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Kampf']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POSPLUS" select="6" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Körperlich']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POSPLUS" select="11" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Gesellschaft']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Gesellschaftliche Talente'" />
			<xsl:with-param name="POSPLUS" select="2" />
		</xsl:apply-templates>
		<xsl:if test="not($workaroundMetatalente = 'true')">
			<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Natur']" mode="talenteWeitere">
				<xsl:with-param name="SECTION" select="'Natur-Talente'" />
				<xsl:with-param name="POSPLUS" select="3" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$workaroundMetatalente = 'true'">
			<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Natur' and metatalent = 'false']" mode="talenteWeitere">
				<xsl:with-param name="SECTION" select="'Natur-Talente'" />
				<xsl:with-param name="POSPLUS" select="3" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Wissen']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Wissenstalente'" />
			<xsl:with-param name="POSPLUS" select="3" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Handwerk']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POSPLUS" select="6" />
		</xsl:apply-templates>
		<!-- Sprachen -->
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Sprachen' and muttersprache='true']"
			mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Sprachen &amp; Schriften'" />
			<xsl:with-param name="POSPLUS" select="0" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Sprachen' and muttersprache='true']"
			mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Sprachen und Schriften'" />
			<xsl:with-param name="POSPLUS" select="0" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and (bereich = 'Sprachen' or bereich = 'Schriften') and not(muttersprache='true')]"
			mode="talenteWeitere">
			<xsl:sort select="bereich" order="descending" />
			<xsl:sort select="name" />
			<xsl:with-param name="SECTION" select="'Sprachen &amp; Schriften'" />
			<xsl:with-param name="POSPLUS" select="1" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and (bereich = 'Sprachen' or bereich = 'Schriften') and not(muttersprache='true')]"
			mode="talenteWeitere">
			<xsl:sort select="bereich" order="descending" />
			<xsl:sort select="name" />
			<xsl:with-param name="SECTION" select="'Sprachen und Schriften'" />
			<xsl:with-param name="POSPLUS" select="1" />
		</xsl:apply-templates>
		<!-- Basis -->
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Dolche']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Hiebwaffen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Raufen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'3'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Ringen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'4'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Säbel']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'5'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Wurfmesser']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kampftechniken'" />
			<xsl:with-param name="POS" select="'6'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Athletik']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Klettern']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Körperbeherrschung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'3'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schleichen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'4'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schwimmen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'5'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Selbstbeherrschung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'6'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sich verstecken']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'7'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Singen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'8'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sinnenschärfe']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'9'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Tanzen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'10'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Zechen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Körperliche Talente'" />
			<xsl:with-param name="POS" select="'11'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Menschenkenntnis']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Gesellschaftliche Talente'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Überreden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Gesellschaftliche Talente'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Fährtensuchen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Natur-Talente'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Orientierung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Natur-Talente'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Wildnisleben']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Natur-Talente'" />
			<xsl:with-param name="POS" select="'3'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Götter und Kulte']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Wissenstalente'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Rechnen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Wissenstalente'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sagen und Legenden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Wissenstalente'" />
			<xsl:with-param name="POS" select="'3'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Heilkunde: Wunden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'1'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Holzbearbeitung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'2'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Kochen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'3'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Lederarbeiten']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'4'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Malen/Zeichnen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'5'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schneidern']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Handwerkliche Talente'" />
			<xsl:with-param name="POS" select="'6'" />
		</xsl:apply-templates>
		<!-- Ritualkenntnis -->
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Ritualkenntnis' or bereich = 'Liturgiekenntnis']"
			mode="talenteRitualkenntnis">
		</xsl:apply-templates>
		<xsl:call-template name="metatalente"></xsl:call-template>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="talenteSpezialisierung">
		<xsl:param name="SECTION" />
		<xsl:variable name="SEARCH">
			<xsl:text>Talentspezialisierung </xsl:text>
			<xsl:value-of select="$SECTION" />
			<xsl:text> </xsl:text>
		</xsl:variable>
		<field name="{$SECTION}_spez">
			<value>
				<xsl:value-of select="substring-after(name, $SEARCH)" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteBasis">
		<xsl:param name="SECTION" />
		<xsl:param name="POS" />
		<field name="{$SECTION} {$POS}">
			<value>
				<xsl:value-of select="nameausfuehrlich" />
				<xsl:if test="not($SECTION = 'Kampftechniken')">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="translate(probe,'/',' ')" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:if test="$includeTAW = 'true'">
			<field name="{$SECTION} (TaW) {$POS}.1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="{$SECTION} (BE) {$POS}">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<field name="{$SECTION} (Kosten) {$POS}">
			<value>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION} (Komp.) {$POS}">
			<value>
				<xsl:if test="string-length(sprachkomplexität) > 0">
					<xsl:value-of select="sprachkomplexität" />
					<xsl:text>/</xsl:text>
				</xsl:if>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION} (AT) {$POS}">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="{$SECTION} (PA) {$POS}">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<xsl:variable name="NAME" select="name" />
		<xsl:apply-templates
			select="/daten/sonderfertigkeiten/sonderfertigkeit[bereich='Talentspezialisierung' and contains(name, $NAME)]" mode="talenteSpezialisierung">
			<xsl:with-param name="SECTION" select="$SECTION" />
		</xsl:apply-templates>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteWeitere">
		<xsl:param name="SECTION" />
		<xsl:param name="POSPLUS" />
		<xsl:variable name="POS" select="position() + $POSPLUS" />
		<field name="{$SECTION} {$POS}">
			<value>
				<xsl:value-of select="nameausfuehrlich" />
				<xsl:if test="not($SECTION = 'Kampftechniken')">
					<xsl:text> (</xsl:text>
					<xsl:value-of select="translate(probe,'/',' ')" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:if test="$includeTAW = 'true'">
			<field name="{$SECTION} (TaW) {$POS}.1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<xsl:if test="$includeTAW = 'true'">
			<field name="{$SECTION} TaW {$POS}.1">
				<!-- Gaben -->
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="{$SECTION} (BE) {$POS}">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<field name="{$SECTION} (Kosten) {$POS}">
			<value>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION} (Komp.) {$POS}">
			<value>
				<xsl:if test="string-length(sprachkomplexität) > 0">
					<xsl:value-of select="sprachkomplexität" />
					<xsl:text>/</xsl:text>
				</xsl:if>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION} (AT) {$POS}">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="{$SECTION} (PA) {$POS}">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteRitualkenntnis">
		<xsl:variable name="POS" select="position()" />
		<field name="Ritualkenntnis {$POS}.0">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ritualkenntnis {$POS}.1">
			<value>
				<xsl:value-of select="wert" />
			</value>
		</field>
		<field name="Liturgiekenntnis">
			<value>
				<xsl:value-of select="wert" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template name="metatalente">
		<xsl:if test="$includeMetatalente = 'true'">
			<xsl:variable name="SECTION" select="'Wissenstalente'" />
			<xsl:variable name="POS" select="15" />
			<!-- Nahrung sammeln + Kräuter suchen WdS 189/190 -->
			<xsl:if test="/daten/talente/talent[name = 'Wildnisleben'] and /daten/talente/talent[name = 'Sinnenschärfe'] and /daten/talente/talent[name = 'Pflanzenkunde']">
				<field name="{$SECTION} {$POS+0}">
					<value>
						<xsl:text>Nahrung/Kräuter sammeln</xsl:text>
						<xsl:text> (MU IN FF)</xsl:text>
					</value>
				</field>
				<field name="{$SECTION} (TaW) {$POS+0}.1">
					<value>
						<xsl:value-of select="
							round(
								(
									  number(/daten/talente/talent[name = 'Wildnisleben']/wert) 
									+ number(/daten/talente/talent[name = 'Sinnenschärfe']/wert) 
									+ number(/daten/talente/talent[name = 'Pflanzenkunde']/wert)
								) div 3
							)" />
					</value>
				</field>
			</xsl:if>
			<!-- Pirschjagd + Ansitzjagd WdS 189/190 -->
			<xsl:if test="/daten/talente/talent[name = 'Wildnisleben'] and /daten/talente/talent[name = 'Tierkunde'] and /daten/talente/talent[name = 'Fährtensuchen'] and /daten/talente/talent[name = 'Schleichen']">
				<field name="{$SECTION} {$POS+1}">
					<value>
						<xsl:text>Jagd + 1/5 Fernkampfwaffe</xsl:text>
						<xsl:text> (MU IN GE)</xsl:text>
					</value>
				</field>
				<field name="{$SECTION} (TaW) {$POS+1}.1">
					<value>
						<xsl:value-of select="
							round(
								 (
									   number(/daten/talente/talent[name = 'Wildnisleben']/wert)
									 + number(/daten/talente/talent[name = 'Tierkunde']/wert) 
									 + number(/daten/talente/talent[name = 'Fährtensuchen']/wert) 
									 + number(/daten/talente/talent[name = 'Schleichen']/wert)
								 ) div 5
							 )" />
					</value>
				</field>
			</xsl:if>
			<!-- Wache halten Hausregel Helden-Software http://wiki.helden-software.de/Regelbasis -->
			<field name="{$SECTION} {$POS+2}">
				<value>
					<xsl:text>Wache halten</xsl:text>
					<xsl:text> (MU IN KO)</xsl:text>
				</value>
			</field>
			<field name="{$SECTION} (TaW) {$POS+2}.1">
				<value>
					<xsl:value-of select="
						round(
							 (
								  number(/daten/talente/talent[name = 'Selbstbeherrschung']/wert) 
								+ number(/daten/talente/talent[name = 'Sinnenschärfe']/wert) 
								+ number(/daten/talente/talent[name = 'Sinnenschärfe']/wert)
							) div 3
						)" />
				</value>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende">
		<xsl:if test="$includeGegenstaende = 'true'">
			<xsl:apply-templates select="gegenstand[angelegt = 'false' and arten != 'Tier']" />
		</xsl:if>
		<xsl:if test="$includeTier = 'true'">
			<xsl:apply-templates select="gegenstand[arten = 'Tier']"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand">
		<xsl:variable name="POS" select="position()" />
		<field name="Ausrüstung {$POS}">
			<value>
				<xsl:if test="$includeGegenstandAnzahl = 'true'">
					<xsl:value-of select="anzahl" />
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ausrüstung (Gewicht) {$POS}">
			<value>
				<xsl:value-of select="gewicht" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand[arten = 'Tier']">
		<xsl:variable name="POS" select="position()" />
		<field name="Tiere (Name) {$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Tiere (Art) {$POS}">
			<value>
				<xsl:value-of select="details/tier/familie" />
			</value>
		</field>
		<field name="Tiere (INI) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/intuition" />
			</value>
		</field>
		<field name="Tiere (AT) {$POS}">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@at" />
			</value>
		</field>
		<field name="Tiere (PA) {$POS}">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@pa" />
			</value>
		</field>
		<field name="Tiere (TP) {$POS}">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@tp" />
			</value>
		</field>
		<field name="Tiere (LE) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/lebensenergie" />
			</value>
		</field>
		<field name="Tiere (RS) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/ruestungsschutz" />
			</value>
		</field>
		<field name="Tiere (KO) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/konstitution" />
			</value>
		</field>
		<field name="Tiere (GS) {$POS}">
			<value>
				<xsl:value-of select="format-number(details/tier/eigenschaften/geschwindigkeit, '#.##0,0', 'de')" />
			</value>
		</field>
		<field name="Tiere (AU) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/ausdauer" />
			</value>
		</field>
		<field name="Tiere (MR) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/magieresistenz" />
			</value>
		</field>
		<field name="Tiere (LO) {$POS}">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/loyalitaet" />
			</value>
		</field>
		<!-- 
		<field name="Tiere (TK) {$POS}">
			<value>
				<xsl:value-of select="" />
			</value>
		</field>
		<field name="Tiere (ZK) {$POS}">
			<value>
				<xsl:value-of select="" />
			</value>
		</field>
		 -->
	</xsl:template>
	<xsl:template match="/daten/kampfsets">
		<xsl:if test="/daten/config/rsmodell='zone'">
			<xsl:apply-templates select="kampfset[@tzm='true']" />
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset[@inbenutzung = 'false']">
		<!-- ignore -->
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset[@inbenutzung = 'true']">
		<xsl:apply-templates />
		<field name="Ausweichen (Summe)">
			<value>
				<xsl:value-of select="ausweichen" />
			</value>
		</field>
		<!-- TODO -->
		<field name="Initiative (Basis)">
			<value>
				<xsl:text></xsl:text>
			</value>
		</field>
		<field name="Initiative (gesamt)">
			<value>
				<xsl:text></xsl:text>
			</value>
		</field>
		<field name="Initiative (Basis)a">
			<value>
				<xsl:text></xsl:text>
			</value>
		</field>
		<field name="Initiative (gesamt)a">
			<value>
				<xsl:text></xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/raufen">
		<field name="Waffenloser Kampf (AT) 1">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Waffenloser Kampf (PA) 1">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Waffenloser Kampf (TP(A)) 1">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ringen">
		<field name="Waffenloser Kampf (AT) 2">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Waffenloser Kampf (PA) 2">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Waffenloser Kampf (TP(A)) 2">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ruestungzonen">
		<field name="RS (Kopf)">
			<value>
				<xsl:value-of select="kopf" />
			</value>
		</field>
		<field name="RS (Oberkörper)">
			<value>
				<xsl:value-of select="brust" />
			</value>
		</field>
		<field name="RS (Rücken)">
			<value>
				<xsl:value-of select="ruecken" />
			</value>
		</field>
		<field name="RS (Unterleib)">
			<value>
				<xsl:value-of select="bauch" />
			</value>
		</field>
		<field name="RS (linker Arm)">
			<value>
				<xsl:value-of select="linkerarm" />
			</value>
		</field>
		<field name="RS (rechter Arm)">
			<value>
				<xsl:value-of select="rechterarm" />
			</value>
		</field>
		<field name="RS (linkes Bein)">
			<value>
				<xsl:value-of select="linkesbein" />
			</value>
		</field>
		<field name="RS (rechtes Bein)">
			<value>
				<xsl:value-of select="rechtesbein" />
			</value>
		</field>
		<field name="Rüstung (RS)">
			<value>
				<xsl:value-of select="gesamtzonenschutz" />
			</value>
		</field>
		<field name="BE">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<!-- blatt a -->
		<field name="RS (Kopf)a">
			<value>
				<xsl:value-of select="kopf" />
			</value>
		</field>
		<field name="RS (Oberkörper)a">
			<value>
				<xsl:value-of select="brust" />
			</value>
		</field>
		<field name="RS (Rücken)a">
			<value>
				<xsl:value-of select="ruecken" />
			</value>
		</field>
		<field name="RS (Unterleib)a">
			<value>
				<xsl:value-of select="bauch" />
			</value>
		</field>
		<field name="RS (linker Arm)a">
			<value>
				<xsl:value-of select="linkerarm" />
			</value>
		</field>
		<field name="RS (rechter Arm)a">
			<value>
				<xsl:value-of select="rechterarm" />
			</value>
		</field>
		<field name="RS (linkes Bein)a">
			<value>
				<xsl:value-of select="linkesbein" />
			</value>
		</field>
		<field name="RS (rechtes Bein)a">
			<value>
				<xsl:value-of select="rechtesbein" />
			</value>
		</field>
		<field name="Rüstung (RS)a">
			<value>
				<xsl:value-of select="gesamtzonenschutz" />
			</value>
		</field>
		<field name="BEa">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/nahkampfwaffen">
		<xsl:apply-templates select="nahkampfwaffe" />
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/nahkampfwaffen/nahkampfwaffe">
		<xsl:variable name="POS" select="position()" />
		<field name="Nahkampfwaffe {$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Nahkampfwaffe (Typ/eBE) {$POS}">
			<value>
				<xsl:value-of select="spalte2" />
			</value>
		</field>
		<field name="Nahkampfwaffe (DK) {$POS}">
			<value>
				<xsl:value-of select="translate(dk, ' ', '')" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP) {$POS}">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP/KK) {$POS}">
			<value>
				<xsl:value-of select="tpkk" />
			</value>
		</field>
		<field name="Nahkampfwaffe (INI) {$POS}">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="Nahkampfwaffe (WM) {$POS}">
			<value>
				<xsl:value-of select="wm" />
			</value>
		</field>
		<field name="Nahkampfwaffe (AT) {$POS}">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Nahkampfwaffe (PA) {$POS}">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP(KK)) {$POS}">
			<value>
				<xsl:value-of select="tpinkl" />
			</value>
		</field>
		<field name="Nahkampfwaffe (Bruchfaktor) {$POS}.1">
			<value>
				<xsl:value-of select="bfmin" />
			</value>
		</field>
		<!-- weiteres blatt a -->
		<field name="Nahkampfwaffe {$POS}a">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Nahkampfwaffe (Typ/eBE) {$POS}a">
			<value>
				<xsl:value-of select="spalte2" />
			</value>
		</field>
		<field name="Nahkampfwaffe (DK) {$POS}a">
			<value>
				<xsl:value-of select="translate(dk, ' ', '')" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP) {$POS}a">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP/KK) {$POS}a">
			<value>
				<xsl:value-of select="tpkk" />
			</value>
		</field>
		<field name="Nahkampfwaffe (INI) {$POS}a">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="Nahkampfwaffe (WM) {$POS}a">
			<value>
				<xsl:value-of select="wm" />
			</value>
		</field>
		<field name="Nahkampfwaffe (AT) {$POS}a">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Nahkampfwaffe (PA) {$POS}a">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Nahkampfwaffe (TP(KK)) {$POS}a">
			<value>
				<xsl:value-of select="tpinkl" />
			</value>
		</field>
		<field name="Nahkampfwaffe (Bruchfaktor) {$POS}.1a">
			<value>
				<xsl:value-of select="bfmin" />
			</value>
		</field>
		<!-- <field name="NK_{$POS}_BF_2"> <value> <xsl:value-of select="bfakt" /> </value> </field> -->
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/fernkampfwaffen">
		<xsl:apply-templates select="fernkampfwaffe" />
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/fernkampfwaffen/fernkampfwaffe">
		<xsl:variable name="POS" select="position()" />
		<field name="Fernkampfwaffe {$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Fernkampfwaffe (Typ/eBE) {$POS}">
			<value>
				<xsl:value-of select="spalte2" />
			</value>
		</field>
		<field name="Fernkampfwaffe (Entfernungen) {$POS}">
			<value>
				<xsl:value-of select="reichweite" />
			</value>
		</field>
		<field name="Fernkampfwaffe (TP) {$POS}">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="Fernkampfwaffe (TP/Entfernung) {$POS}">
			<value>
				<xsl:value-of select="tpmod" />
			</value>
		</field>
		<field name="Fernkampfwaffe (FK) {$POS}">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<!-- zusätzliches blatt a -->
		<field name="Fernkampfwaffe {$POS}a">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Fernkampfwaffe (Typ/eBE) {$POS}a">
			<value>
				<xsl:value-of select="spalte2" />
			</value>
		</field>
		<field name="Fernkampfwaffe (Entfernungen) {$POS}a">
			<value>
				<xsl:value-of select="reichweite" />
			</value>
		</field>
		<field name="Fernkampfwaffe (TP) {$POS}a">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="Fernkampfwaffe (TP/Entfernung) {$POS}a">
			<value>
				<xsl:value-of select="tpmod" />
			</value>
		</field>
		<field name="Fernkampfwaffe (FK) {$POS}a">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/schilder">
		<xsl:apply-templates select="schild" />
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/schilder/schild">
		<xsl:variable name="POS" select="position()" />
		<field name="Schild / Parierwaffe {$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (Typ) {$POS}">
			<value>
				<xsl:value-of select="typ" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (INI) {$POS}">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (WM) {$POS}">
			<value>
				<xsl:value-of select="mod" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (PA) {$POS}">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (Bruchfaktor) {$POS}.1">
			<value>
				<xsl:value-of select="bfmin" />
			</value>
		</field>
		<!-- blatt a -->
		<field name="Schild / Parierwaffe {$POS}a">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (Typ) {$POS}a">
			<value>
				<xsl:value-of select="typ" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (INI) {$POS}a">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (WM) {$POS}a">
			<value>
				<xsl:value-of select="mod" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (PA) {$POS}a">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Schild / Parierwaffe (Bruchfaktor) {$POS}.1a">
			<value>
				<xsl:value-of select="bfmin" />
			</value>
		</field>
		<!-- <field name="Schild_{$POS}_BF_2"> <value> <xsl:value-of select="bfakt" /> </value> </field> -->
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ruestungen">
		<xsl:apply-templates select="ruestung" />
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ruestungen/ruestung">
		<xsl:variable name="POS" select="position()" />
		<field name="Rüstungsstück {$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Rüstungsstück (RS) {$POS}">
			<value>
				<xsl:value-of select="rs" />
			</value>
		</field>
		<field name="Rüstungsstück (BE) {$POS}">
			<value>
				<xsl:value-of select="be" />
			</value>
		</field>
		<!-- blatt a -->
		<field name="Rüstungsstück {$POS}a">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Rüstungsstück (RS) {$POS}a">
			<value>
				<xsl:value-of select="rs" />
			</value>
		</field>
		<field name="Rüstungsstück (BE) {$POS}a">
			<value>
				<xsl:value-of select="be" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/zauber">
		<xsl:apply-templates select="zauber" />
	</xsl:template>
	<xsl:template match="/daten/zauber/zauber">
		<xsl:variable name="ORGPOS" select="position()" />
		<xsl:variable name="PAGE">
			<xsl:choose>
				<xsl:when test="$ORGPOS &gt; 33">
					<xsl:text>2</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>1</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="POS">
			<xsl:choose>
				<xsl:when test="$ORGPOS &gt; 33">
					<xsl:value-of select="$ORGPOS - 34" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ORGPOS -1" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<field name="Zaubername {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<!-- <field name="{$POS}_se"> <value> <xsl:value-of select="" /> </value> </field> -->
		<field name="Probe {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="probe" />
				<xsl:value-of select="mr" />
			</value>
		</field>
		<xsl:if test="$includeZFW = 'true'">
			<field name="ZfW {$PAGE}a.{$POS}">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="Zauberdauer {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="zauberdauer" />
			</value>
		</field>
		<field name="Kosten {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="kosten" />
			</value>
		</field>
		<field name="Reichweite {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="reichweite" />
			</value>
		</field>
		<field name="Wirkungsdauer {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="wirkungsdauer" />
			</value>
		</field>
		<field name="Anmerkung {$PAGE}.{$POS}">
			<value>
				<xsl:if test="$includeLCSeite = 'true'">
					<xsl:value-of select="quelle/@seite" />
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="spezialisierungen" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="anmerkung" />
			</value>
		</field>
		<field name="Komplexität {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="komplexität" />
			</value>
		</field>
		<field name="Repräsentation {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="repräsentation" />
			</value>
		</field>
		<field name="Merkmale {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="merkmale" />
			</value>
		</field>
		<field name="Hauszauber {$PAGE}.{$POS}">
			<value>
				<xsl:if test="hauszauber = 'true'">
					<xsl:text>x</xsl:text>
				</xsl:if>
			</value>
		</field>
		<field name="Lernschwierigkeit {$PAGE}.{$POS}">
			<value>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
	</xsl:template>
</xsl:stylesheet>