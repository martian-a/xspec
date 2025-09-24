<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:p="http://www.w3.org/ns/xproc"   
	xmlns:x="http://www.jenitennison.com/xproc/xspec"
	xmlns:xpc="http://xspec.io/ns/xproc"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="m"
	expand-text="true"
	version="3.0">

	<m:document>
		<m:title>Compile XProc Tests</m:title>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-17" />
	</m:document>	
	
	<m:comment>Re-use existing resources as much as possible.</m:comment>
	<xsl:include href="../../common/uri-utils.xsl" />
	
	<m:component ref="step-uri">A path to the XProc step under test.</m:component>
	<xsl:variable name="step-uri" select="resolve-uri(/x:description/@step, document-uri(/))" as="xs:anyURI" />
	
	<m:component ref="xspec-uri">A path to the XSpec file being compiled.</m:component>
	<xsl:variable name="xspec-uri" select="base-uri(/)" as="xs:anyURI" />
	
	<m:component ref="test-runner-name">A non-colonised name that is used in both the name and the type of the XProc step that will be created by this XSLT stylesheet.</m:component>
	<xsl:variable name="test-runner-name" select="xs:NCName('test-xproc')" as="xs:NCName" />
	
	<m:component ref="step-under-test">The document-node() of the XProc step that is to be tested.</m:component>
	<xsl:variable name="step-under-test" select="document(resolve-uri($step-uri, $xspec-uri))" as="document-node()" />
	
	
	<xsl:template match="/x:description">
		<p:declare-step version="3.1" type="{xs:QName(string-join(('xpc', $test-runner-name), ':'))}" name="{$test-runner-name}">
			<xsl:apply-templates select="//x:scenario[x:expect]" mode="x:define-output-ports" />
		</p:declare-step>
	</xsl:template>
	
	
	<m:component>
		<m:p>Make sure that a dedicated output port exists for each </m:p>
	</m:component>
	<xsl:template match="x:scenario" mode="x:define-output-ports">
		<xsl:variable name="scenario-id" select="@id" as="xs:ID" />
		
		<xsl:for-each-group select="x:expect" group-by="@port">			
			<p:output port="{string-join(($scenario-id, current-grouping-key()), '-')}">
				<m:comment>
					<m:ul>
						<m:ingress>Copy all the attributes from the port declaration in the step under test, except:</m:ingress>
						<m:li>the <m:code>name</m:code> (because we've just given it a new, scenario-specific name)</m:li>
						<m:li><m:code>primary</m:code> because that might result in multiple primary output ports.</m:li>
					</m:ul>
				</m:comment>
				<xsl:copy-of select="$step-under-test/*/p:output[@port = current-grouping-key()]/@*[not(local-name() = ('primary', 'port'))]" />
			</p:output>
		</xsl:for-each-group>		
	</xsl:template>
	
	
	<!--
	<xsl:template match="x:context">
		<xsl:copy>
			<xsl:apply-templates select="attribute()" />
			<p:run>
				<p:with-input href="{$step-href}" />
				<xsl:apply-templates />
			</p:run>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="x:port">
		<p:run-input port="{@name}"><xsl:choose>
				<xsl:when test="@href"><p:document href="{resolve-uri(@href, document-uri(/))}" /></xsl:when>
				<xsl:otherwise><xsl:apply-templates /></xsl:otherwise>
		</xsl:choose></p:run-input>
	</xsl:template>
	-->
	
	<m:component>Identity transformation</m:component>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>