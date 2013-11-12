<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://ns.adobe.com/xfdf/">
	<xsl:decimal-format name="de" decimal-separator="," grouping-separator="." />
	<xsl:output method="xml" encoding="UTF-8" indent="yes" />
	<!-- Optionen Ja: "true" Nein: "false" -->

	<!-- 
		includeKommentare:
		'true': Kommentare werden in Klammer angegeben.
		'false': keine Kommentare eintragen 
	-->
	<xsl:param name="includeKommentare" select="'true'" />
	
	<xsl:param name="selectedName" select="''" />
	
	<!-- Templates -->
	<xsl:template match="@*|text()" />
	<xsl:template match="/">
		<xfdf xml:space="preserve">
			<f href="Document.pdf" />
			<ids original="7A0631678ED475F0898815F0A818CFA1" modified="BEF7724317B311718E8675B677EF9B4E" />
			<fields>
				<xsl:apply-templates />
			</fields>
		</xfdf>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende">
		<xsl:choose>
			<xsl:when test="string-length($selectedName) > 0">
				<xsl:apply-templates select="gegenstand[name=$selectedName]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="gegenstand[arten = 'Tier'][1]"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand">
		<xsl:variable name="TPOS" select="position()" />
		<field name="Tier_{$TPOS}_name">
			<value>
				<xsl:value-of select="name" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_gewicht">
			<value>
				<!-- 
				<xsl:value-of select="format-number(gewicht, '#.##0,0', 'de')" />
				<xsl:text> Unzen</xsl:text>
				<xsl:text> (</xsl:text>
				 -->
				<xsl:value-of select="format-number(gewicht div 40, '#.##0,0', 'de')" />
				<xsl:text> Stein</xsl:text>
				<!-- 
				<xsl:text>)</xsl:text>
				 -->
			</value>
		</field>
		<xsl:apply-templates>
			<xsl:with-param name="TPOS" select="$TPOS" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details">
		<xsl:param name="TPOS" />
		<xsl:apply-templates>
			<xsl:with-param name="TPOS" select="$TPOS" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier">
		<xsl:param name="TPOS" />
		<field name="Tier_{$TPOS}_familie">
			<value>
				<xsl:value-of select="familie" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_gattung">
			<value>
				<xsl:value-of select="gattung" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_groesse">
			<value>
				<xsl:value-of select="format-number(groesse div 2, '#.##0', 'de')" />
				<xsl:text> Finger</xsl:text>
				<xsl:text> (</xsl:text>
				<xsl:value-of select="format-number(groesse, '#.##0', 'de')" />
				<xsl:text> cm)</xsl:text>
			</value>
		</field>
		<field name="Tier_{$TPOS}_INI">
			<value>
				<xsl:value-of select="ini/@mul" />
				<xsl:text>W</xsl:text>
				<xsl:if test="ini/@w != '6'">
					<xsl:value-of select="ini/@w" />
				</xsl:if>
				<xsl:text>+</xsl:text>
				<xsl:value-of select="ini/@sum" />
			</value>
		</field>
		<xsl:apply-templates>
			<xsl:with-param name="TPOS" select="$TPOS" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/eigenschaften">
		<xsl:param name="TPOS" />
		<field name="Tier_{$TPOS}_MU">
			<value>
				<xsl:value-of select="mut" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_KL">
			<value>
				<xsl:value-of select="klugheit" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_IN">
			<value>
				<xsl:value-of select="intuition" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_CH">
			<value>
				<xsl:value-of select="charisma" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_FF">
			<value>
				<xsl:value-of select="fingerfertigkeit" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_GE">
			<value>
				<xsl:value-of select="gewandtheit" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_KO">
			<value>
				<xsl:value-of select="konstitution" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_KK">
			<value>
				<xsl:value-of select="koerperkraft" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_MR">
			<value>
				<xsl:value-of select="magieresistenz" />
				<xsl:if test="string-length(magieresistenz2) > 0 and magieresistenz2 != 'null'">
					<xsl:text> / </xsl:text>
					<xsl:value-of select="magieresistenz2" />
				</xsl:if>
			</value>
		</field>
		<field name="Tier_{$TPOS}_GS">
			<value>
				<xsl:value-of select="format-number(geschwindigkeit, '#.##0,0', 'de')" />
				<xsl:if test="string-length(geschwindigkeit2) > 0 and geschwindigkeit2 != 'null'">
					<xsl:text> / </xsl:text>
					<xsl:value-of select="format-number(geschwindigkeit2, '#.##0,0', 'de')" />
				</xsl:if>
				<xsl:if test="string-length(geschwindigkeit3) > 0 and geschwindigkeit3 != 'null'">
					<xsl:text> / </xsl:text>
					<xsl:value-of select="format-number(geschwindigkeit3, '#.##0,0', 'de')" />
				</xsl:if>
			</value>
		</field>
		<field name="Tier_{$TPOS}_LEP">
			<value>
				<xsl:value-of select="lebensenergie" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_LEP_12">
			<value>
				<xsl:value-of select="floor(lebensenergie div 2)" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_LEP_13">
			<value>
				<xsl:value-of select="floor(lebensenergie div 3)" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_LEP_14">
			<value>
				<xsl:value-of select="floor(lebensenergie div 4)" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_AUP">
			<value>
				<xsl:value-of select="ausdauer" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_AUP_12">
			<value>
				<xsl:value-of select="floor(ausdauer div 2)" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_AUP_13">
			<value>
				<xsl:value-of select="floor(ausdauer div 3)" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_AUP_14">
			<value>
				<xsl:value-of select="floor(ausdauer div 4)" />
			</value>
		</field>
		
		<field name="Tier_{$TPOS}_ASP">
			<value>
				<xsl:if test="string-length(astralenergie) > 0 and astralenergie != 'null'">
					<xsl:value-of select="astralenergie" />
				</xsl:if>
			</value>
		</field>
		<field name="Tier_{$TPOS}_LO">
			<value>
				<xsl:value-of select="loyalitaet" />
			</value>
		</field>
		<!-- INI wird von der Heldensoftware Berechnet -->
		<!-- 
		<field name="Tier_{$TPOS}_INI">
			<value>
				<xsl:value-of select="intuition" />
			</value>
		</field>
		 -->
		<field name="Tier_{$TPOS}_RS">
			<value>
				<xsl:value-of select="ruestungsschutz" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_GW">
			<value>
				<xsl:value-of select="gewandtheit" />
			</value>
		</field>
		<xsl:apply-templates>
			<xsl:with-param name="TPOS" select="$TPOS" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/sonderfertigkeiten">
		<xsl:param name="TPOS" />
		<xsl:variable name="Sonderfertigkeiten">
			<xsl:apply-templates select="sonderfertigkeit" />
		</xsl:variable>
		<xsl:variable name="lineSize" select="105" />
		<field name="Tier_{$TPOS}_sonderfertigkeit_2">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 0, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_sonderfertigkeit_3">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 1, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_sonderfertigkeit_4">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 2, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_sonderfertigkeit_5">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 3, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_sonderfertigkeit_6">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 4, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_sonderfertigkeit_7">
			<value>
				<xsl:value-of select="substring($Sonderfertigkeiten, $lineSize * 5)"></xsl:value-of>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/sonderfertigkeiten/sonderfertigkeit">
		<xsl:value-of select="bezeichner" />
		<xsl:if test="count(auswahlen/auswahl) > 0">
			<xsl:text> </xsl:text>
			<xsl:text>(</xsl:text>				
			<xsl:apply-templates select="auswahlen"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
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
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/vorteile">
		<xsl:param name="TPOS" />
		<xsl:variable name="Vorteile">
			<xsl:apply-templates select="vorteil">
				<xsl:with-param name="TPOS" select="$TPOS" />
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="lineSize" select="105" />
		<field name="Tier_{$TPOS}_vornachteile_2">
			<value>
				<xsl:value-of select="substring($Vorteile, $lineSize * 0, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_vornachteile_3">
			<value>
				<xsl:value-of select="substring($Vorteile, $lineSize * 1, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_vornachteile_4">
			<value>
				<xsl:value-of select="substring($Vorteile, $lineSize * 2, $lineSize)"></xsl:value-of>
			</value>
		</field>
		<field name="Tier_{$TPOS}_vornachteile_5">
			<value>
				<xsl:value-of select="substring($Vorteile, $lineSize * 3)"></xsl:value-of>
			</value>
		</field>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/vorteile/vorteil">
		<xsl:value-of select="normalize-space(bezeichner)" />
		<xsl:if test="string-length(wert) > 0">
			<xsl:text>: </xsl:text>
			<xsl:value-of select="wert" />
		</xsl:if>
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
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/angriffe">
		<xsl:param name="TPOS" />
		<xsl:apply-templates select="angriff">
			<xsl:with-param name="TPOS" select="$TPOS" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/daten/gegenstaende/gegenstand/details/tier/angriffe/angriff">
		<xsl:param name="TPOS" />
		<xsl:variable name="POS" select="position()" />
		<field name="Tier_{$TPOS}_angriff_{$POS}_name">
			<value>
				<xsl:value-of select="@name" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_angriff_{$POS}_dk">
			<value>
				<xsl:value-of select="@dk" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_angriff_{$POS}_at">
			<value>
				<xsl:value-of select="@at	" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_angriff_{$POS}_pa">
			<value>
				<xsl:value-of select="@pa" />
			</value>
		</field>
		<field name="Tier_{$TPOS}_angriff_{$POS}_tp">
			<value>
				<xsl:value-of select="@tp" />
			</value>
		</field>
	</xsl:template>
</xsl:stylesheet>