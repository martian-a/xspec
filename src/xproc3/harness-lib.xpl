<?xml version="1.0" encoding="UTF-8"?>
<!-- ===================================================================== -->
<!--  File:       harness-lib.xpl                                          -->
<!--  Author:     Florent Georges                                          -->
<!--  Date:       2011-11-08                                               -->
<!--  Contributors:                                                        -->
<!--      2025-06-09 George Bina: updated to use XProc 3                   -->
<!--      2025-09-08 Sheila Thomson: converted parameters to options;      -->
<!--                     changed x:log to p:store with use-when;           -->
<!--					 converted commented documentation to markup.      -->
<!--  URI:        http://github.com/xspec/xspec                            -->
<!--  Tags:                                                                -->
<!--    Copyright (c) 2011 Florent Georges (see end of file.)              -->
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->


<p:library xmlns:c="http://www.w3.org/ns/xproc-step"
	       xmlns:doc="https://www.oxygenxml.com/ns/doc/xsl"
           xmlns:p="http://www.w3.org/ns/xproc"
           xmlns:pkg="http://expath.org/ns/pkg"
           xmlns:x="http://www.jenitennison.com/xslt/xspec"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:xs="http://www.w3.org/2001/XMLSchema"
           xmlns:map="http://www.w3.org/2005/xpath-functions/map"
           pkg:import-uri="#none"
           exclude-inline-prefixes="map xs xsl x pkg p c"
           version="3.1">
	

	<p:documentation>
		<doc:p>Compile the suite on source into a stylesheet on result.</doc:p>
	</p:documentation>
	<p:declare-step type="x:compile-xslt" name="compile-xsl" expand-text="true">
	
		<p:documentation>
			<p:doc>The XSpec test file to compile.</p:doc>
		</p:documentation>
		<p:input  port="source" primary="true"/>
		
		<p:documentation>
			<p:doc>The compiled XSLT version of the XSpec test file.</p:doc>
		</p:documentation>
		<p:output port="result" primary="true"/>
	
		<p:documentation>
			<doc:p>A path to the XSLT stylesheet to use to compile the test file (optional).</doc:p>
		</p:documentation>
		<p:option name="compiler-uri" as="xs:anyURI?" static="true" />
		
		<p:documentation>
			<doc:p>Configuration options to pass through to the compiler stylesheet (optional).</doc:p>
		</p:documentation>
		<p:option name="compiler-options" as="map(xs:QName, item()*)?" static="true" />
		
		<p:documentation>
			<doc:p>A path to the root of the XSpec project (optional).</doc:p>
		</p:documentation>
		<p:option name="xspec-home" as="xs:anyURI?" static="true" />
		
		<p:documentation>
			<doc:p>If you want to store a copy of the compiled XSpec, for example to aid with 
				debugging, then you can use this option to specify where to save it (optional).  
				If this option is empty then this step will NOT save a copy of the compiled 
				XSpec result to the file-system.</doc:p>
			<doc:p>The compiled XSpec will always be output via the result port.</doc:p>
		</p:documentation>
		<p:option name="log-compiled" as="xs:anyURI?" static="true" />
            
		<p:group>			
			<p:documentation>
				<doc:ol>
					<doc:li>if compiler-uri is not passed, then use xspec-home to resolve the compiler</doc:li>
					<doc:li>if xspec-home is not passed, then use the packaging public URI</doc:li>
				</doc:ol>
			</p:documentation>
			<p:variable name="compiler"
				select="if (normalize-space($compiler-uri) != '') then (
					$compiler-uri
				) else if (normalize-space($xspec-home) != '') then (
					resolve-uri('src/compiler/compile-xslt-tests.xsl', $xspec-home)
				) else (
					'http://www.jenitennison.com/xslt/xspec/compile-xslt-tests.xsl'
				)"
			/>
			
			<p:documentation>
				<doc:p>Compile the test file into XSLT.</doc:p>
			</p:documentation>
			<p:xslt>
				<p:with-input port="source" pipe="source@compile-xsl"/>
				<p:with-input port="stylesheet">
					<p:document href="{$compiler}" pkg:kind="xslt" />
				</p:with-input>
				<p:with-option name="parameters" select="$compiler-options"/>
			</p:xslt>
		</p:group>

		<p:documentation>
			<p:doc>Store a copy of the compiled test file if a location to store it at has been supplied.</p:doc>
		</p:documentation>
		<p:store use-when="normalize-space($log-compiled) != ''" message="[debug] Saving compiled tests to {$log-compiled}">
			<p:with-option name="href" select="$log-compiled" />         
		</p:store>
		
	</p:declare-step>


	<p:documentation>
		<doc:p>Compile the suite on source into XQuery.</doc:p>
		<doc:p>Parameters to the XSpec XQuery compiler, AKA compile-xquery-tests.xsl, 
			can be supplied via the step option named compiler-options (e.g. utils-library-at to suppress 
			the at location hint to use to import the XSpec utils library modules in the 
			generated query)</doc:p>
	</p:documentation>
	<p:declare-step type="x:compile-xquery" name="compile-xq" expand-text="true">
   	
	   	<p:documentation>
	   		<p:doc>The XSpec test file to compile.</p:doc>
	   	</p:documentation>
	   	<p:input  port="source" primary="true"/>
	   	
	   	<p:documentation>
	   		<p:doc>The compiled XQuery version of the XSpec test file.</p:doc>
	   	</p:documentation>
	   	<p:output port="result" primary="true"/>
	   	
	   	<p:documentation>
	   		<doc:p>A path to the XSLT stylesheet to use to compile the test file (optional).</doc:p>
	   	</p:documentation>
	   	<p:option name="compiler-uri" as="xs:anyURI?" static="true" />
	   	
	   	<p:documentation>
	   		<doc:p>Configuration options to pass through to the compiler stylesheet (optional).</doc:p>
	   	</p:documentation>
		<p:option name="compiler-options" select="map{}" as="map(xs:QName, item()*)?" static="true" />
	   	
	   	<p:documentation>
	   		<doc:p>A path to the root of the XSpec project (optional).</doc:p>
	   	</p:documentation>
	   	<p:option name="xspec-home" as="xs:anyURI?" static="true" />
	   	
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
	   		<doc:p>The compiled XSpec will always be output via the result port.</doc:p>
	   	</p:documentation>
	   	<p:option name="log-compiled" as="xs:anyURI?" static="true" />
      
		<p:group>
      	
			<p:documentation>
				<doc:ol>
					<doc:li>if compiler-uri is not passed, then use xspec-home to resolve the compiler</doc:li>
					<doc:li>if xspec-home is not passed, then use the packaging public URI</doc:li>
				</doc:ol>
			</p:documentation>
			<p:variable name="compiler" select="if (normalize-space($compiler-uri) != '') then (
					$compiler-uri
				) else if (normalize-space($xspec-home) != '') then (
					resolve-uri('src/compiler/compile-xquery-tests.xsl', $xspec-home)
				) else (
					'http://www.jenitennison.com/xslt/xspec/compile-xquery-tests.xsl'
				)"
			/>
			
			<p:documentation>
				<doc:p>Set the compiler to be imported into another stylesheet.</doc:p>
				<doc:p>The wrapper stylesheet will be used as the compiler.</doc:p>
			</p:documentation>
			<p:insert match="/*" position="first-child" name="wrap-compiler">
				<p:with-input port="source" expand-text="false">
					<p:inline exclude-inline-prefixes="#all">
						<xsl:stylesheet
							exclude-result-prefixes="#all"
							version="3.0">
							<xsl:template match="document-node()" as="element(Q{http://www.w3.org/ns/xproc-step}query)">
								<query xmlns="http://www.w3.org/ns/xproc-step"><xsl:next-match /></query>
							</xsl:template>
						</xsl:stylesheet>
					</p:inline>
				</p:with-input>
				<p:with-input port="insertion" expand-text="true">
					<p:inline exclude-inline-prefixes="#all">
						<xsl:import href="{$compiler}" />
					</p:inline>
				</p:with-input>
			</p:insert>
			
			<p:documentation>
				<p:doc>Store a copy of the compiler code if a location to store it at has been supplied.</p:doc>
			</p:documentation>
			<p:store use-when="normalize-space($log-compiler) != ''" message="[debug] Saving compiler code to {$log-compiler}">
				<p:with-option name="href" select="$log-compiler" />         
			</p:store>
			
			
			<p:xslt>
				<p:with-input port="source" pipe="source@compile-xq"/>
				<p:with-input port="stylesheet" pipe="@wrap-compiler" />
				<p:with-option name="parameters" select="$compiler-options"/>
			</p:xslt>
			
		</p:group>
		
		<p:documentation>
			<p:doc>Store a copy of the compiled test file if a location to store it at has been supplied.</p:doc>
		</p:documentation>
		<p:store use-when="normalize-space($log-compiled) != ''" message="[debug] Saving compiled tests to {$log-compiled}">
			<p:with-option name="href" select="$log-compiled" />         
		</p:store>
		
	</p:declare-step>


	<p:documentation>
		<doc:p>Generate a formatted report from the XML test results.</doc:p>
		<doc:p>By default, this step generates an HTML document.</doc:p>
		<doc:p>If xspec-home is set, it is used to resolve the XSLT that formats the
			report.  If not, its public URI is used, to be resolved through the
			EXPath packaging system.  If the document element is not an XSpec
			x:report, the error x:ERR001 is thrown.</doc:p>
	</p:documentation>
	<p:declare-step type="x:format-report" name="format" expand-text="true">
		
		<p:documentation>
			<p:doc>The test results, as XML.</p:doc>
		</p:documentation>
		<p:input  port="source" primary="true"/>
		
		<p:documentation>
			<p:doc>The test results.  By default, these will be formatted as HTML.</p:doc>
		</p:documentation>
		<p:output port="result" primary="true"/>
		
		<p:documentation>
			<doc:p>A path to the XSLT stylesheet to use to format the test results (optional).</doc:p>
		</p:documentation>
		<p:option name="formatter-uri" as="xs:anyURI?" static="true" />
		
		<p:documentation>
			<doc:p>Configuration options to pass through to the formatter stylesheet (optional).</doc:p>
		</p:documentation>
		<p:option name="formatter-options" select="map{}" as="map(xs:QName, item()*)?" static="true" />
		
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
			<doc:p>A path to the root of the XSpec project (optional).</doc:p>
		</p:documentation>
		<p:option name="xspec-home" as="xs:anyURI?" static="true" />
		
		<p:documentation>
			<doc:p>If you want to store a copy of the formatted report, for example to aid with 
				debugging, then you can use this option to specify where to save it (optional).  
				If this option is empty then this step will NOT save a copy of the formatted report
				to the file-system.</doc:p>
			<doc:p>The formatted report will always be output via the result port.</doc:p>
		</p:documentation>
		<p:option name="log-report" as="xs:anyURI?" static="true" />
	
		<p:group>
	
			<p:documentation>
				<doc:ol>
					<doc:li>if formatter-uri is not passed, then use xspec-home to resolve the compiler</doc:li>
					<doc:li>if xspec-home is not passed, then use the packaging public URI</doc:li>
				</doc:ol>
			</p:documentation>
			<p:variable name="formatter"
				select="if (normalize-space($formatter-uri) != '') then (
					$formatter-uri
				) else if (normalize-space($xspec-home) != '') then (
					resolve-uri('src/reporter/format-xspec-report.xsl', $xspec-home)
				) else (
					'http://www.jenitennison.com/xslt/xspec/format-xspec-report.xsl'
				)"
			/>
		
			<p:choose>
				
				<p:documentation>
					<doc:p>If the source document is the XML version of the XSpec test results, then format it.</doc:p>
				</p:documentation>
				<p:when test="exists(/x:report)">
					
					<x:indent name="indent" />
					
					<p:xslt name="format-report">
						<p:with-input port="source" pipe="@indent"/>
						<p:with-input port="stylesheet">
							<p:document href="{$formatter}" pkg:kind="xslt" />
						</p:with-input>
						<p:with-option name="parameters" select="$formatter-options"/>
					</p:xslt>
					
				</p:when>
		
				<p:documentation>
					<doc:p>If the source document is NOT the XML version of the XSpec test results, then throw an error.</doc:p>
				</p:documentation>
				<p:otherwise>
					<p:error code="x:ERR001">
						<p:with-input port="source">
							<p:inline>
								<message>Not an x:report document</message>
							</p:inline>
						</p:with-input>
					</p:error>
				</p:otherwise>
			</p:choose>
			
		</p:group>
	
		<p:if test="map:size($serialization-options) > 0">
			<p:set-properties>
				<p:with-option name="properties" select="map:put( map{}, 'serialization', $serialization-options)" as="map(xs:QName, item()*)?" />
			</p:set-properties>
		</p:if>
	
		<p:documentation>
			<p:doc>Store a copy of the formatted test results if a location to store it at has been supplied.</p:doc>
		</p:documentation>
		<p:store use-when="normalize-space($log-report) != ''" message="[debug] Saving formatted report to {$log-report}">
			<p:with-option name="href" select="$log-report" />         
		</p:store>
		
	</p:declare-step>



	<p:documentation>
		<doc:p>Escapes markup.</doc:p>
		<doc:p>Also mimics @use-character-maps="x:disable-escaping" 
			in ../compiler/xquery/main.xsl.</doc:p>
	</p:documentation>
	<p:declare-step type="x:escape-markup" name="escape-markup">
	
		<p:documentation>
			<p:doc>Content to escape.</p:doc>
		</p:documentation>
		<p:input  port="source" primary="true"/>
		
		<p:documentation>
			<p:doc>Escaped result, cast to text.</p:doc>
		</p:documentation>
		<p:output port="result" primary="true"/>
		
		<p:cast-content-type content-type="text/plain"/>
		
		<p:text-replace pattern="&#xE801;" replacement="&lt;"/>
		<p:text-replace pattern="&#xE803;" replacement="&gt;"/>
		
	</p:declare-step>

	<p:documentation>
		<doc:p>Extract XQuery script as text from the XML document 
			that is generated by the compile step. That generates 
			the script inside a query XML element</doc:p>
	</p:documentation>
	<p:declare-step type="x:extract-xquery" name="extract-xquery">
		
		<p:documentation>
			<p:doc>Content to escape.</p:doc>
		</p:documentation>
		<p:input  port="source" primary="true"/>
		
		<p:documentation>
			<p:doc>Escaped result, cast to text.</p:doc>
		</p:documentation>
		<p:output port="result" primary="true"/>
		
		<x:escape-markup/>   
		
		<p:text-replace pattern="^&lt;query(.*)>" replacement=""/>
		<p:text-replace pattern="&lt;/query>\s?$" replacement=""/>
		
	</p:declare-step>


	<p:documentation>
		<doc:p>Serializes the source document with indentation.</doc:p>
	</p:documentation>
	<p:declare-step type="x:indent" name="indent">
		
		<p:documentation>
			<p:doc>Content to indent.</p:doc>
		</p:documentation>
		<p:input  port="source" primary="true"/>
		
		<p:documentation>
			<p:doc>Indented result (XML).</p:doc>
		</p:documentation>
		<p:output port="result" primary="true"/>
		
		<p:documentation>
			<doc:p>If you want to store a copy of the compiled XSpec, for example to aid with 
				debugging, then you can use this option to specify where to save it (optional).</doc:p>
			<doc:p>If this option is empty then this step will NOT save a copy of the compiled 
				XSpec result to the file-system.</doc:p>
		</p:documentation>
		<p:option name="log-indented" as="xs:anyURI?" static="true" />
		
		<p:documentation>
			<p:doc>Serialize with indentation.</p:doc>
		</p:documentation>
		<p:cast-content-type content-type="text/plain" parameters="map{'indent':1}"/>
		
		<p:documentation>
			<p:doc>Deserialize the string value.</p:doc>
		</p:documentation>
		<p:cast-content-type content-type="text/xml"/>
		
		<p:documentation>
			<p:doc>Store a copy of the indented test results if a location to store it at has been supplied.</p:doc>
		</p:documentation>
		<p:store use-when="normalize-space($log-indented) != ''" message="[debug] Saving indented source to {$log-indented}">
			<p:with-option name="href" select="$log-indented" />         
		</p:store>

	</p:declare-step>

</p:library>


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
