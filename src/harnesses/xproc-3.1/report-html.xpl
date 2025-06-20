<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:p="http://www.w3.org/ns/xproc"      
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xpc="http://xspec.io/ns/xproc" 
	name="report-html"
	type="xpc:report-html"
	version="3.1">
	
	<!-- XSpec test results file (XML) -->
	<p:input port="source" primary="true" />
		
	<p:output port="result" primary="true" />
	
	<p:option name="debug" select="false()" as="xs:boolean" />
		
	<p:xslt>
		<p:with-input port="stylesheet">
			<p:document href="../../reporter/format-xspec-report.xsl" />
		</p:with-input>
	</p:xslt>
		
</p:declare-step>