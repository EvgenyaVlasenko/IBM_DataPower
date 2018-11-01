<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp fo">
	<xsl:output method="text" encoding="utf-8" indent="no" media-type="application/json"/>
	<xsl:template match="/">
		<xsl:variable name="errorcode" select="dp:variable('var://service/error-code')"/>
		<xsl:variable name="error" select="dp:variable('var://service/error-message')"/>
		<xsl:variable name="customCode">
			<xsl:value-of select="'500'"/>
		</xsl:variable>
		<xsl:variable name="customPhrase">
			<xsl:value-of select="'Error'"/>
		</xsl:variable>
		<dp:set-variable name="'var://service/error-protocol-response'" value="$customCode"/>
		<dp:set-variable name="'var://service/error-protocol-reason-phrase'" value="$customPhrase"/>
		<xsl:text>{ "resultCode": "</xsl:text>
		<xsl:value-of select="$errorcode"/>
		<xsl:text>" , </xsl:text>
		<xsl:text>"resultMsg": "</xsl:text>
		<xsl:value-of select="$error"/>
		<xsl:text>" }</xsl:text>
	</xsl:template>
</xsl:stylesheet>