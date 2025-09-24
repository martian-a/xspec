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
		<m:title>Evaluate XProc Tests</m:title>
		<m:desc>
			<m:p>Check each of the expectations against the actual outputs.</m:p>
		</m:desc>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-20" />
	</m:document>	



	<xsl:template match="x:expect">
		<xsl:variable name="port" select="@port" as="xs:string" />
		<xsl:variable name="port-output" select="parent::x:scenario/x:results/x:port[@name = $port]/node()" as="item()*" />
		<xsl:copy>
			<xsl:apply-templates select="attribute()" />
			<xsl:attribute name="successful" select="deep-equal(node(), $port-output)" />
			<xsl:apply-templates select="node()" />
		</xsl:copy>
	</xsl:template>
	

	<m:component>Identity transformation</m:component>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
	
</xsl:stylesheet>