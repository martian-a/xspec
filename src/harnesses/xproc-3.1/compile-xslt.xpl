<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:p="http://www.w3.org/ns/xproc"      
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:x="http://www.jenitennison.com/xslt/xspec"   
	name="compile-xslt"
	type="x:compile-xslt"
	version="3.1">
	
	<!-- XSpec test file -->
	<p:input port="source" primary="true" />
	
	
	<p:output port="result" primary="true" />
	
	<p:option name="debug" select="false()" as="xs:boolean" />
	
	<p:xslt>
		<p:with-input port="stylesheet">
			<p:document href="../../compiler/compile-xslt-tests.xsl" />
		</p:with-input>		
	</p:xslt>
	
</p:declare-step>
