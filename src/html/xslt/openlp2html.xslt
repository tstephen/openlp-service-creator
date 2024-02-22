<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright 2024 Tim Stephenson and contributors
  
  Convert OpenLP song export format to HTML for previewing.
-->
<xsl:stylesheet version="1.0" 
  xmlns:olp="http://openlyrics.info/namespace/2009/song"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:openapi="https://openapis.org/omg/extension/1.0"
  xmlns:rss="http://purl.org/rss/2.0/"
  xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html" />

  <xsl:variable name="marginLeft" select="50" />
  <xsl:variable name="marginTop" select="50"/>
  <xsl:variable name="lcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="ucase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
        <title>
          <xsl:apply-templates select="olp:titles/olp:title[position()=1]"/>
        </title>
        <link rel="stylesheet" href="style.css"/>
        <style>
          body { font-family: Helvetica, Ubuntu, Roboto, Calibri, sans-serif; }
          header, section, footer { padding: 0.3rem 1rem; }
          header, footer { background-color: #cccccc; }
        </style>
      </head>
      <body>
        <xsl:apply-templates select="olp:song"/>
    	<script src="index.js"></script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="olp:author">
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="olp:br">
    <br/>
  </xsl:template>

  <xsl:template match="olp:lines">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="olp:properties">
    <h1>
      <xsl:apply-templates select="olp:titles/olp:title[position()=1]"/>
    </h1>
  </xsl:template>

  <xsl:template match="olp:properties" mode="footer">
    <p>
      <xsl:apply-templates select="olp:titles/olp:title[position()=1]"/>
    <br/>
      <xsl:apply-templates select="olp:authors/olp:author"/>
    <br/>
    &#xA9;<xsl:value-of select="olp:copyright"/>
    <br/>
    CCLI No: <xsl:value-of select="olp:ccliNo"/>
    </p>
  </xsl:template>

  <xsl:template match="olp:song">
    <header>
      <xsl:apply-templates select="olp:properties"/>
    </header>
    <main>
      <xsl:apply-templates select="olp:lyrics/olp:verse"/>
    </main>
    <footer>
      <xsl:apply-templates select="olp:properties" mode="footer"/>
    </footer>
  </xsl:template>

  <xsl:template match="olp:title">
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="olp:verse">
    <section>
      <xsl:apply-templates />
    </section>
  </xsl:template>

  <!-- standard copy template -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <!-- ********************** -->
  <!-- NAMED TEMPLATES FOLLOW -->
  <!-- ********************** -->
  
</xsl:stylesheet>
