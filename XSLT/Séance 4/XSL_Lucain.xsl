<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs"
    xmlns="http://www.tei-c.org/ns/1.0" version="2.0">
    <output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="teiHeader"/>
            <xsl:apply-templates select="text"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="lg">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="l">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="app">
        <xsl:copy>
            <!--   <xsl:if test="(contrains(rdg/@wit='#P')">
                <xsl:copy-of select="rdg"/>
            </xsl:if> -->
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="lem">
        <xsl:copy-of select="."/>
    </xsl:template>

    <!--  <xsl:template match="rdg">
        <xsl:if test="contains(@wit,'#P')">
            <xsl:copy-of select="."/>
        </xsl:if>
    </xsl:template>-->

    <xsl:template match="rdg">
        <xsl:choose>
            <xsl:when test="contains(@wit, '#Z')">
                <xsl:element name="rdg">
                    <xsl:attribute name="type">
                        <xsl:text>main</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="wit">
                        <xsl:value-of select="./@wit"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="rdg">
                    <xsl:attribute name="type">
                        <xsl:text>sub</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="wit">
                        <xsl:value-of select="@wit"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  
    <xsl:template match="app">
        <xsl:copy>
        <xsl:for-each select="./rdg[@type='orthographic']">
            <xsl:element name="rdgGrp">
                <xsl:attribute name="type">orthographic</xsl:attribute>
                <xsl:copy-of select="."/>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="./rdg[@type='semantic']">
            <xsl:element name="rdgGrp">
                <xsl:attribute name="type">semantic</xsl:attribute>
                <xsl:copy-of select="."/>
            </xsl:element>
        </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    -->

    <xsl:template match="app">
        <xsl:copy>
            <xsl:element name="rdgGrp">
                <xsl:attribute name="type">orthographic</xsl:attribute>
                <xsl:for-each select="./rdg[@type = 'orthographic']">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">
                            <xsl:value-of select="@wit"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </xsl:element>
            <xsl:element name="rdgGrp">
                <xsl:attribute name="type">semantic</xsl:attribute>
                <xsl:for-each select="./rdg[@type = 'semantic']">
                    <xsl:element name="rdg">
                        <xsl:attribute name="wit">
                            <xsl:value-of select="@wit"/>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </xsl:element>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
