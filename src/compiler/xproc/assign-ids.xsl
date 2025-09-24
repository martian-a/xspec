<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:x="http://www.jenitennison.com/xproc/xspec"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="m"
	expand-text="true"
	version="3.0">

	<m:document>
		<m:title>Assign IDs</m:title>
		<m:desc>
			<m:p>Generate and insert IDs on every scenario and expect element.</m:p>
		</m:desc>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-18" />
	</m:document>	
	
	
	<xsl:accumulator name="scenario-number" as="xs:integer" initial-value="0">
		<xsl:accumulator-rule match="x:scenario" select="$value + 1"/>
	</xsl:accumulator>
	
	<xsl:accumulator name="expect-number" as="xs:integer" initial-value="0">
		<xsl:accumulator-rule match="x:expect" select="$value + 1"/>
	</xsl:accumulator>
	
	
	<xsl:mode use-accumulators="scenario-number expect-number" />
	
	<m:component>Generate and assign a unique ID to each scenario and expect element.</m:component>
	<xsl:template match="x:scenario | x:expect">
		<xsl:copy>
			<xsl:apply-templates select="attribute()" />
			<xsl:attribute name="id">{local-name()}{if (local-name() = 'scenario') then accumulator-before('scenario-number') else accumulator-before('expect-number')}</xsl:attribute>			
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	
	<m:component>Identity transformation</m:component>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>