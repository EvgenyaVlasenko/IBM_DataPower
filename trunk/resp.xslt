<!--Явная установка полученного от основного MPG HTTP кода. Если этого не сделать, то, по умолчанию, при возникновении ошибки, будет выставлен код 200.-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp" exclude-result-prefixes="dp">
	<xsl:template match="/">
		<xsl:variable name="httpStatus" select="dp:http-response-header('x-dp-response-code')"/>
		<dp:set-http-response-header name="'x-dp-response-code'" value="$httpStatus"/>
	</xsl:template>
</xsl:stylesheet>