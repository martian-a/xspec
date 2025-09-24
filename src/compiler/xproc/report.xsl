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
		<m:title>Create XSpec Report XML</m:title>
		<m:desc>
			<m:p>Generate standard XSpec test result XML.</m:p>
		</m:desc>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-20" />
	</m:document>	


	<xsl:param name="xspec-uri" required="true" />


	<xsl:template match="/x:description">
		<x:report xspec="{$xspec-uri}" stylesheet="{@step}" date="{current-dateTime()}">
			<xsl:apply-templates />
		</x:report>
	</xsl:template>
	
	
	<xsl:template match="x:scenario">
		<xsl:copy>
			<xsl:apply-templates select="@id, @label, node()" />
		</xsl:copy>			
	</xsl:template>
	
	<xsl:template match="@label">
		<x:label><xsl:value-of select="." /></x:label>
	</xsl:template>
	
	<xsl:template match="x:context">
		<input-wrap xmlns=""><xsl:copy-of select="self::element()" /></input-wrap>
	</xsl:template>
	
	<xsl:template match="x:results">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="x:port">
		<content-wrap xmlns=""><xsl:copy-of select="node()" /></content-wrap>
	</xsl:template>
	
	<xsl:template match="x:expect">
		<x:test>
			<xsl:apply-templates select="@id, @successful, @label" />
			<xsl:copy>
				<xsl:apply-templates select="@select" />
				<content-wrap xmlns=""><xsl:copy-of select="node()" /></content-wrap>
			</xsl:copy>
		</x:test>
	</xsl:template>
	

	<m:component>Identity transformation</m:component>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>