<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:p="http://www.w3.org/ns/xproc"      
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:x="http://www.jenitennison.com/xslt/xspec"   
	name="run"
	type="x:run"
	version="3.1">

	<p:import href="compile-xslt.xpl" />
	<p:import href="evaluate-xslt.xpl" />
	<p:import href="report-html.xpl" />
	
	<p:input port="source" primary="true" />
	
	<p:output port="report-html" primary="true" pipe="result@report-html" sequence="false" />
	<p:output port="result-xml" pipe="result@evaluate-xslt" sequence="false" />
	
	<x:compile-xslt name="compile-xslt" />
	<x:evaluate-xslt name="evaluate-xslt" />
	<x:report-html name="report-html" />	
	
</p:declare-step>