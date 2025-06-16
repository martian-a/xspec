<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/home/sheila/Code/repositories/my-xspec-fork/src/compiler/compile-xslt-tests.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/home/sheila/Tools/oxygen-xml/developer/27/frameworks/xspec/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/home/sheila/Code/repositories/my-xspec-fork/src/compiler/compile-xslt-tests.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-aware"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name') eq 'SAXON') and starts-with(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version'), 'EE ')"
                 static="yes"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}logical-processor-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware"
                 select="Q{java:java.lang.Runtime}getRuntime() =&gt; Q{java:java.lang.Runtime}availableProcessors()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 select="1"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware =&gt; not()"/>
   <xsl:param xmlns:t="http://www.jenitennison.com/xslt/xspec"
              name="Q{}measure-time"
              select="false()"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/src/compiler/compile-xslt-tests.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 2">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>x:scenario[@label] transformed in x:compile-scenario template</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>x:scenario[@label] transformed in x:compile-scenario template</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="t:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests/compile-scenario.xspec</xsl:attribute>
               <xsl:attribute name="select" namespace="">//t:scenario</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d60e0-doc"
                       as="document-node()"
                       select="doc('file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests/compile-scenario.xspec')"/>
         <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                       name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d60e0-doc ! ( //t:scenario )"/>
         <xsl:if test="empty($Q{http://www.jenitennison.com/xslt/xspec}context)">
            <xsl:message terminate="yes">ERROR in t:context (under 'x:scenario[@label] transformed in x:compile-scenario template'): Context is an empty sequence.</xsl:message>
         </xsl:if>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="t:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="template" namespace="">t:compile-scenario</xsl:attribute>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">call</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">reason-for-pending</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">run-sut-now</xsl:attribute>
                  <xsl:attribute name="select" namespace="">false()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d56e1"
                          as="empty-sequence()"><!--$call--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d56e2"
                          as="empty-sequence()"><!--$context--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d56e3"
                          as="empty-sequence()"><!--$reason-for-pending--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d56e4"
                          select="false()"><!--$run-sut-now--></xsl:variable>
            <xsl:for-each select="$Q{http://www.jenitennison.com/xslt/xspec}context">
               <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}compile-scenario">
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}call"
                                  select="$Q{urn:x-xspec:compile:impl}param-d56e1"
                                  tunnel="yes"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}context"
                                  select="$Q{urn:x-xspec:compile:impl}param-d56e2"
                                  tunnel="yes"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}reason-for-pending"
                                  select="$Q{urn:x-xspec:compile:impl}param-d56e3"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}run-sut-now"
                                  select="$Q{urn:x-xspec:compile:impl}param-d56e4"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:message>- is xsl:template - @name is Q{XSpec-namespace}scenario-ID - the scenario label xsl:message - the constructor (xsl:element) of the x:scenario element - the constructor (xsl:element) of the x:scenario/x:label element</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d52e12-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="xsl:template" namespace="http://www.w3.org/1999/XSL/Transform">
               <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                              name="name"
                              namespace=""
                              select="'', ''"
                              separator="Q{{http://www.jenitennison.com/xslt/xspec}}dummy-scenario-id"/>
               <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                              name="as"
                              namespace=""
                              select="'', ''"
                              separator="element(Q{{http://www.jenitennison.com/xslt/xspec}}scenario)"/>
               <xsl:element name="xsl:context-item"
                            namespace="http://www.w3.org/1999/XSL/Transform">
                  <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                 name="use"
                                 namespace=""
                                 select="'', ''"
                                 separator="absent"/>
               </xsl:element>
               <xsl:element name="xsl:message" namespace="http://www.w3.org/1999/XSL/Transform">
                  <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:text>my scenario label</xsl:text>
               </xsl:element>
               <xsl:element name="xsl:element" namespace="http://www.w3.org/1999/XSL/Transform">
                  <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                 name="name"
                                 namespace=""
                                 select="'', ''"
                                 separator="scenario"/>
                  <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                 name="namespace"
                                 namespace=""
                                 select="'', ''"
                                 separator="http://www.jenitennison.com/xslt/xspec"/>
                  <xsl:element name="xsl:attribute" namespace="http://www.w3.org/1999/XSL/Transform">
                     <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="name"
                                    namespace=""
                                    select="'', ''"
                                    separator="id"/>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="namespace"
                                    namespace=""
                                    select="'', ''"
                                    separator=""/>
                     <xsl:text>dummy-scenario-id</xsl:text>
                  </xsl:element>
                  <xsl:element name="xsl:attribute" namespace="http://www.w3.org/1999/XSL/Transform">
                     <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="name"
                                    namespace=""
                                    select="'', ''"
                                    separator="xspec"/>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="namespace"
                                    namespace=""
                                    select="'', ''"
                                    separator=""/>
                  </xsl:element>
                  <xsl:element name="xsl:element" namespace="http://www.w3.org/1999/XSL/Transform">
                     <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="name"
                                    namespace=""
                                    select="'', ''"
                                    separator="label"/>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="namespace"
                                    namespace=""
                                    select="'', ''"
                                    separator="http://www.jenitennison.com/xslt/xspec"/>
                     <xsl:element name="xsl:text" namespace="http://www.w3.org/1999/XSL/Transform">
                        <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:text>my scenario label</xsl:text>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d52e12"
                    select="$Q{urn:x-xspec:compile:impl}expect-d52e12-doc ! ( node() )"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d52e12, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario1-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>
            - is xsl:template
            - @name is Q{XSpec-namespace}scenario-ID
            - the scenario label xsl:message
            - the constructor (xsl:element) of the x:scenario element
            - the constructor (xsl:element) of the x:scenario/x:label element
         </xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d52e12"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>x:expect[@test] transformed in x:compile-expect template</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>x:expect[@test] transformed in x:compile-expect template</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="t:context" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="href" namespace="">file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests/compile-expect.xspec</xsl:attribute>
               <xsl:attribute name="select" namespace="">//t:expect</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{urn:x-xspec:compile:impl}context-d78e0-doc"
                       as="document-node()"
                       select="doc('file:/home/sheila/Code/repositories/my-xspec-fork/test/compile-xslt-tests/compile-expect.xspec')"/>
         <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                       name="Q{http://www.jenitennison.com/xslt/xspec}context"
                       select="$Q{urn:x-xspec:compile:impl}context-d78e0-doc ! ( //t:expect )"/>
         <xsl:if test="empty($Q{http://www.jenitennison.com/xslt/xspec}context)">
            <xsl:message terminate="yes">ERROR in t:context (under 'x:expect[@test] transformed in x:compile-expect template'): Context is an empty sequence.</xsl:message>
         </xsl:if>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="t:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="template" namespace="">t:compile-expect</xsl:attribute>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">call</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">context</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
                  <xsl:attribute name="tunnel" namespace="">yes</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">reason-for-pending</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
               </xsl:element>
               <xsl:element name="t:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">param-uqnames</xsl:attribute>
                  <xsl:attribute name="as" namespace="">empty-sequence()</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d74e1"
                          as="empty-sequence()"><!--$call--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d74e2"
                          as="empty-sequence()"><!--$context--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d74e3"
                          as="empty-sequence()"><!--$reason-for-pending--></xsl:variable>
            <xsl:variable xmlns:t="http://www.jenitennison.com/xslt/xspec"
                          name="Q{urn:x-xspec:compile:impl}param-d74e4"
                          as="empty-sequence()"><!--$param-uqnames--></xsl:variable>
            <xsl:for-each select="$Q{http://www.jenitennison.com/xslt/xspec}context">
               <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}compile-expect">
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}call"
                                  select="$Q{urn:x-xspec:compile:impl}param-d74e1"
                                  tunnel="yes"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}context"
                                  select="$Q{urn:x-xspec:compile:impl}param-d74e2"
                                  tunnel="yes"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}reason-for-pending"
                                  select="$Q{urn:x-xspec:compile:impl}param-d74e3"
                                  as="empty-sequence()"/>
                  <xsl:with-param xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                  name="Q{}param-uqnames"
                                  select="$Q{urn:x-xspec:compile:impl}param-d74e4"
                                  as="empty-sequence()"/>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
         </xsl:call-template>
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect2">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}context"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:message>is a template</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d52e33" select="()"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                select="$t:result instance of element(xsl:template)"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:t="http://www.jenitennison.com/xslt/xspec"
                             select="$t:result instance of element(xsl:template)"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:sequence select="$Q{urn:x-xspec:compile:impl}test-result =&gt; boolean()"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:message terminate="yes">ERROR in t:expect ('x:expect[@test] transformed in x:compile-expect template is a template'): Non-boolean @test must be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>is a template</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="t:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="test" namespace="">$t:result instance of element(xsl:template)</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d52e33"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}scenario2-expect2"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}context"
                 as="item()*"
                 required="yes"/>
      <xsl:message>@test must be transformed to xsl:sequence/@select</xsl:message>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d52e34-doc"
                    as="document-node()">
         <xsl:document>
            <xsl:element name="xsl:variable" namespace="http://www.w3.org/1999/XSL/Transform">
               <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
               <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                              name="name"
                              namespace=""
                              select="'', ''"
                              separator="Q{{urn:x-xspec:compile:impl}}test-result"/>
               <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                              name="as"
                              namespace=""
                              select="'', ''"
                              separator="item()*"/>
               <xsl:element name="xsl:choose" namespace="http://www.w3.org/1999/XSL/Transform">
                  <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                  <xsl:element name="xsl:when" namespace="http://www.w3.org/1999/XSL/Transform">
                     <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                    name="test"
                                    namespace=""
                                    select="'', ''"
                                    separator="count($Q{{urn:x-xspec:compile:impl}}test-items) eq 1"/>
                     <xsl:element name="xsl:for-each" namespace="http://www.w3.org/1999/XSL/Transform">
                        <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                       name="select"
                                       namespace=""
                                       select="'', ''"
                                       separator="$Q{{urn:x-xspec:compile:impl}}test-items"/>
                        <xsl:element name="xsl:sequence" namespace="http://www.w3.org/1999/XSL/Transform">
                           <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                           <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                          name="select"
                                          namespace=""
                                          select="'', ''"
                                          separator="false()"/>
                           <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                          name="version"
                                          namespace=""
                                          select="'', ''"
                                          separator="3"/>
                        </xsl:element>
                     </xsl:element>
                  </xsl:element>
                  <xsl:element name="xsl:otherwise" namespace="http://www.w3.org/1999/XSL/Transform">
                     <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                     <xsl:element name="xsl:sequence" namespace="http://www.w3.org/1999/XSL/Transform">
                        <xsl:namespace name="t">http://www.jenitennison.com/xslt/xspec</xsl:namespace>
                        <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                       name="select"
                                       namespace=""
                                       select="'', ''"
                                       separator="false()"/>
                        <xsl:attribute xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                       name="version"
                                       namespace=""
                                       select="'', ''"
                                       separator="3"/>
                     </xsl:element>
                  </xsl:element>
               </xsl:element>
            </xsl:element>
         </xsl:document>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}expect-d52e34"
                    select="$Q{urn:x-xspec:compile:impl}expect-d52e34-doc ! ( node() )"><!--expected result--></xsl:variable>
      <!-- wrap $x:result into a document node if possible -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-items" as="item()*">
         <xsl:choose>
            <xsl:when test="exists($Q{http://www.jenitennison.com/xslt/xspec}result) and Q{http://www.jenitennison.com/xslt/xspec}wrappable-sequence($Q{http://www.jenitennison.com/xslt/xspec}result)">
               <xsl:sequence select="Q{http://www.jenitennison.com/xslt/xspec}wrap-nodes($Q{http://www.jenitennison.com/xslt/xspec}result)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <!-- evaluate the predicate with $x:result (or its wrapper document node) as context item if it is a single item; if not, evaluate the predicate without context item -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}test-result" as="item()*">
         <xsl:choose>
            <xsl:when test="count($Q{urn:x-xspec:compile:impl}test-items) eq 1">
               <xsl:for-each select="$Q{urn:x-xspec:compile:impl}test-items">
                  <xsl:sequence xmlns:t="http://www.jenitennison.com/xslt/xspec"
                                select="$t:result/xsl:variable[@name eq 'Q{urn:x-xspec:compile:impl}test-result']"
                                version="3"/>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence xmlns:t="http://www.jenitennison.com/xslt/xspec"
                             select="$t:result/xsl:variable[@name eq 'Q{urn:x-xspec:compile:impl}test-result']"
                             version="3"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}boolean-test"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="$Q{urn:x-xspec:compile:impl}test-result instance of Q{http://www.w3.org/2001/XMLSchema}boolean"/>
      <!-- did the test pass? -->
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean">
         <xsl:choose>
            <xsl:when test="$Q{urn:x-xspec:compile:impl}boolean-test">
               <xsl:message terminate="yes">ERROR in t:expect ('x:expect[@test] transformed in x:compile-expect template @test must be transformed to xsl:sequence/@select'): Boolean @test must not be accompanied by @as, @href, @select, or child node.</xsl:message>
            </xsl:when>
            <xsl:otherwise>
               <xsl:sequence select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d52e34, $Q{urn:x-xspec:compile:impl}test-result, '')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">scenario2-expect2</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>@test must be transformed to xsl:sequence/@select</xsl:text>
         </xsl:element>
         <xsl:element name="expect-test-wrap" namespace="">
            <xsl:element name="t:expect" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="test" namespace="">$t:result/xsl:variable[@name eq 'Q{urn:x-xspec:compile:impl}test-result']</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:if test="not($Q{urn:x-xspec:compile:impl}boolean-test)">
            <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
               <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}test-result"/>
               <xsl:with-param name="report-name" select="'result'"/>
            </xsl:call-template>
         </xsl:if>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d52e34"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
