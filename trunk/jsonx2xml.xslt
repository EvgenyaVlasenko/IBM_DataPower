<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:json="http://www.ibm.com/xmlns/prod/2009/jsonx" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp json">
 <xsl:output method="xml" omit-xml-declaration="yes"/>
 <xsl:template match="/">
  <xsl:apply-templates/>  
 </xsl:template>
 <xsl:template match="json:object">
  <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="json:object[@name]">
  <xsl:element name="{@name}">
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>
 <xsl:template match="json:array[@name='']">
  <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="json:array[@name]">
  <xsl:element name="{@name}">
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>
 <xsl:template match="json:string[@name]">
  <xsl:choose>
   <xsl:when test="contains(./@name,'@')">
    <xsl:attribute name="{substring(./@name,2,string-length(./@name))}"><xsl:value-of select="."/></xsl:attribute>
   </xsl:when>
   <xsl:when test="./@name='Value'">
    <xsl:value-of select="."/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:element name="{@name}">
     <xsl:value-of select="."/>
    </xsl:element>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 <xsl:template match="json:number[@name]">
  <xsl:choose>
   <xsl:when test="contains(./@name,'@')">
    <xsl:attribute name="{substring(./@name,2,string-length(./@name))}"><xsl:value-of select="."/></xsl:attribute>
   </xsl:when>
   <xsl:when test="./@name='Value'">
    <xsl:value-of select="."/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:element name="{@name}">
     <xsl:value-of select="."/>
    </xsl:element>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 <xsl:template match="json:boolean[@name]">
  <xsl:element name="{@name}">
   <xsl:value-of select="."/>
  </xsl:element>
 </xsl:template>
 <xsl:template match="json:null[@name]">
  <xsl:element name="{@name}">
   <xsl:value-of select="."/>
  </xsl:element>
 </xsl:template>
 <xsl:template match="text()"/>
</xsl:stylesheet>