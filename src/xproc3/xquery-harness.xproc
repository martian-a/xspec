<?xml version="1.0" encoding="UTF-8"?>
<!-- ===================================================================== -->
<!--  File:       xquery-harness.xproc                               -->
<!--  Author:     Florent Georges                                          -->
<!--  Date:       2011-08-30                                               -->
<!--  Contributors:                                                        -->
<!--  Contributors:                                                        -->
<!--      2025-06-09 George Bina: updated to use XProc 3                   -->
<!--      2025-09-08 Sheila Thomson: converted parameters to options;      -->
<!--                     changed x:log to p:store with use-when;           -->
<!--					 converted commented documentation to markup.      -->
<!--  URI:        http://github.com/xspec/xspec                            -->
<!--  Tags:                                                                -->
<!--    Copyright (c) 2011 Florent Georges (see end of file.)              -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->


<p:declare-step xmlns:c="http://www.w3.org/ns/xproc-step" 
				xmlns:doc="https://www.oxygenxml.com/ns/doc/xsl"
				xmlns:map="http://www.w3.org/2005/xpath-functions/map"
				xmlns:p="http://www.w3.org/ns/xproc" 	
				xmlns:pkg="http://expath.org/ns/pkg" 
				xmlns:t="http://www.jenitennison.com/xslt/xspec" 	
				xmlns:xs="http://www.w3.org/2001/XMLSchema" 	 
				pkg:import-uri="http://www.jenitennison.com/xslt/xspec/saxon/harness/xquery.xproc" 
				name="xquery-harness" 
				type="t:xquery-harness" 
				exclude-inline-prefixes="map xs pkg t c p doc" 
				version="3.1">

	<p:documentation>
		<doc:p>This pipeline executes an XSpec test suite for XQuery.</doc:p>
		<doc:p><doc:b>Primary input:</doc:b> An XSpec test suite document.</doc:p>
		<doc:p><doc:b>Primary output:</doc:b> A formatted HTML XSpec report.</doc:p>
		<doc:p>'xspec-home' option: The directory where you unzipped the XSpec archive on your filesystem.</doc:p>
	</p:documentation>


	<p:documentation>
		<p:doc>Import a library of other XProc steps for XSpec.</p:doc>
	</p:documentation>
	<p:import href="harness-lib.xpl" />


	<p:documentation>
		<p:doc>The XSpec test file to compile and evaluate.</p:doc>
	</p:documentation>
	<p:input port="source" primary="true" sequence="false" />
	
	<p:documentation>
		<p:doc>A formatted report of the results.</p:doc>
	</p:documentation>
	<p:output port="result" sequence="false" primary="true" />

	<p:documentation>
		<p:doc>A formatted report of the results.</p:doc>
	</p:documentation>
	<p:output port="xml-report" sequence="false" />
	
	<p:documentation>
		<p:doc>The compiled tests.</p:doc>
	</p:documentation>
	<p:output port="compiled-xspec" sequence="false" />
	
	
	<p:documentation>
		<doc:p>A path to the root of the XSpec project (optional).</doc:p>
	</p:documentation>
	<p:option name="xspec-home" as="xs:anyURI?" static="true" />	
	
	<p:documentation>
		<doc:p>A path to the XSLT stylesheet to use to compile the test file (optional).</doc:p>
	</p:documentation>
	<p:option name="compiler-uri" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<doc:p>Configuration options to pass through to the compiler stylesheet (optional).</doc:p>
		<doc:p>Use this option to supply parameters to the XSpec XQuery compiler, 
			(e.g. utils-library-at to suppress the at location hint to use to import 
			the XSpec utils library modules in the generated query)</doc:p>
	</p:documentation>
	<p:option name="compiler-options" as="map(*)?" />
		
	<p:documentation>
		<doc:p>If you want to store a copy of the compiler, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).  
			If this option is empty then this step will NOT save a copy of the compiler 
			code to the file-system.</doc:p>
	</p:documentation>
	<p:option name="log-compiler" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<doc:p>If you want to store a copy of the compiled XSpec, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).  
			If this option is empty then this step will NOT save a copy of the compiled 
			XSpec result to the file-system.</doc:p>
		<doc:p>The compiled XSpec will always be output via the compiled-xspec port.</doc:p>
	</p:documentation>
	<p:option name="log-compiled" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<doc:p>If you want to store a copy of the XML report (before the formatted report
			is generated), then you can use this option to specify where to save it (optional).
			If this option is empty then this step will NOT save a copy of the unformatted 
			XSpec results to the file-system.</doc:p>
		<doc:p>The unformatted XML report will always be output via the xml-report port.</doc:p>
	</p:documentation>
	<p:option name="log-xml-report" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<doc:p>A path to the XSLT stylesheet to use to format the test results (optional).</doc:p>
	</p:documentation>
	<p:option name="formatter-uri" as="xs:anyURI?" static="true" />
	
	<p:documentation>
		<doc:p>Configuration options to pass through to the formatter stylesheet (optional).</doc:p>
	</p:documentation>
	<p:option name="formatter-options" as="map(*)?" />
	
	<p:documentation>
		<doc:p>Serialization options for the formatted report (optional).</doc:p>
	</p:documentation>
	<p:option name="serialization-options" as="map(*)?" />
	
	<p:documentation>
		<doc:p>If you want to store a copy of the formatted report, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).  
			If this option is empty then this step will NOT save a copy of the formatted report
			to the file-system.</doc:p>
		<doc:p>Assuming nothing goes wrong, the formatted report will always be output via the result port.</doc:p>
	</p:documentation>
	<p:option name="log-report" as="xs:anyURI?" static="true" />



	<p:documentation>
		<doc:p>Compile the XSpec test file into XQuery.</doc:p>
	</p:documentation>
	<t:compile-xquery name="compile">
		<p:with-option name="compiler-uri" select="$compiler-uri" />
		<p:with-option name="compiler-options" select="$compiler-options" />
		<p:with-option name="xspec-home" select="$xspec-home" />
		<p:with-option name="log-compiler" select="$log-compiler" />
		<p:with-option name="log-compiled" select="$log-compiled" />
	</t:compile-xquery>


	<p:documentation>
		<doc:p>Get the XQuery script as text.</doc:p>
	</p:documentation>
	<t:extract-xquery name="queryText" />


	<p:documentation>
		<doc:p>Run the XQuery to evaluate the tests and generate an XML report of the results.</doc:p>
		<doc:p>By default, the XQuery is run using the Saxon jar bundled with XML Calabash 3.
			You will need to configure the XProc processor if you wish to use another XQuery processor.</doc:p>
	</p:documentation>
	<p:xquery name="run">
		<p:with-input port="source">
			<p:empty />
		</p:with-input>
		<p:with-input port="query" pipe="@queryText" />
	</p:xquery>


	<p:documentation>
		<p:doc>Store a copy of the XML test results if a location to store it at has been supplied.</p:doc>
	</p:documentation>
	<p:store use-when="normalize-space($log-xml-report) != ''" message="[debug] Saving XML report to {$log-xml-report}">
		<p:with-option name="href" select="$log-xml-report" />         
	</p:store>
	

	<p:documentation>
		<doc:p>Generate a formatted report from the XML test results.</doc:p>
	</p:documentation>
	<t:format-report>
		<p:with-option name="formatter-uri" select="$formatter-uri" />
		<p:with-option name="formatter-options" select="$formatter-options" />
		<p:with-option name="serialization-options" select="$serialization-options" />
		<p:with-option name="xspec-home" select="$xspec-home"  />
		<p:with-option name="log-report" select="$log-report" />
	</t:format-report>

</p:declare-step>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS COMMENT.             -->
<!--                                                                       -->
<!-- Copyright (c) 2011 Florent Georges                                    -->
<!--                                                                       -->
<!-- The contents of this file are subject to the MIT License (see the URI -->
<!-- http://www.opensource.org/licenses/mit-license.php for details).      -->
<!--                                                                       -->
<!-- Permission is hereby granted, free of charge, to any person obtaining -->
<!-- a copy of this software and associated documentation files (the       -->
<!-- "Software"), to deal in the Software without restriction, including   -->
<!-- without limitation the rights to use, copy, modify, merge, publish,   -->
<!-- distribute, sublicense, and/or sell copies of the Software, and to    -->
<!-- permit persons to whom the Software is furnished to do so, subject to -->
<!-- the following conditions:                                             -->
<!--                                                                       -->
<!-- The above copyright notice and this permission notice shall be        -->
<!-- included in all copies or substantial portions of the Software.       -->
<!--                                                                       -->
<!-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,       -->
<!-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF    -->
<!-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.-->
<!-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY  -->
<!-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,  -->
<!-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE     -->
<!-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
