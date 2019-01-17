<?xml version="1.0" encoding="UTF-8"?>
<!--Процесс получения файла маршрутизации из домена settings, а также установка полученных из него значений в качестве параметров запроса.-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:regexp="http://exslt.org/regular-expressions" xmlns:str="http://exslt.org/strings" xmlns:dp="http://www.datapower.com/extensions" extension-element-prefixes="dp regexp str" exclude-result-prefixes="dp regexp str fo">
	<xsl:template match="/">
		<xsl:variable name="URI" select="dp:variable('var://service/URI')"/>
		<xsl:variable name="routeDoc" select="document('http://127.0.0.1:7171/trunk/route/routeRules.xml')"/>
		<xsl:variable name="rule" select="$routeDoc/route/rule[starts-with($URI, @matchURI) ][1]"/>

		<xsl:choose>
			<xsl:when test="not($routeDoc)">
				<dp:reject>
					<xsl:value-of select="'Incorrect path to routeRules.xml'"/>
				</dp:reject>
			</xsl:when>
			<xsl:when test="$rule">
				<!--create backend url-->
				<xsl:variable name="destURI">
					<xsl:choose>
						<xsl:when test="$rule/@backendURI">
							<xsl:value-of select="$rule/@backendURI"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$URI"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$rule/@transformURL">
						<dp:set-request-header name="'X-DP-Backend-URI'" value="$destURI"/>
						<dp:set-request-header name="'X-DP-Backend-URL'" value="$rule/@backendURL"/>
						<dp:set-request-header name="'X-DP-Transform-Name'" value="$rule/@transformName"/>
						<dp:set-request-header name="'X-DP-Backend-Timeout'" value="$rule/@backendTimeout"/>
						<dp:set-request-header name="'X-DP-Backend-Expire'" value="$rule/@backendExpire"/>
						<dp:set-variable name="'var://service/routing-url'" value="$rule/@transformURL"/>
						<dp:set-variable name="'var://service/URI'" value="$URI"/>						
					</xsl:when>
					<xsl:otherwise>
						<dp:set-variable name="'var://service/routing-url'" value="$rule/@backendURL"/>
						<dp:set-variable name="'var://service/URI'" value="$destURI"/>
						<dp:set-variable name="'var://service/mpgw/backend-timeout'" value="$rule/@backendTimeout"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<dp:set-variable name="'var://context/frontRoute/customResultCode'" value="'404'"/>
				<dp:set-variable name="'var://context/frontRoute/customResultPhrase'" value="'Not Found'"/>
				<dp:reject>
					<xsl:value-of select="'Incorrect uri' + $rule"/>
				</dp:reject>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
</xsl:stylesheet>