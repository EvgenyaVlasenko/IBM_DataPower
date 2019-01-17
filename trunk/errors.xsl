<?xml version="1.0" encoding="UTF-8"?>
<!--Описание формата ошибки, произошедшей на этапе прохождения routingMPG, аналогично файлу cmnJSONerror.xsl.-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp fo">
	<xsl:output method="text" encoding="utf-8" indent="no" media-type="application/json"/>
	<xsl:template match="/">
		<xsl:variable name="timestamp" select="dp:time-value()"/>
		<xsl:variable name="status">
			<xsl:choose>
				<xsl:when test="dp:variable('var://context/frontRoute/customResultCode') != ''">
					<xsl:value-of select="dp:variable('var://context/frontRoute/customResultCode')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'500'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="message" select="dp:variable('var://service/error-message')"/>
		<dp:set-variable name="'var://service/error-protocol-response'" value="$status"/>
		
		<xsl:text>{ "timestamp": </xsl:text>
		<xsl:value-of select="$timestamp"/>
		<xsl:text>, </xsl:text>
		
		<xsl:text> "status": </xsl:text>
		<xsl:value-of select="$status"/>
		<xsl:text>, </xsl:text>
		
		<xsl:text> "message": "</xsl:text>
		<xsl:value-of select="$message"/>
		<xsl:text>" }</xsl:text>
		
	</xsl:template>
</xsl:stylesheet>