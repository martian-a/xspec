<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="m"
	expand-text="true"
	version="3.0">

	<m:document>
		<m:title>Identity Transform</m:title>
		<m:desc>
			<m:p>Create an exacty copy of the source document.</m:p>
		</m:desc>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-19" />
	</m:document>	


	<m:component>Identity transformation</m:component>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>