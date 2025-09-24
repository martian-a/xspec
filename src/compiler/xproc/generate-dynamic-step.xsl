<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:p="http://www.w3.org/ns/xproc"   
	xmlns:x="http://www.jenitennison.com/xproc/xspec"
	xmlns:xpc="http://xspec.io/ns/xproc"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"	
	exclude-result-prefixes="m"
	expand-text="true"
	version="3.0">

	<m:document>
		<m:title>Generate Dynamic Step</m:title>
		<m:desc>
			<m:p>Generate a wrapper XProc step that imports the step under test and runs it with the inputs and options specified via a scenario context.</m:p>
		</m:desc>
		<m:note>Reminder: the XProc step is only being written at this point.</m:note>
		<m:contributors>
			<m:original-author>Sheila Thomson</m:original-author>	
		</m:contributors>	
		<m:history created="2025-06-18" />
	</m:document>	
	
	
	<m:component>
		<m:desc>An absolute path to the XSpec file.</m:desc>
		<m:note>This stylesheet is applied to a scenario, so doesn't have access to the root of the XSpec file.</m:note>
	</m:component>
	<xsl:param name="xspec-uri" required="true" />
	
	<m:component>
		<m:desc>The XSpec file.</m:desc>
	</m:component>
	<xsl:variable name="xspec-doc" select="document($xspec-uri)" as="document-node()"  />
	
	<m:component>
		<m:desc>An absolute path to the XProc step that is to be tested.</m:desc>
	</m:component>
	<xsl:variable name="step-under-test-uri" select="resolve-uri($xspec-doc/x:description/@step, $xspec-uri)" as="xs:anyURI" />
	
	<m:component>
		<m:desc>The XProc step that is to be tested.</m:desc>
	</m:component>
	<xsl:variable name="step-under-test-doc" select="document($step-under-test-uri)" />
	
	<m:comment>Get basic metadata about the XProc step.</m:comment>
	<xsl:variable name="step-under-test-type" select="$step-under-test-doc/*/@type" as="xs:string" />
	<xsl:variable name="step-under-test-name" select="local-name-from-QName(xs:QName($step-under-test-type))" as="xs:NCName" />
	<xsl:variable name="step-under-test-namespace-uri" select="namespace-uri-from-QName(resolve-QName($step-under-test-type, $step-under-test-doc/*))" as="xs:anyURI" />
	<xsl:variable name="step-under-test-input-ports" select="$step-under-test-doc/*/p:input" as="element()*" />
	<xsl:variable name="step-under-test-output-ports" select="$step-under-test-doc/*/p:output" as="element()*" />
	<xsl:variable name="step-under-test-options" select="$step-under-test-doc/*/p:option" as="element()*" />
	
	
	
	<m:component>The initial template for this transformation.</m:component>
	<xsl:template match="/x:scenario">
		<xsl:variable name="scenario-id" select="@id" as="xs:ID" />
		<xsl:variable name="input-ports-in-context" select="x:context/x:port" as="element()*" />
		<xsl:variable name="options-in-context" select="x:context/x:option" as="element()*" />
		
		
		<!-- Create the dynamic XProc step.</m:desc>
			 Note: This step won't have an input port. -->
		<p:declare-step type="xpc:dynamic-step" name="dynamic-step" version="3.1">	
			
			<!-- Create the instruction to import the step under test. -->
			<p:import href="{$step-under-test-uri}" />
			
			
			<!-- Define a single output port.				
				 It's expected to return all outputs from the step under test.
				 The output from each port will be wrapped in x:port with the name of that port in an attribute.
				 The sequence of x:port elements will be wrapped in x:results -->			
			<p:output port="result" sequence="true" />
			

			<!-- Create the instruction to run the step under test.-->
			<xsl:element name="{$step-under-test-name}" namespace="{$step-under-test-namespace-uri}">
				<xsl:attribute name="name" select="'step-under-test'" />
				
				<!-- Create instructions to define all the input ports via which context needs to be provided to the step under test.</m:desc>
					 A p:with-input will only be created for a port that's explicitly included in the scenario's context. -->				
				<xsl:apply-templates select="$input-ports-in-context" />	
				
				<!-- Create instructions to define all the options via which context needs to be provided to the step under test.
					 A p:with-option will only be created for an option that's explicitly included in the scenario's context. -->
				<xsl:apply-templates select="$options-in-context" />	
				
			</xsl:element>

			<!-- Create an instruction to stop the outputs from automatically flowing in to the next step. -->
			<p:sink />

			<!-- Create the logic to collect the output from the ports referenced by expectations. -->
			<p:group name="port-outputs">
				
				
				<!-- Define an output port for this <m:code>p:group</m:code> that will collate all the <m:code>x:port</m:code> fragments into a sequence. -->
				<p:output port="result" sequence="true">
					
					<!-- Group all the expectations in this scenario by the port that they are testing and, for each distinct port name, create an instruction to get the <m:code>x:port</m:code> fragment for that specific port. -->
					<xsl:for-each-group select="x:expect[@port]" group-by="@port">
						<p:pipe step="{$scenario-id}-{current-grouping-key()}-port" port="result" />
					</xsl:for-each-group>
				</p:output>
				
				
				<!-- Group all the expectations in this scenario by the port that they are testing and, for each distinct port name:
					   - wrap the output from that port in x:port
					   - add @name to x:port
					   - stop the result from automatically flowing into the next step -->					
				<xsl:for-each-group select="x:expect[@port]" group-by="@port">
													
					<p:wrap-sequence wrapper="x:port">
						<p:with-input port="source" pipe="{current-grouping-key()}@step-under-test" />
					</p:wrap-sequence>
					
					<p:add-attribute name="{$scenario-id}-{current-grouping-key()}-port" attribute-name="name" attribute-value="{current-grouping-key()}" />
					
					<p:sink />
					
				</xsl:for-each-group>
				
			</p:group>
			
			<!-- Wrap the sequence of <m:code>x:port</m:code> fragments in <m:code>x:results</m:code>. -->
			<p:wrap-sequence wrapper="x:results"  />		

		</p:declare-step>
				
	</xsl:template>	
	
	
	<m:comment>Create an instruction to supply context to the step under test via an input port.</m:comment>
	<xsl:template match="x:port">
		<p:with-input port="{@name}">
			<xsl:apply-templates select="@*[not(local-name() = ('name'))]" />
			<xsl:if test="not(@href) and node()">
				<p:inline>
					<xsl:apply-templates />
				</p:inline>
			</xsl:if>
		</p:with-input>	
	</xsl:template>
	
	
	<m:comment>Create an instruction to supply context to the step under test via an option.</m:comment>
	<xsl:template match="x:option">
		<p:with-option name="{@name}">
			<xsl:apply-templates select="@*[not(local-name() = ('name'))]" />
		</p:with-option>
	</xsl:template>
	
	
	<m:comment>Identity transformation.</m:comment>
	<xsl:template match="node() | attribute()">
		<xsl:copy>
			<xsl:apply-templates select="attribute(), node()" />
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>