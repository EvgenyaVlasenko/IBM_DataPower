<?xml version="1.0" encoding="UTF-8"?>
<!--Механизм получения файла правил маршрутизации, на основе которого проверяется существование запрошенной операции и выбираются трансформации для нее.-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dp="http://www.datapower.com/extensions" xmlns:regexp="http://exslt.org/regular-expressions" xmlns:dpconfig="http://www.datapower.com/param/config" extension-element-prefixes="dp" exclude-result-prefixes="dp regexp dpconfig xsl xs">
	<xsl:template match="/">
		<!--match rules-->
		<xsl:variable name="routeName" select="dp:request-header('X-DP-Transform-Name')"/>
		<xsl:variable name="routeDoc" select="document('local:///IIB/route/IIBRouteRules.xml')"/>
		<xsl:variable name="routeRule" select="$routeDoc/jsonTransfoms/rule[@routeName=$routeName][1]"/>
		<xsl:variable name="reqTransform" select="$routeRule/@reqTransform"/>
		<xsl:variable name="ansTransform" select="$routeRule/@ansTransform"/>
		<xsl:variable name="errTransform" select="$routeRule/@errTransform"/>
		
		<xsl:choose>
			<xsl:when test="(($reqTransform != '') and ($ansTransform != ''))">
				<dp:set-variable name="'var://context/IIB/reqTransform'" value="string($reqTransform)"/>
				<dp:set-variable name="'var://context/IIB/ansTransform'" value="string($ansTransform)"/>
				<dp:set-variable name="'var://context/IIB/errTransform'" value="string($errTransform)"/>
			</xsl:when>
			<xsl:otherwise>
				<dp:reject>
					<xsl:value-of select="concat('The operation type is incorrect: ', $routeName)"/>
				</dp:reject>
			</xsl:otherwise>
		</xsl:choose>
		
		<dp:set-variable name="'var://context/IIB/url'" value="dp:request-header('X-DP-Backend-URL')"/>
		<dp:set-variable name="'var://context/IIB/uri'" value="dp:request-header('X-DP-Backend-URI')"/>
		<dp:set-variable name="'var://context/IIB/expire'" value="dp:request-header('X-DP-Backend-Expire')"/>
		<dp:set-variable name="'var://context/IIB/timeout'" value="dp:request-header('X-DP-Backend-Timeout')"/>
		
	</xsl:template>
</xsl:stylesheet>