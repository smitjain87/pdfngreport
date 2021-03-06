<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:java="http://xml.apache.org/xslt/java" exclude-result-prefixes="java">
	<xsl:output indent="yes" />
	<xsl:strip-space elements="*" />
	<xsl:template match="/">
		<fo:root>
                 
                    
			<fo:layout-master-set>
				<fo:simple-page-master master-name="rest"
					page-height="150mm" margin-left="3mm" margin-right="3mm"
					margin-top="3mm" margin-bottom="3mm">
					<fo:region-body region-name="xsl-region-body"
						margin-top="10mm" margin-bottom="5mm" />
					<fo:region-before region-name="xsl-region-before"
						extent="10cm" />
					<fo:region-after region-name="xsl-region-after"
						extent="5mm" margin-bottom="5mm" />
				</fo:simple-page-master>
			</fo:layout-master-set>

			<fo:page-sequence initial-page-number="1" language="en"
				country="us" master-reference="rest">
				<fo:static-content flow-name="xsl-region-before">
                                    <fo:block-container position="absolute" font-weight="bold" color="#2580BC" line-height="5mm"
											font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
											padding-top="1cm" font-size="18pt"
											text-align="left"  margin-left="2mm">
                                        
                                        <fo:block text-align="{ReportData/TitleAlign}" padding-top="5mm">
                                             <xsl:value-of select="ReportData/ReportTitle" text-align="center"/>
                                        </fo:block>
                                    </fo:block-container>
                                    <xsl:if test="(ReportData/Logo)='show'">
                                    <fo:block-container position="absolute">
                                        <fo:block text-align="{ReportData/LogoAlign}" margin-right="4mm">
                                            <fo:external-graphic content-width="2in" src="url(file:/{ReportData/LogoFile})" content-height="2cm" />
                                        </fo:block>
                                    </fo:block-container>
                                    </xsl:if>
				</fo:static-content>

				<fo:static-content flow-name="xsl-region-after" >
					<fo:block font-size="10pt" >
						<fo:table width="100%" table-layout="fixed"
							border-top-color="black" border-top-width=".5pt"
							border-top-style="solid">
							<fo:table-column column-width="6mm" />
							<fo:table-column column-width="19.2cm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="normal"
											font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
											padding-top="5%" padding-bottom="5%" font-size="10pt"
											text-align="center" >
											<fo:page-number />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block font-weight="normal"
											font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
											font-size="6.5pt" padding-top="1%" margin-left="2mm"
											text-align="left">
											generated by <fo:basic-link external-destination="http://uttesh.github.io/pdfngreport/" show-destination="new">pdfngreport </fo:basic-link>
											<xsl:value-of select="ReportData/CreatedBy" />
											on
											<xsl:value-of
												select="java:format(java:java.text.SimpleDateFormat.new
												('dd MMM yyyy h:mm:ss a'), java:java.util.Date.new())" />
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<xsl:apply-templates />
					<fo:block id="end"></fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
        
	<xsl:template match="ReportData" >

		<xsl:for-each select="Table">
                    <fo:block font-size="10pt" margin-top="1.2cm">
						<fo:table width="100%" table-layout="fixed" >
							<fo:table-column 
								column-width="20cm" />
							<fo:table-body background-color="{TableHeaderColor}">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold"
											font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
											padding-top="1.5%" padding-bottom="1.3%" font-size="10pt"
											text-align="left" color="#fff" margin-left="2mm">
											<fo:external-graphic content-height="scale-to-fit" height="15pt" margin-right="2mm"   content-width="25pt" src="{TableHeaderIcon}"/>
                                                                                <xsl:value-of select="TableName" />
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
                    </fo:block>
			<fo:table space-after="4pt" table-layout="fixed" width="98.1%"
				table-omit-header-at-break="false">
				<fo:table-header>
					<fo:table-row>
						<xsl:apply-templates select="ColumnHeaders/ColumnHeader" />
					</fo:table-row>
				</fo:table-header>
				<fo:table-body>
					<xsl:apply-templates select="Rows/Row" />
				</fo:table-body>
			</fo:table>
                    <xsl:if test="TableName = 'Statistics'">
                     <fo:block font-size="10pt" margin-top="10pt">
                        <fo:external-graphic src="url(file:/{ReportLocation}/chart.png)"  content-height="scale-to-fit" scaling="non-uniform"/>
                     </fo:block>
                    </xsl:if>
			<xsl:if test="position() != last()">
				<fo:block break-after="page" />
			</xsl:if>
		</xsl:for-each>
                
                <xsl:if test="ExceptionPage = 'show'">
                    <fo:block font-size="10pt" >
                        <fo:block break-after="page" />
                        <fo:table width="100%" table-layout="fixed" margin-top="1.2cm">
                            <fo:table-column  column-width="20cm" />
                            <fo:table-body background-color="#D54125">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block font-weight="bold"
                                              font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
                                              padding-top="1.5%" padding-bottom="1.3%" font-size="10pt"
                                              text-align="left" color="#fff" margin-left="2mm">
                                            <fo:external-graphic content-height="scale-to-fit" height="15pt" margin-right="2mm"  content-width="25pt" src="{ExceptionIcon}"/>
                                            Exception Summary
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>      
                    </fo:block>
                     
                    <xsl:for-each select="ExceptionMeta">
                        <fo:block id="{ErrorCode}" 
                         font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
                         padding-top="1.5%" padding-bottom="1.3%" font-size="10pt"
                         text-align="left" margin-left=".2mm" margin-right="3.6mm" border=".5pt"
                         border-style="solid" border-color="black" padding="1mm">
                            <fo:inline border-after-width=".5pt" color="red" border-after-style="solid">
                                <xsl:value-of select="Heading"/>
                            </fo:inline>
                            <fo:block></fo:block>
                            <xsl:value-of select="Description"/>
                        </fo:block>
                        <fo:block>
                            <fo:leader leader-pattern="rule" leader-length="19cm" />
                        </fo:block>
                    </xsl:for-each>
                </xsl:if>
	</xsl:template>
	<xsl:template match="ColumnHeader">
		<fo:table-cell border-bottom-color="black" background-color="{ColorCode}" 
			border-top-color="black" border-right-color="black" display-align="center"
			padding-top="1.5%" padding-bottom="1.3%" border-bottom-width=".5pt"
			border-top-width=".5pt" border-top-style="solid" border-bottom-style="solid">
			<fo:block color="white"
				font-family="Arial, Helvetica, Gyosho, Trado, sans-serif" font-size="8pt"
				vertical-align="bottom" text-align="left" font-weight="bold" margin-left="2mm">
				<xsl:value-of select="Name" />
			</fo:block>
		</fo:table-cell>

	</xsl:template>
	<xsl:template match="Row">
		<xsl:if test="(position() mod 2) = 1">
			<fo:table-row>
				<xsl:apply-templates />
			</fo:table-row>
		</xsl:if>
		<xsl:if test="(position() mod 2) = 0">
			<fo:table-row background-color="#F2F2F2">
				<xsl:apply-templates  />
			</fo:table-row>
		</xsl:if>
	</xsl:template>
	<xsl:template match="RowMeta">
            
                <fo:table-cell border-bottom-width=".5pt"
			border-bottom-style="solid" border-bottom-color="black" padding="1mm" margin-left="2mm">
                        <fo:block font-size="7.5pt"
                            font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
                            font-style="normal" text-align="left" wrap-option="wrap">
                            
                             <xsl:choose>
                                    <xsl:when test="TableName = 'Statistics'">
                                      <xsl:value-of select="PASSED"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                     <xsl:value-of select="TIME"/>
                                    </xsl:otherwise>
                             </xsl:choose>
                       </fo:block>
		</fo:table-cell>
                <fo:table-cell border-bottom-width=".5pt"
			border-bottom-style="solid" border-bottom-color="black" padding="1mm" margin-left="2mm">
			<fo:block font-size="7.5pt"
				font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
				font-style="normal" text-align="left" wrap-option="wrap">
                            <xsl:choose>
                                    <xsl:when test="TableName = 'Statistics'">
                                      <xsl:value-of select="SKIPPED"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="CLASSNAME"/>
                                    </xsl:otherwise>
                             </xsl:choose>
                          
			</fo:block>
		</fo:table-cell>
                <fo:table-cell border-bottom-width=".5pt"
			border-bottom-style="solid" border-bottom-color="black" padding="1mm" margin-left="2mm">
			<fo:block font-size="7.5pt"
				font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
				font-style="normal" text-align="left" wrap-option="wrap">
                             <xsl:choose>
                                    <xsl:when test="TableName = 'Statistics'">
                                       <xsl:value-of select="FAILED"/> 
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="METHOD"/>
                                    </xsl:otherwise>
                             </xsl:choose>
                         
			</fo:block>
		</fo:table-cell>
                <fo:table-cell border-bottom-width=".5pt"
			border-bottom-style="solid" border-bottom-color="black" padding="1mm" margin-left="2mm">
			<fo:block font-size="7.5pt"
				font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
				font-style="normal" text-align="left" wrap-option="wrap">
                            <xsl:choose>
                                    <xsl:when test="TableName = 'Statistics'">
                                       <xsl:value-of select="PERCENTAGE"/> 
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="TIMETAKEN"/>
                                    </xsl:otherwise>
                             </xsl:choose>
                          
			</fo:block>
		</fo:table-cell>
                <xsl:if test="ExceptionPage = 'show'">
                    <xsl:if test="STATUS='FAILED'">
                        <fo:table-cell border-bottom-width=".5pt"
                                   border-bottom-style="solid" border-bottom-color="black" padding="1mm" margin-left="2mm">
                            <fo:block font-size="7.5pt"
                                                  font-family="Arial, Helvetica, Gyosho, Trado, sans-serif"
                                                  font-style="italic" text-align="left">
                                <fo:basic-link internal-destination="{BLOCKID}" show-destination="new">
                                    <fo:external-graphic content-height="scale-to-fit" height="12pt" margin-right="2mm"  content-width="25pt"  src="data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACABAMAAAAxEHz4AAAAMFBMVEUAAAD///+cpLDIzNPT19yRmqj09fa9wst7hpYAAAAAAAAAAAAAAAAAAAAAAAAAAABeYK5aAAAAAXRSTlMAQObYZgAAARhJREFUeNpjYBgFo2AUjIJRAAOMuCQE0fjvcahjotQFA28AWhgwGd0loMHo7gM8LmCNJ6Sf4dy3ABQ+MwovfwVhN/97/hWnF1h5iPK2/QZcXmAkLtwEcOpR/EBcwL/D5QIBMmKOYgMY0dM/LM03TkDRxP4CoYb1FTEpsQ2VG4HE/k1UUv6ZgMxjm0B6XpiejEgfZpnEBYggnnyPS80wKA9GDRg1AARYiKsZcdeOwzcM3o+mg9F0MJoORtPBaDoYTQej6WA0HYzkdDBqwKgBGHnB4AL2kgANMON0AXFDKAz/aWfAU+IM8MNpwH/iDPiA04DfCcToZ9uAOxqnBBDWz2qJewiEiOFAVl204cBRMApGwSgYBaMAGQAAyJ4yiurAIEIAAAAASUVORK5CYII="/>
                                </fo:basic-link>
                                <xsl:if test="SHOW_SCREEN_SHOT_LINK = 'show'">
                                    <fo:basic-link external-destination="{FAILED_SCREEN_SHOT_LOCATION}//{BLOCKID}.png" show-destination="new">
                                        <fo:external-graphic content-height="scale-to-fit" height="15pt" margin-right="2mm"  content-width="25pt" src="data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACABAMAAAAxEHz4AAAAMFBMVEUAAACcpLDIzNPT19z///+Rmqj09fa9wst7hpbe4eVwe42nrrmyuMKGkJ/p6+5lcYXfCGFQAAAAAXRSTlMAQObYZgAAAedJREFUeNpjYBgFo2AUjIJRMAoQgBGNq6RIQMO7ex/wGMAa/4CglUxcG1C4KJL5hPUz/PuOwmVGcQAHMb7+r3cDlwsYiQs3AZxe4CPOgIc4DRAgI+YoNoAF3YA9BHS7oAU8ExmJ7x+lBjCMGjBSDeAoNm+gyICci7zHKTGA/QIDw98CCgyoBRE3KDAAXBD/p8CAAyDiz0BGowNG2UOiAQK4y2ziDGgGERoUGPDTAFgSTqAkEKfoB1til2EhzoAfvSOzPODabHyWEgO4tCYKlr+lwAAvUPILLyDbAB5IW+om2QZ4QKjfBWQawAVrzF0k0wB46cHcQJ4BfXDWA7IMYEc0Jl+SZYAvgkkgGJnwByEIXCXDAJQCmHEB6Qb0obSpHCB0u1EAsQawo7THGZIhSXOv0M8PRBrgi9awBJuXgT08mQgFIQjMhdav2KKUiVAQggtlYDDmgqP0AFEG9GE0TT8wcF4As3qJMQAtCEFgE0M31C3EGOCLxaM7oYb+UyBsABeWuII5gIFBl7ABf/BXcoQN6CO+qY/VACxBSFpm8qW0Yvkw2tgeNWDUAMoNIDIj/R/EBnwizgB5nAb8J86ADzgN+G1AjH5mPGNpExWIiDdO3GNCRAwHMr2594FhFIyCUTAKRsEowAUAuqVjKkMvEHEAAAAASUVORK5CYII="/>
                                    </fo:basic-link>
                                </xsl:if>
                            </fo:block>
                        </fo:table-cell>
                    </xsl:if>
                </xsl:if>
	</xsl:template>
        
        
</xsl:stylesheet>