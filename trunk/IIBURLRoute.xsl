<?xml version="1.0" encoding="UTF-8"?>
<!--Установка эндпоинта и параметров запроса.-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dp="http://www.datapower.com/extensions" xmlns:regexp="http://exslt.org/regular-expressions" xmlns:dpconfig="http://www.datapower.com/param/config" extension-element-prefixes="dp" exclude-result-prefixes="dp regexp dpconfig xsl xs">
	<xsl:template match="/">
		<xsl:variable name="url" select="dp:variable('var://context/IIB/url')"/>
		<xsl:variable name="uri" select="dp:variable('var://context/IIB/uri')"/>
		<xsl:variable name="expire" select="dp:variable('var://context/IIB/expire')"/>
		<xsl:variable name="timeout" select="dp:variable('var://context/IIB/timeout')"/>

		<dp:set-variable name="'var://service/routing-url'" value="string($url)"/>
		<dp:set-variable name="'var://service/protocol-method'" value="'POST'"/>
		<dp:set-variable name="'var://service/mpgw/backend-timeout'" value="string($timeout)"/>
			
		<xsl:if test="$uri != '' ">
			<xsl:variable name="final_uri">
				<xsl:value-of select="$uri"/>
				<xsl:if test="not(contains($uri, ';ReplyQueue='))">;ReplyQueue=DP.IIB.RESIN</xsl:if>
				<xsl:if test="not(contains($uri, ';PMO='))">;PMO=1024</xsl:if>
				<xsl:if test="not(contains($uri, ';ParseHeaders='))">;ParseHeaders=true</xsl:if>
				<xsl:if test="not(contains($uri, ';SetReplyTo='))">;SetReplyTo=true</xsl:if>
				<xsl:if test="not(contains($uri, ';ChannelTimeout='))">;ChannelTimeout=330</xsl:if>
			</xsl:variable>		
			<dp:set-variable name="'var://service/URI'" value="$final_uri"/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>