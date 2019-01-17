<?xml version="1.0"?>
<!--Tрансформация простого XML-сообщения в JSON-формат. (Для тех, кто имеет сложности в понимании этой трансформации можно воспользоваться утилитой Altova XMLSpy для отладки, выбрав входной xml-файл. Режим дебага позволяет выполнять код построчно и следить за формированием выходного сообщения.)-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">
		<xsl:text>{</xsl:text>
		<xsl:apply-templates select="*"/>
		<xsl:text>}</xsl:text>
	</xsl:template>
    
    <!-- Object or Element Property-->
    <xsl:template match="*">
		<xsl:text>"</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>":</xsl:text>
		<xsl:call-template name="Properties"/>
    </xsl:template>

    <!-- Array Element -->
    <xsl:template match="*" mode="ArrayElement">
		<xsl:call-template name="Properties"/>
	</xsl:template>

    <!-- Object Properties -->
    <xsl:template name="Properties">
        <xsl:variable name="childName" select="name(*[1])"/>
        <xsl:choose>
            <xsl:when test="not(*|@*)">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="."/>
				<xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="count(*[name()=$childName]) > 1">
				<xsl:text>{"</xsl:text>
				<xsl:value-of select="$childName"/>
				<xsl:text>":[</xsl:text>
				<xsl:apply-templates select="*" mode="ArrayElement"/>
				<xsl:text>]}</xsl:text>
			</xsl:when>
            <xsl:otherwise>
				<xsl:text>{</xsl:text>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="*"/>
				<xsl:text>}</xsl:text>
			</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::*">
			<xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Attribute Property -->
    <xsl:template match="@*">
		<xsl:text>"</xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>":"</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>",</xsl:text>
	</xsl:template>
</xsl:stylesheet>