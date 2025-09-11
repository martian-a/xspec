<?xml version="1.0" encoding="UTF-8"?>
<!-- ===================================================================== -->
<!--  File:       xslt-harness.xproc                                 -->
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
           		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"        
	            pkg:import-uri="http://www.jenitennison.com/xslt/xspec/saxon/harness/xslt.xproc"
    	        name="xslt-harness"
        	    type="t:xslt-harness"
            	exclude-inline-prefixes="pkg t map xs xsl c p doc"
	            version="3.1">

	<p:documentation>
	 	<doc:p>This pipeline executes an XSpec test suite for XSLT.</doc:p>
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
	<p:input port="source" primary="true" sequence="false"/>
	
	<p:documentation>
		<p:doc>A formatted report of the results.</p:doc>
	</p:documentation>
	<p:output port="result" sequence="false" primary="true" />

	<p:documentation>
		<p:doc>A formatted report of the results.</p:doc>
	</p:documentation>
	<p:output port="xml-report" sequence="false" pipe="@run" />
	
	<p:documentation>
		<p:doc>The compiled tests.</p:doc>
	</p:documentation>
	<p:output port="compiled-xspec" sequence="false" pipe="@compile" />
	
		
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
		<doc:p>Use this option to supply parameters to the XSpec XSLT compiler, 
			(e.g. utils-library-at to suppress the at location hint to use to import 
			the XSpec utils library modules in the generated query)</doc:p>
	</p:documentation>
	<p:option name="compiler-options" as="map(xs:QName, item()*)?" static="true" />
		
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
	<p:option name="formatter-options" as="map(xs:QName, item()*)?" static="true" />
	
	<p:documentation>
		<doc:p>Serialization options for the formatted report (optional).</doc:p>
	</p:documentation>
	<p:option name="serialization-options" select="map{ 
			xs:QName('indent') : true(), 
			xs:QName('method') : 'xhtml', 
			xs:QName('encoding') : 'UTF-8', 
			xs:QName('include-content-type') : true(), 
			xs:QName('omit-xml-declaration') : false()
		}" as="map(xs:QName, item()*)?" static="true" />
	
	<p:documentation>
		<doc:p>If you want to store a copy of the formatted report, for example to aid with 
			debugging, then you can use this option to specify where to save it (optional).  
			If this option is empty then this step will NOT save a copy of the formatted report
			to the file-system.</doc:p>
		<doc:p>Assuming nothing goes wrong, the formatted report will always be output via the result port.</doc:p>
	</p:documentation>
	<p:option name="log-report" as="xs:anyURI?" static="true" />
	
	
	
	<p:documentation>
		<doc:p>Compile the XSpec test file into XSLT.</doc:p>
	</p:documentation>
	<t:compile-xslt name="compile" />
	

	<p:documentation>
		<doc:p>Transform the compiled XSLT to evaluate the tests and generate an XML report of the results.</doc:p>		
	</p:documentation>
	<p:xslt name="run" template-name="t:main">
		<p:with-input port="source">
			<p:empty/>
		</p:with-input>
		<p:with-input port="stylesheet" pipe="@compile"/>
	</p:xslt>
	
	
	<p:documentation>
		<p:doc>Store a copy of the XML test results if a location to store it at has been supplied.</p:doc>
	</p:documentation>
	<p:store use-when="normalize-space($log-xml-report) != ''" message="[debug] Saving XML report to {$log-xml-report}">
		<p:with-option name="href" select="$log-xml-report" />         
	</p:store>
	
	
	<p:documentation>
		<doc:p>Generate a formatted report from the XML test results.</doc:p>
	</p:documentation>
	<t:format-report />
	
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
