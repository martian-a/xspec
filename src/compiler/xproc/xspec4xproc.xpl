<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:m="http://xylarium.org/ns/xml/documentation"
	xmlns:p="http://www.w3.org/ns/xproc"      
	xmlns:xpc="http://xspec.io/ns/xproc"
	xmlns:x="http://www.jenitennison.com/xproc/xspec"
	type="xpc:xspec4xproc"
	name="xspec4xproc"
	expand-text="true"	
	version="3.1">

	<p:documentation>
		<m:document>
			<m:title>Compile XProc Tests</m:title>
			<m:contributors>
				<m:original-author>Sheila Thomson</m:original-author>	
			</m:contributors>	
			<m:history created="2025-06-18" />
		</m:document>
	</p:documentation>
	
	
	<p:documentation>
		<m:component>
			<m:desc>Import <m:code>xpc:report-html</m:code> from the XProc 3.1 harness for generating an HTML report.</m:desc>
			<m:note>It's called towards the end of this step.</m:note>
		</m:component>
	</p:documentation>
	<p:import href="../../harnesses/xproc-3.1/report-html.xpl" />


	<p:documentation>
		<m:component>An XProc for XSpec file.</m:component>
	</p:documentation>
	<p:input port="source" />
	
	<p:documentation>
		<m:component>The HTML report.</m:component>
	</p:documentation>
	<p:output port="result" primary="true" sequence="false" />
	
	<p:documentation>
		<m:comonent>The XML report.</m:comonent>
	</p:documentation>
	<p:output port="result-xml" pipe="result@xml-report" sequence="false" />

	<p:documentation>
		<m:component ref="xspec-uri">A path to the XSpec file.</m:component>
	</p:documentation>
	<p:variable name="xspec-uri" select="base-uri(/)" />


	<p:documentation>
		<m:component>
			<m:desc>Remove schema associations.</m:desc>
			<m:note>Past this point, the XSpec file isn't expected to conform to the content model for authoring a XSpec tests for XProc.</m:note>
		</m:component>		
	</p:documentation>
	<p:delete match="processing-instruction('xml-model')" />


	<p:documentation>
		<m:component>Add an @id to every scenario and expect element.</m:component>
	</p:documentation>
	<p:xslt name="assign-ids">
		<p:with-input port="stylesheet" href="assign-ids.xsl" />		
	</p:xslt>			
	

	<p:documentation>
		<m:component>Transform all the scenarios that contain a context, leaving the rest of the document unchanged.</m:component>
	</p:documentation>
	<p:viewport match="//x:scenario[x:context]" name="scenario">	

		<p:documentation>
			<m:component>
				<m:desc>
					<m:ol>
						<m:ingress>Generate an XProc file that will:</m:ingress>
						<m:li>import the step under test</m:li>
						<m:li>call the step under test, passing in all inputs and options specified in the XSpec context</m:li>
						<m:li>retrieve the output from the ports that are referenced by at least one expect</m:li>
						<m:li>wrap each port's output(s) in a <m:code>x:port</m:code> element, with the name of that port in an attribute</m:li>
						<m:li>wrap the sequence of <m:code>x:port</m:code> elements in <m:code>x:results</m:code></m:li>
						<m:li>return <m:code>x:results</m:code> via the output port</m:li>
					</m:ol>
				</m:desc>				
			</m:component>
		</p:documentation>
		<p:xslt name="dynamic-step">
			<p:with-input port="stylesheet" href="generate-dynamic-step.xsl" />
			<p:with-option name="parameters" select="map { 'xspec-uri' : $xspec-uri }" />
		</p:xslt>		
		
		<p:documentation>
			<m:comment>Sink the generated XProc file because <m:code>p:run</m:code> doesn't automatically accept it as the source input.</m:comment>
		</p:documentation>
		<p:sink />
		
		<p:documentation>
			<m:component>Run the generated XProc file</m:component>
		</p:documentation>
		<p:run name="run-step-under-test">
			<p:with-input pipe="result@dynamic-step" />
			<p:output port="result" />
		</p:run>
		
		<p:documentation>
			<m:comment>Sink <m:code>x:result</m:code> because the input for the next step needs to be the whole scenario.</m:comment>
		</p:documentation>
		<p:sink />
		
		<p:documentation>
			<m:component>Insert <m:code>x:result</m:code> into the scenario, after the context.</m:component>
		</p:documentation>
		<p:insert match="/x:scenario/x:context" position="after">
			<p:with-input port="source" pipe="current@scenario" />
			<p:with-input port="insertion" pipe="result@run-step-under-test" />
		</p:insert>
		
	</p:viewport>	
	
	
	<p:documentation>
		<m:component>Evaluate the expectations and assign the outcome to <m:code>@successful</m:code> as true or false.</m:component>
	</p:documentation>
	<p:xslt>
		<p:with-input port="stylesheet" href="evaluate.xsl" />
	</p:xslt>
	
	
	<p:documentation>
		<m:component>Create an XML report.</m:component>
	</p:documentation>
	<p:group name="xml-report">
		
		<p:output port="result" />
		
		
		<p:documentation>
			<m:component>
				<m:desc>Create an XML summary of the test results, per the existing XSpec content model for XML results.</m:desc>
				<m:note>The namespace for the result will still be <m:code>http://www.jenitennison.com/xproc/xspec</m:code></m:note>
			</m:component>
		</p:documentation>
		<p:xslt>
			<p:with-input port="stylesheet" href="report.xsl" />
			<p:with-option name="parameters" select="map { 'xspec-uri' : $xspec-uri }" />
		</p:xslt>
		
		
		<p:documentation>
			<m:component>Change the namespace from <m:code>http://www.jenitennison.com/xproc/xspec</m:code> to <m:code>http://www.jenitennison.com/xslt/xspec</m:code> so that it's possible to use the existing XSLT for generating an HTML result.</m:component>
		</p:documentation>
		<p:namespace-rename from="http://www.jenitennison.com/xproc/xspec" to="http://www.jenitennison.com/xslt/xspec" />
		
	</p:group>
	
	
	<p:documentation>
		<m:component>
			<m:desc>Create an HTML report.</m:desc>
			<m:note>Uses the XSpec for XSLT stylesheet.</m:note>
		</m:component>
	</p:documentation>
	<xpc:report-html name="html-report" />
	
	
</p:declare-step>