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
	<xsl:param name="workaroundMetatalente" select="'false'" />
	<!--
		includeTier:
		'true': Tiere eintragen
		'false': keine Tiere eintragen
	-->
	<xsl:param name="includeTier" select="'true'" />
	<xsl:variable name="checkbox">
		<xsl:text>x</xsl:text>
		<!-- filled circle -->
		<!-- <xsl:text>&#x25CF;</xsl:text> -->
		<!-- filled star -->
		<!-- <xsl:text>&#x2605;</xsl:text> -->
		<!-- checked mark -->
		<!-- <xsl:text>&#x2714;</xsl:text> -->
		<!-- checked cross -->
		<!-- <xsl:text>&#x2718;</xsl:text> -->
	</xsl:variable>
	<!-- Templates -->
	<xsl:template match="@*|text()" />
	<xsl:template match="@*|text()" mode="sfCheckboxes" />
	<xsl:template match="@*|text()" mode="vorteil" />
	<xsl:template match="@*|text()" mode="nachteil" />
	<xsl:template match="@*|text()" mode="schlechteeigenschaft" />
	<xsl:template match="@*|text()" mode="begabung" />
	<xsl:template match="@*|text()" mode="sfSonstGeweiht" />
	<xsl:template match="@*|text()" mode="sfRitual" />
	<xsl:template match="@*|text()" mode="sfLiturgie" />
	<xsl:template match="@*|text()" mode="sfRitualkenntnis" />
	<xsl:template match="@*|text()" mode="talenteWeitere" />
	<xsl:template match="@*|text()" mode="talenteBasis" />
	<xsl:template match="@*|text()" mode="talenteRitualkenntnis" />
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
		<field name="name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="augenfarbe">
			<value>
				<xsl:value-of select="augenfarbe" />
			</value>
		</field>
		<field name="alter">
			<value>
				<xsl:value-of select="geburtstag" />
				<xsl:text> </xsl:text>
				<xsl:text>(</xsl:text>
				<xsl:value-of select="alter" />
				<xsl:text>)</xsl:text>
			</value>
		</field>
		<field name="geschlecht">
			<value>
				<xsl:value-of select="geschlecht" />
			</value>
		</field>
		<field name="groesse">
			<value>
				<xsl:value-of select="round(number(groesse) div 2)" />
				<xsl:text> Finger</xsl:text>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="groesse" />
				<xsl:text> cm)</xsl:text>
			</value>
		</field>
		<field name="gewicht">
			<value>
				<xsl:value-of select="gewicht" />
				<xsl:text> Stein</xsl:text>
			</value>
		</field>
		<field name="haarfarbe">
			<value>
				<xsl:value-of select="haarfarbe" />
			</value>
		</field>
		<field name="stand">
			<value>
				<xsl:value-of select="stand" />
			</value>
		</field>
		<field name="titel">
			<value>
				<xsl:value-of select="titel" />
			</value>
		</field>
		<field name="rasse">
			<value>
				<xsl:value-of select="rasse" />
			</value>
		</field>
		<field name="kultur">
			<value>
				<xsl:value-of select="kultur" />
			</value>
		</field>
		<field name="Regeneration">
			<value>
				<xsl:value-of select="aspregeneration" />
			</value>
		</field>
		<field name="wundschwelle">
			<value>
				<xsl:value-of select="wundschwelle" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/notizen">
		<field name="notizen1">
			<value>
				<xsl:value-of select="text" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/aussehen">
		<xsl:variable name="Aussehen">
			<xsl:value-of select="text" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="../familie/text" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$Aussehen" />
			<xsl:with-param name="name" select="'aussehen'" />
			<xsl:with-param name="total" select="30" />
			<xsl:with-param name="indexmax" select="16" />
		</xsl:call-template>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/familie">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/profession">
		<field name="profession">
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
		<field name="AP_gesamt">
			<value>
				<xsl:value-of select="format-number(gesamt, '#.###', 'de')" />
			</value>
		</field>
		<field name="AP_eingesetzt">
			<value>
				<xsl:value-of select="format-number(genutzt, '#.###', 'de')" />
			</value>
		</field>
		<field name="AP_guthaben">
			<value>
				<xsl:value-of select="format-number(frei, '#.###', 'de')" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/angaben/gp">
		<field name="gpbasis">
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
		<field name="GS_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="GS_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="GS_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/astralenergie">
		<xsl:if test="/daten/angaben/magisch = 'true'">
			<field name="ASP_akt">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<field name="ASP_start">
				<value>
					<xsl:value-of select="muinch2" />
				</value>
			</field>
			<field name="ASP_mod">
				<value>
					<xsl:value-of select="modi" />
				</value>
			</field>
			<field name="ASP_zugek">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="ASP_max">
				<value>
					<!-- TODO korrekt? -->
					<xsl:value-of select="kaufbar" />
				</value>
			</field>
			<!-- Rechnung -->
			<field name="Rechnung_AE_1">
				<value>
					<xsl:value-of select="muinch2" />
				</value>
			</field>
			<field name="Rechnung_AE_mod">
				<value>
					<xsl:value-of select="professionmod" />
				</value>
			</field>
			<field name="Rechnung_AE_VorNachteil">
				<value>
					<xsl:value-of select="ausvornachteile" />
				</value>
			</field>
			<field name="Rechnung_AE_SF">
				<value>
					<xsl:value-of select="aussonderfertigkeiten" />
				</value>
			</field>
			<field name="Rechnung_AE_Med">
				<value>
					<xsl:value-of select="grossemeditation" />
				</value>
			</field>
			<field name="Rechnung_AE_Zukauf">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="Rechnung_AE_Max">
				<value>
					<xsl:value-of select="aktinklrueckkaufbarepasp" />
				</value>
			</field>
			<field name="Rechnung_AE_pASP">
				<value>
					<xsl:value-of select="pasprueckkaufbar" />
				</value>
			</field>
			<field name="Rechnung_AE_aktuell">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<!-- ASP aktuelle Werte -->
			<field name="ASP_maximal">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
		</xsl:if>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/karmaenergie">
		<xsl:if test="/daten/angaben/geweiht = 'true'">
			<field name="KE_akt">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
			<field name="KE_start">
				<value>
					<xsl:value-of select="start" />
				</value>
			</field>
			<field name="KE_mod">
				<value>
					<xsl:value-of select="modi" />
				</value>
			</field>
			<field name="KE_zugek">
				<value>
					<xsl:value-of select="gekauft" />
				</value>
			</field>
			<field name="KE_max">
				<value>
					<!-- TODO korrekt? -->
					<xsl:value-of select="kaufbar" />
				</value>
			</field>
			<!-- KE aktuelle Werte -->
			<field name="KE_maximal">
				<value>
					<xsl:value-of select="akt" />
				</value>
			</field>
		</xsl:if>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/magieresistenz">
		<field name="MR_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="MR_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="MR_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="MR_zugek">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="MR_max">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<!-- Rechnung -->
		<field name="Rechnung_MR_1">
			<value>
				<xsl:value-of select="
					round(
						(
							  number(/daten/eigenschaften/mut/akt)
						 	+ number(/daten/eigenschaften/klugheit/akt)
						  	+ number(/daten/eigenschaften/konstitution/akt)
						) div 5
					)" />
			</value>
		</field>
		<field name="Rechnung_MR_mod">
			<value>
				<xsl:value-of select="modi" />
				<xsl:if test="gekauft != 0">
					<xsl:text> + </xsl:text>
					<xsl:value-of select="gekauft" />
				</xsl:if>
			</value>
		</field>
		<field name="Rechnung_MR_VorNachteil">
			<value>
				<xsl:value-of select="''" />
			</value>
		</field>
		<field name="Rechnung_MR_SF">
			<value>
				<xsl:value-of select="''" />
			</value>
		</field>
		<field name="Rechnung_MR_aktuell">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/initiative">
		<field name="INI_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="INI_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="INI_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/attacke">
		<field name="AT_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="AT_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="AT_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/parade">
		<field name="PA_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="PA_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="PA_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/fernkampf-basis">
		<field name="FK_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="FK_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="FK_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/lebensenergie">
		<field name="LE_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="LE_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="LE_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="LE_zugek">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="LE_max">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<!-- LE aktuelle Werte -->
		<field name="LE_maximal">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="LE_12">
			<value>
				<xsl:value-of select="akt50" />
			</value>
		</field>
		<field name="LE_13">
			<value>
				<xsl:value-of select="akt33" />
			</value>
		</field>
		<field name="LE_14">
			<value>
				<xsl:value-of select="akt25" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/ausdauer">
		<field name="AU_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="AU_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="AU_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<field name="AU_zugek">
			<value>
				<xsl:value-of select="gekauft" />
			</value>
		</field>
		<field name="AU_max">
			<value>
				<!-- TODO korrekt? -->
				<xsl:value-of select="kaufbar" />
			</value>
		</field>
		<!-- AU aktuelle Werte -->
		<field name="AU_maximal">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="AU_12">
			<value>
				<xsl:value-of select="akt50" />
			</value>
		</field>
		<field name="AU_13">
			<value>
				<xsl:value-of select="akt33" />
			</value>
		</field>
		<field name="AU_14">
			<value>
				<xsl:value-of select="akt25" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/mut">
		<field name="MU_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="MU_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="MU_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/klugheit">
		<field name="KL_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="KL_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="KL_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/intuition">
		<field name="IN_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="IN_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="IN_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/charisma">
		<field name="CH_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="CH_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="CH_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/fingerfertigkeit">
		<field name="FF_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="FF_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="FF_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/gewandtheit">
		<field name="GE_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="GE_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="GE_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/konstitution">
		<field name="KO_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="KO_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="KO_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/koerperkraft">
		<field name="KK_akt">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<field name="KK_start">
			<value>
				<xsl:value-of select="start" />
			</value>
		</field>
		<field name="KK_mod">
			<value>
				<xsl:value-of select="modi" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/eigenschaften/sozialstatus">
		<field name="sozialstatus">
			<value>
				<xsl:value-of select="akt" />
			</value>
		</field>
		<!-- <xsl:value-of select="start" /> <xsl:value-of select="modi" /> -->
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/geld">
		<xsl:if test="$includeGeld = 'true'">
			<xsl:apply-templates />
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/geld/Dukat">
		<field name="Geld_D_1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Silbertaler">
		<field name="Geld_S_1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Heller">
		<field name="Geld_H_1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/geld/Kreuzer">
		<field name="Geld_K_1">
			<value>
				<xsl:value-of select="round(number(gesamtwertinsilberstuecken) div number(wertinsilberstuecken))" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/vorteile">
		<xsl:apply-templates select="vorteil[istvorteil = 'true' and bereich = 'Sonst']" mode="vorteil" />
		<xsl:apply-templates select="vorteil[not(istvorteil = 'true') and istnachteil = 'true' and not(istschlechteeigenschaft = 'true') and (bereich = 'Sonst' or bereich = 'Geweiht')]" mode="nachteil" />
		<xsl:apply-templates select="vorteil[not(istvorteil = 'true') and istnachteil = 'true' and istschlechteeigenschaft = 'true' and bereich = 'Sonst']" mode="schlechteeigenschaft" />
		<xsl:variable name="Begabungen">
			<xsl:apply-templates select="vorteil[bereich = 'BEGABUNGMERKMAL']" mode="begabung" />
		</xsl:variable>
		<field name="Begabungen">
			<value>
				<xsl:value-of select="$Begabungen"></xsl:value-of>
			</value>
		</field>
		<xsl:variable name="Unfaehigkeiten">
			<xsl:apply-templates select="vorteil[bereich = 'UNFÄHIGKEITMERKMAL']" mode="begabung" />
		</xsl:variable>
		<field name="Unfaehigkeiten">
			<value>
				<xsl:value-of select="$Unfaehigkeiten"></xsl:value-of>
			</value>
		</field>
		<xsl:variable name="MagVorteileNachteile">
			<xsl:apply-templates select="vorteil[bereich = 'Magisch' and not(bereich = 'BEGABUNGMERKMAL') and not(bereich = 'UNFÄHIGKEITMERKMAL')]" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$MagVorteileNachteile" />
			<xsl:with-param name="name" select="'MagVorteileNachteile_'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="2" />
			<xsl:with-param name="indexmax" select="9" />
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil" mode="schlechteeigenschaft">
		<xsl:variable name="POS" select="position()" />
		<field name="SchlechteEigenschaft{$POS}">
			<value>
				<xsl:value-of select="normalize-space(bezeichner)" />
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:text> </xsl:text>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="kommentar" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<field name="SchlechteEigenschaft_akt{$POS}">
			<value>
				<xsl:value-of select="wert" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil" mode="vorteil">
		<xsl:variable name="POS" select="position() + 1" />
		<field name="Vorteil{$POS}">
			<value>
				<xsl:value-of select="normalize-space(name)" />
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:text> </xsl:text>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="kommentar" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil" mode="nachteil">
		<xsl:variable name="POS" select="position() + 1" />
		<field name="Nachteil{$POS}">
			<value>
				<xsl:value-of select="normalize-space(name)" />
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:text> </xsl:text>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="kommentar" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil" mode="begabung">
		<xsl:apply-templates select="auswahlen" mode="begabung" />
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
		<xsl:value-of select="." />
	</xsl:template>
	<xsl:template match="/daten/vorteile/vorteil">
		<xsl:value-of select="normalize-space(name)" />
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
	<xsl:template match="/daten/sonderfertigkeiten">
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstGeweiht']" mode="sfSonstGeweiht" />
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'Ritual']" mode="sfRitual" />
		<xsl:apply-templates select="sonderfertigkeit[bereich = 'Liturgie']" mode="sfLiturgie" />
		<xsl:variable name="MagSonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstMagisch' and not(bereich = 'Talentspezialisierung')]" />
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'SonstGeweiht' and not(bereich = 'Talentspezialisierung')]" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$MagSonderfertigkeiten" />
			<xsl:with-param name="name" select="'MagSonderfertigkeiten_'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="2" />
			<xsl:with-param name="indexmax" select="12" />
		</xsl:call-template>
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
		<field name="Repraesentationen">
			<value>
				<xsl:for-each select="sonderfertigkeit[bereich = 'Repräsentation']">
					<xsl:value-of select="name" />
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</value>
		</field>
		<xsl:variable name="Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'Sonst']" />
			<!-- <xsl:apply-templates select="sonderfertigkeit[bereich = 'Liturgiekenntnis']" /> -->
			<!-- <xsl:if test="sonderfertigkeit[bereich = 'Talentspezialisierung' and bereich = 'Magisch']"> <xsl:text> Zauberspezialisierungen:
				</xsl:text> <xsl:apply-templates select="sonderfertigkeit[bereich = 'Talentspezialisierung' and bereich = 'Magisch']" />
				</xsl:if> -->
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$Sonderfertigkeiten" />
			<xsl:with-param name="name" select="'Sonderfertigkeit'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="1" />
			<xsl:with-param name="indexmax" select="9" />
		</xsl:call-template>
		<xsl:variable name="NK_Sonderfertigkeiten">
			<xsl:apply-templates
				select="sonderfertigkeit[bereich = 'Nahkampf' and not(bezeichner='Linkhand') and not(bezeichner='Rüstungsgewöhnung I')  and not(bezeichner='Rüstungsgewöhnung II') and not(bezeichner='Rüstungsgewöhnung III') and not(bezeichner='Ausweichen I') and not(bezeichner='Ausweichen II')  and not(bezeichner='Ausweichen III') and not(bezeichner='Schildkampf I') and not(bezeichner='Schildkampf II') and not(bezeichner='Parierwaffen I') and not(bezeichner='Parierwaffen II') and not(bezeichner='Kampfreflexe') and not(bezeichner='Kampfgespür')]" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$NK_Sonderfertigkeiten" />
			<xsl:with-param name="name" select="'NK_Sonderfertigkeiten_'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="2" />
			<xsl:with-param name="indexmax" select="5" />
		</xsl:call-template>
		<xsl:variable name="FK_Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'Fernkampf']" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$FK_Sonderfertigkeiten" />
			<xsl:with-param name="name" select="'FK_Sonderfertigkeiten_'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="2" />
			<xsl:with-param name="indexmax" select="5" />
		</xsl:call-template>
		<xsl:variable name="Waffenlos_Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit[bereich = 'Manöver']" />
		</xsl:variable>
		<xsl:call-template name="substring">
			<xsl:with-param name="text" select="$Waffenlos_Sonderfertigkeiten" />
			<xsl:with-param name="name" select="'Waffenlos_Sonderfertigkeiten_'" />
			<xsl:with-param name="total" select="80" />
			<xsl:with-param name="index" select="2" />
			<xsl:with-param name="indexmax" select="5" />
		</xsl:call-template>
		<!-- Checkboxen -->
		<xsl:apply-templates mode="sfCheckboxes" />
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen I']" mode="sfCheckboxes">
		<field name="SF_Ausweichen_1">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen II']" mode="sfCheckboxes">
		<field name="SF_Ausweichen_2">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen III']" mode="sfCheckboxes">
		<field name="SF_Ausweichen_3">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung I']" mode="sfCheckboxes">
		<field name="SF_Ruestungsgewoehnung_1">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
		<field name="SF_Ruestungsgewoehnung">
			<value>
				<xsl:apply-templates select="auswahlen" />
			</value>
		</field>
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
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung II']" mode="sfCheckboxes">
		<field name="SF_Ruestungsgewoehnung_2">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Rüstungsgewöhnung III']" mode="sfCheckboxes">
		<field name="SF_Ruestungsgewoehnung_3">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Kampfreflexe']" mode="sfCheckboxes">
		<field name="SF_Kampfreflexe">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Kampfgespür']" mode="sfCheckboxes">
		<field name="SF_Kampfgespuer">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Linkhand']" mode="sfCheckboxes">
		<field name="SF_Linkhand">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Schildkampf I']" mode="sfCheckboxes">
		<field name="SF_Schildkampf_1">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Schildkampf II']" mode="sfCheckboxes">
		<field name="SF_Schildkampf_2">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Parierwaffen I']" mode="sfCheckboxes">
		<field name="SF_Parierwaffen_1">
			<value>
				<xsl:value-of select="$checkbox" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Parierwaffen II']" mode="sfCheckboxes">
		<field name="SF_Parierwaffen_2">
			<value>
				<xsl:value-of select="$checkbox" />
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
					<xsl:apply-templates select="auswahlen" />
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
		<xsl:variable name="POS" select="position()" />
		<field name="Ritual_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ritual_{$POS}_probe">
			<value>
				<xsl:value-of select="probe" />
			</value>
		</field>
		<field name="Ritual_{$POS}_dauer">
			<value>
				<xsl:value-of select="dauer" />
			</value>
		</field>
		<field name="Ritual_{$POS}_kosten">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="kosten" />
				</xsl:if>
			</value>
		</field>
		<field name="Ritual_{$POS}_notiz">
			<value>
				<xsl:value-of select="grad" />
				<xsl:if test="string-length(grad) > 0">
					<xsl:text>: </xsl:text>
				</xsl:if>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="kosten" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="wirkung" />
					<xsl:if test="string-length(wirkung) > 0">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:if>
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:value-of select="kommentar" />
				</xsl:if>
			</value>
		</field>
		<!-- als zauber -->
		<field name="{$POS}_name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="{$POS}_probe">
			<value>
				<xsl:value-of select="probe" />
			</value>
		</field>
		<field name="{$POS}_zd">
			<value>
				<xsl:value-of select="dauer" />
			</value>
		</field>
		<field name="{$POS}_k">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="kosten" />
				</xsl:if>
			</value>
		</field>
		<xsl:if test="$includeZFW = 'true'">
			<field name="{$POS}_zfw_1">
				<value>
					<xsl:value-of select="grad" />
				</value>
			</field>
		</xsl:if>
		<field name="{$POS}_notiz">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="kosten" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="$includeKommentare = 'true' and string-length(kommentar) > 0">
					<xsl:value-of select="kommentar" />
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfSonstGeweiht">
		<!-- TODO: wohin damit? vorerst zu MagSonderfertigkeit; siehe dort -->
	</xsl:template>
	<xsl:template match="/daten/sonderfertigkeiten/sonderfertigkeit" mode="sfRitual">
		<xsl:variable name="POS" select="position()" />
		<field name="Ritual_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ritual_{$POS}_probe">
			<value>
				<xsl:value-of select="probe" />
			</value>
		</field>
		<field name="Ritual_{$POS}_dauer">
			<value>
				<xsl:value-of select="dauer" />
			</value>
		</field>
		<field name="Ritual_{$POS}_kosten">
			<value>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="wirkung" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="kosten" />
				</xsl:if>
			</value>
		</field>
		<field name="Ritual_{$POS}_notiz">
			<value>
				<xsl:value-of select="grad" />
				<xsl:if test="string-length(grad) > 0">
					<xsl:text>: </xsl:text>
				</xsl:if>
				<xsl:if test="$workaroundRituale = 'true'">
					<xsl:value-of select="kosten" />
				</xsl:if>
				<xsl:if test="not($workaroundRituale = 'true')">
					<xsl:value-of select="wirkung" />
					<xsl:if test="string-length(wirkung) > 0">
						<xsl:text> </xsl:text>
					</xsl:if>
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
		<xsl:variable name="POS" select="position()" />
		<field name="RK_{$POS}">
			<value>
				<xsl:value-of select="substring-after(name,'Ritualkenntnis: ')" />
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente">
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Gaben']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Gaben'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Kampf']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Kampf'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Körperlich']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Koerper'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Gesellschaft']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Gesellschaft'" />
		</xsl:apply-templates>
		<xsl:if test="not($includeMetatalente = 'true')">
			<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Natur' and metatalent = 'false']" mode="talenteWeitere">
				<xsl:with-param name="SECTION" select="'Natur'" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="$includeMetatalente = 'true'">
			<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Natur']" mode="talenteWeitere">
				<xsl:with-param name="SECTION" select="'Natur'" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Wissen']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Wissen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Handwerk']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Handwerk'" />
		</xsl:apply-templates>
		<!-- Sprachen -->
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Sprachen' and muttersprache='true']" mode="talenteWeitere">
			<xsl:with-param name="SECTION" select="'Muttersprache'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'false' and (bereich = 'Sprachen' or bereich = 'Schriften') and not(muttersprache='true')]" mode="talenteWeitere">
			<xsl:sort select="bereich" order="descending" />
			<xsl:sort select="name" order="ascending" />
			<xsl:with-param name="SECTION" select="'Sprache'" />
		</xsl:apply-templates>
		<!-- Basis -->
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Dolche']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Dolche'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Hiebwaffen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Hiebwaffen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Raufen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Raufen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Ringen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Ringen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Säbel']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Saebel'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Wurfmesser']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Wurfmesser'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Athletik']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Athletik'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Klettern']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Klettern'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Körperbeherrschung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Koerperbeherrschung'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schleichen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Schleichen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schwimmen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Schwimmen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Selbstbeherrschung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Selbstbeherrschung'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sich verstecken']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'SichVerstecken'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Singen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Singen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sinnenschärfe']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Sinnenschaerfe'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Tanzen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Tanzen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Zechen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Zechen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Menschenkenntnis']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Menschenkenntnis'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Überreden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Ueberreden'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Fährtensuchen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Faehrtensuchen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Orientierung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Orientierung'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Wildnisleben']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Wildnisleben'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Götter und Kulte']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'GoetterKulte'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Rechnen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Rechnen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Sagen und Legenden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'SagenLegenden'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Heilkunde: Wunden']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'HeilkundeWunden'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Holzbearbeitung']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Holzbearbeitung'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Kochen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Kochen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Lederarbeiten']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Lederarbeiten'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Malen/Zeichnen']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'MalenZeichnen'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="talent[basis = 'true' and name = 'Schneidern']" mode="talenteBasis">
			<xsl:with-param name="SECTION" select="'Schneidern'" />
		</xsl:apply-templates>
		<!-- Ritualkenntnis -->
		<xsl:apply-templates select="talent[basis = 'false' and bereich = 'Ritualkenntnis' or bereich = 'Liturgiekenntnis']" mode="talenteRitualkenntnis">
		</xsl:apply-templates>
		<xsl:call-template name="metatalente"></xsl:call-template>
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteBasis">
		<xsl:param name="SECTION" />
		<field name="{$SECTION}">
			<value>
				<xsl:value-of select="normalize-space(nameausfuehrlich)" />
			</value>
		</field>
		<field name="{$SECTION}_probe">
			<value>
				<xsl:value-of select="translate(probe,'/',' ')" />
			</value>
		</field>
		<xsl:if test="$includeTAW = 'true'">
			<field name="{$SECTION}_TAW_1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="{$SECTION}_BE">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<field name="{$SECTION}_komp">
			<value>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION}_AT">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="{$SECTION}_PA">
			<value>
				<xsl:value-of select="pa" />
				<xsl:if test="string-length(pa) = 0">
					<xsl:text>-</xsl:text>
				</xsl:if>
			</value>
		</field>
		<field name="{$SECTION}_spez">
			<value>
				<xsl:if test="string-length(spezialisierungen) > 0">
					<xsl:text>(</xsl:text>
					<xsl:value-of select="spezialisierungen" />
					<xsl:text>)</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteWeitere">
		<xsl:param name="SECTION" />
		<xsl:variable name="POS" select="position()" />
		<field name="{$SECTION}_{$POS}">
			<value>
				<xsl:value-of select="normalize-space(nameausfuehrlich)" />
			</value>
		</field>
		<field name="{$SECTION}_{$POS}_probe">
			<value>
				<xsl:value-of select="translate(probe,'/',' ')" />
			</value>
		</field>
		<xsl:if test="$includeTAW = 'true'">
			<field name="{$SECTION}_{$POS}_TAW_1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="{$SECTION}_{$POS}_BE">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<field name="{$SECTION}_{$POS}_komp">
			<value>
				<xsl:if test="string-length(sprachkomplexität) > 0">
					<xsl:value-of select="sprachkomplexität" />
					<xsl:text>/</xsl:text>
				</xsl:if>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
		<field name="{$SECTION}_{$POS}_AT">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="{$SECTION}_{$POS}_PA">
			<value>
				<xsl:value-of select="pa" />
				<xsl:if test="string-length(pa) = 0">
					<xsl:text>-</xsl:text>
				</xsl:if>
			</value>
		</field>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="/daten/talente/talent" mode="talenteRitualkenntnis">
		<xsl:variable name="POS" select="position()" />
		<field name="RK_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<xsl:if test="$includeTAW = 'true'">
			<field name="RK_{$POS}_TAW_1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template name="metatalente">
		<xsl:if test="$includeMetatalente = 'true' and $workaroundMetatalente = 'true'">
			<xsl:variable name="SECTION" select="'Wissen'" />
			<xsl:variable name="POS" select="16" />
			<!-- Nahrung sammeln + Kräuter suchen WdS 189/190 -->
			<xsl:if test="/daten/talente/talent[name = 'Wildnisleben'] and /daten/talente/talent[name = 'Sinnenschärfe'] and /daten/talente/talent[name = 'Pflanzenkunde']">
				<field name="{$SECTION}_{$POS+0}">
					<value>
						<xsl:text>Nahrung/Kräuter sammeln</xsl:text>
					</value>
				</field>
				<field name="{$SECTION}_{$POS+0}_probe">
					<value>
						<xsl:text>MU IN FF</xsl:text>
					</value>
				</field>
				<field name="{$SECTION}_{$POS+0}_TAW_1">
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
				<field name="{$SECTION}_{$POS+1}">
					<value>
						<xsl:text>Jagd + 1/5 Fernkampfwaffe</xsl:text>
					</value>
				</field>
				<field name="{$SECTION}_{$POS+1}_probe">
					<value>
						<xsl:text>MU IN GE</xsl:text>
					</value>
				</field>
				<field name="{$SECTION}_{$POS+1}_TAW_1">
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
			<field name="{$SECTION}_{$POS+2}">
				<value>
					<xsl:text>Wache halten</xsl:text>
				</value>
			</field>
			<field name="{$SECTION}_{$POS+2}_probe">
				<value>
					<xsl:text>MU IN KO</xsl:text>
				</value>
			</field>
			<field name="{$SECTION}_{$POS+2}_TAW_1">
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
			<xsl:apply-templates select="gegenstand[arten = 'Tier']" />
		</xsl:if>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand">
		<xsl:variable name="POS" select="position()" />
		<field name="Ausruestung_{$POS}">
			<value>
				<xsl:if test="$includeGegenstandAnzahl = 'true'">
					<xsl:value-of select="anzahl" />
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ausruestung_{$POS}_gewicht">
			<value>
				<xsl:value-of select="gewicht" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand[arten = 'Tier']">
		<xsl:variable name="POS" select="position()" />
		<field name="Tier_{$POS}_name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Tier_{$POS}_art">
			<value>
				<xsl:value-of select="details/tier/familie" />
			</value>
		</field>
		<field name="Tier_{$POS}_INI">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/intuition" />
			</value>
		</field>
		<field name="Tier_{$POS}_AT">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@at" />
			</value>
		</field>
		<field name="Tier_{$POS}_PA">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@pa" />
			</value>
		</field>
		<field name="Tier_{$POS}_TP">
			<value>
				<xsl:value-of select="details/tier/angriffe/angriff/@tp" />
			</value>
		</field>
		<field name="Tier_{$POS}_LE">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/lebensenergie" />
			</value>
		</field>
		<field name="Tier_{$POS}_RS">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/ruestungsschutz" />
			</value>
		</field>
		<field name="Tier_{$POS}_KO">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/konstitution" />
			</value>
		</field>
		<field name="Tier_{$POS}_GS">
			<value>
				<xsl:value-of select="format-number(details/tier/eigenschaften/geschwindigkeit, '#.##0,0', 'de')" />
			</value>
		</field>
		<field name="Tier_{$POS}_AU">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/ausdauer" />
			</value>
		</field>
		<field name="Tier_{$POS}_MR">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/magieresistenz" />
			</value>
		</field>
		<field name="Tier_{$POS}_LO">
			<value>
				<xsl:value-of select="details/tier/eigenschaften/loyalitaet" />
			</value>
		</field>
		<!--
			<field name="Tier_{$POS}_TK">
			<value>
			<xsl:value-of select="" />
			</value>
			</field>
			<field name="Tier_{$POS}_ZK">
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
		<!-- Rechnung Parade/Ausweichen -->
		<field name="Rechnung_PA_basis">
			<value>
				<xsl:value-of select="/daten/eigenschaften/parade/akt" />
			</value>
		</field>
		<field name="Rechnung_PA_BE">
			<value>
				<xsl:value-of select="ruestungzonen/behinderung" />
			</value>
		</field>
		<field name="Rechnung_PA_summe">
			<value>
				<xsl:value-of select="ausweichen" />
			</value>
		</field>
		<xsl:if test="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen I']">
			<field name="Rechnung_PA_ausweichen_1">
				<value>3</value>
			</field>
		</xsl:if>
		<xsl:if test="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen II']">
			<field name="Rechnung_PA_ausweichen_2">
				<value>3</value>
			</field>
		</xsl:if>
		<xsl:if test="/daten/sonderfertigkeiten/sonderfertigkeit[bezeichner = 'Ausweichen III']">
			<field name="Rechnung_PA_ausweichen_3">
				<value>3</value>
			</field>
		</xsl:if>
		<!-- Rechnung INI -->
		<field name="Rechnung_INI">
			<value>
				<xsl:value-of select="/daten/eigenschaften/initiative/akt" />
			</value>
		</field>
		<field name="Rechnung_INI_BE">
			<value>
				<xsl:value-of select="ruestungzonen/behinderung" />
			</value>
		</field>
		<field name="Rechnung_INI_summe">
			<value>
				<xsl:value-of select="ini" />
				<xsl:text> (inkl. SF Mod.)</xsl:text>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/raufen">
		<xsl:apply-templates />
		<field name="Raufen_AT_Kampf">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Raufen_PA_Kampf">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Raufen_TP_Kampf">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ringen">
		<field name="Ringen_AT_Kampf">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="Ringen_PA_Kampf">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Ringen_TP_Kampf">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/kampfsets/kampfset/ruestungzonen">
		<field name="RS_KO">
			<value>
				<xsl:value-of select="kopf" />
			</value>
		</field>
		<field name="RS_BR">
			<value>
				<xsl:value-of select="brust" />
			</value>
		</field>
		<field name="RS_RUE">
			<value>
				<xsl:value-of select="ruecken" />
			</value>
		</field>
		<field name="RS_BA">
			<value>
				<xsl:value-of select="bauch" />
			</value>
		</field>
		<field name="RS_LA">
			<value>
				<xsl:value-of select="linkerarm" />
			</value>
		</field>
		<field name="RS_RA">
			<value>
				<xsl:value-of select="rechterarm" />
			</value>
		</field>
		<field name="RS_LB">
			<value>
				<xsl:value-of select="linkesbein" />
			</value>
		</field>
		<field name="RS_RB">
			<value>
				<xsl:value-of select="rechtesbein" />
			</value>
		</field>
		<field name="RS_BE">
			<value>
				<xsl:value-of select="behinderung" />
			</value>
		</field>
		<field name="Ruestung_Summe_RS">
			<value>
				<xsl:value-of select="gesamtzonenschutz" />
				<xsl:text> -- </xsl:text>
				<xsl:value-of select="kopf" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="brust" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="ruecken" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="bauch" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="linkerarm" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="rechterarm" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="linkesbein" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="rechtesbein" />
				<xsl:text></xsl:text>
			</value>
		</field>
		<field name="Ruestung_Summe_BE">
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
		<field name="NK_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="NK_{$POS}_typ">
			<value>
				<xsl:value-of select="spalte2" />
				<!--
					<xsl:value-of select="talentkurz" />
					<xsl:text>/</xsl:text>
					<xsl:value-of select="be" />
				-->
			</value>
		</field>
		<field name="NK_{$POS}_DK">
			<value>
				<xsl:value-of select="translate(dk, ' ', '')" />
			</value>
		</field>
		<field name="NK_{$POS}_TP">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="NK_{$POS}_TPKK">
			<value>
				<xsl:value-of select="tpkk" />
			</value>
		</field>
		<field name="NK_{$POS}_INI">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="NK_{$POS}_WM">
			<value>
				<xsl:value-of select="wm" />
			</value>
		</field>
		<field name="NK_{$POS}_AT">
			<value>
				<xsl:value-of select="at" />
			</value>
		</field>
		<field name="NK_{$POS}_PA">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="NK_{$POS}_TPeff">
			<value>
				<xsl:value-of select="tpinkl" />
			</value>
		</field>
		<field name="NK_{$POS}_BF_1">
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
		<field name="FK_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="FK_{$POS}_typ">
			<value>
				<xsl:value-of select="spalte2" />
				<!-- <xsl:value-of select="substring-after(spalte2, '/')" /> -->
			</value>
		</field>
		<field name="FK_{$POS}_Entfernung">
			<value>
				<xsl:value-of select="translate(reichweite,' ', '')" />
			</value>
		</field>
		<field name="FK_{$POS}_TP">
			<value>
				<xsl:value-of select="tp" />
			</value>
		</field>
		<field name="FK_{$POS}_TPEntfernung">
			<value>
				<xsl:value-of select="translate(tpmod,' ', '')" />
			</value>
		</field>
		<field name="FK_{$POS}_FK">
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
		<field name="Schild_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Schild_{$POS}_typ">
			<value>
				<xsl:value-of select="typ" />
			</value>
		</field>
		<field name="Schild_{$POS}_INI">
			<value>
				<xsl:value-of select="ini" />
			</value>
		</field>
		<field name="Schild_{$POS}_WM">
			<value>
				<xsl:value-of select="mod" />
			</value>
		</field>
		<field name="Schild_{$POS}_PA">
			<value>
				<xsl:value-of select="pa" />
			</value>
		</field>
		<field name="Schild_{$POS}_BF_1">
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
		<field name="Ruestung_{$POS}">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Ruestung_{$POS}_RS">
			<value>
				<xsl:value-of select="rs" />
				<xsl:text> -- </xsl:text>
				<xsl:value-of select="kopf" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="brust" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="ruecken" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="bauch" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="linkerarm" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="rechterarm" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="linkesbein" />
				<xsl:text> / </xsl:text>
				<xsl:value-of select="rechtesbein" />
				<xsl:text></xsl:text>
			</value>
		</field>
		<field name="Ruestung_{$POS}_BE">
			<value>
				<xsl:value-of select="be" />
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/zauber">
		<!-- Eigenschaften auf dem Zauberdokument -->
		<field name="MU_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/mut/akt" />
			</value>
		</field>
		<field name="MU_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/mut/akt" />
			</value>
		</field>
		<field name="KL_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/klugheit/akt" />
			</value>
		</field>
		<field name="KL_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/klugheit/akt" />
			</value>
		</field>
		<field name="IN_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/intuition/akt" />
			</value>
		</field>
		<field name="IN_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/intuition/akt" />
			</value>
		</field>
		<field name="CH_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/charisma/akt" />
			</value>
		</field>
		<field name="CH_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/charisma/akt" />
			</value>
		</field>
		<field name="FF_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/fingerfertigkeit/akt" />
			</value>
		</field>
		<field name="FF_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/fingerfertigkeit/akt" />
			</value>
		</field>
		<field name="GE_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/gewandtheit/akt" />
			</value>
		</field>
		<field name="GE_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/gewandtheit/akt" />
			</value>
		</field>
		<field name="KO_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/konstitution/akt" />
			</value>
		</field>
		<field name="KO_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/konstitution/akt" />
			</value>
		</field>
		<field name="KK_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/koerperkraft/akt" />
			</value>
		</field>
		<field name="KK_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/koerperkraft/akt" />
			</value>
		</field>
		<field name="MR_z1">
			<value>
				<xsl:value-of select="/daten/eigenschaften/magieresistenz/akt" />
			</value>
		</field>
		<field name="MR_z2">
			<value>
				<xsl:value-of select="/daten/eigenschaften/magieresistenz/akt" />
			</value>
		</field>
		<xsl:apply-templates select="zauber" />
	</xsl:template>
	<xsl:template match="/daten/zauber/zauber">
		<xsl:variable name="POS" select="position()" />
		<field name="{$POS}_name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<!-- <field name="{$POS}_se"> <value> <xsl:value-of select="" /> </value> </field> -->
		<field name="{$POS}_probe">
			<value>
				<xsl:value-of select="probe" />
				<xsl:value-of select="mr" />
			</value>
		</field>
		<xsl:if test="$includeZFW = 'true'">
			<field name="{$POS}_zfw_1">
				<value>
					<xsl:value-of select="wert" />
				</value>
			</field>
		</xsl:if>
		<field name="{$POS}_zd">
			<value>
				<xsl:value-of select="zauberdauer" />
			</value>
		</field>
		<field name="{$POS}_k">
			<value>
				<xsl:value-of select="kosten" />
			</value>
		</field>
		<field name="{$POS}_rw">
			<value>
				<xsl:value-of select="reichweite" />
			</value>
		</field>
		<field name="{$POS}_wd">
			<value>
				<xsl:value-of select="wirkungsdauer" />
			</value>
		</field>
		<field name="{$POS}_notiz">
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
		<field name="{$POS}_komp">
			<value>
				<xsl:value-of select="komplexität" />
			</value>
		</field>
		<field name="{$POS}_rep">
			<value>
				<xsl:value-of select="repräsentation" />
			</value>
		</field>
		<field name="{$POS}_mm">
			<value>
				<xsl:value-of select="merkmale" />
			</value>
		</field>
		<field name="{$POS}_haus">
			<value>
				<xsl:if test="hauszauber = 'true'">
					<xsl:value-of select="$checkbox" />
				</xsl:if>
			</value>
		</field>
		<field name="{$POS}_lern">
			<value>
				<xsl:value-of select="lernkomplexität" />
			</value>
		</field>
	</xsl:template>
	<xsl:template name="substring">
		<xsl:param name="text" />
		<xsl:param name="total" />
		<xsl:param name="name" select="''" />
		<xsl:param name="index" select="1" />
		<xsl:param name="indexmax" select="1000" />
		<xsl:call-template name="row">
			<xsl:with-param name="name" select="$name" />
			<xsl:with-param name="text" select="$text" />
			<xsl:with-param name="total" select="$total" />
			<xsl:with-param name="index" select="$index" />
			<xsl:with-param name="indexmax" select="$indexmax" />
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="row">
		<xsl:param name="text" />
		<xsl:param name="name" />
		<xsl:param name="storage" select="''" />
		<xsl:param name="count" select="0" />
		<xsl:param name="total" select="70" />
		<xsl:param name="index" select="1" />
		<xsl:param name="indexmax" select="1000" />
		<xsl:choose>
			<xsl:when test="$count &lt; $total and $text != ''">
				<!--
					<xsl:message>
					when
					name: <xsl:value-of select="$name" />
					index: <xsl:value-of select="$index" />
					count: <xsl:value-of select="$count" />
					storage: <xsl:value-of select="$storage" />
					</xsl:message>
				-->
				<xsl:variable name="word">
					<xsl:choose>
						<xsl:when test="contains($text, ' ')">
							<xsl:value-of select="substring-before($text, ' ')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$text" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:call-template name="row">
					<xsl:with-param name="text" select="substring-after($text, ' ')" />
					<xsl:with-param name="name" select="$name" />
					<xsl:with-param name="storage" select="concat($storage, ' ', $word)" />
					<xsl:with-param name="count" select="$count + string-length($word)" />
					<xsl:with-param name="total" select="$total" />
					<xsl:with-param name="index" select="$index" />
					<xsl:with-param name="indexmax" select="$indexmax" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--
					<xsl:message>
					otherwise
					name: <xsl:value-of select="$name" />
					index: <xsl:value-of select="$index" />
					count: <xsl:value-of select="$count" />
					storage: <xsl:value-of select="$storage" />
					</xsl:message>
				-->
				<field name="{$name}{$index}">
					<value>
						<xsl:if test="$index &lt; $indexmax">
							<xsl:value-of select="normalize-space($storage)" />
						</xsl:if>
						<xsl:if test="$index = $indexmax">
							<xsl:value-of select="normalize-space($storage)" />
							<xsl:text> </xsl:text>
							<xsl:value-of select="normalize-space($text)" />
						</xsl:if>
					</value>
				</field>
				<xsl:if test="$index &lt; $indexmax">
					<xsl:if test="$text != ''">
						<!--
							<xsl:message>
							call substring
							name: <xsl:value-of select="$name" />
							index: <xsl:value-of select="$index" />
							count: <xsl:value-of select="$count" />
							storage: <xsl:value-of select="$storage" />
							</xsl:message>
						-->
						<xsl:call-template name="substring">
							<xsl:with-param name="text" select="$text" />
							<xsl:with-param name="name" select="$name" />
							<xsl:with-param name="total" select="$total" />
							<xsl:with-param name="index" select="$index + 1" />
							<xsl:with-param name="indexmax" select="$indexmax" />
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>