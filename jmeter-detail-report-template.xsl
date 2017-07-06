<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!--
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at
 
       http://www.apache.org/licenses/LICENSE-2.0
 
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

<!-- 
	Stylesheet for processing 2.1 output format test result files 
	To uses this directly in a browser, add the following to the JTL file as line 2:
	<?xml-stylesheet type="text/xsl" href="../extras/jmeter-results-detail-report_21.xsl"?>
	and you can then view the JTL in a browser
-->

<xsl:output method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" />

<!-- Defined parameters (overrideable) -->
<!-- 常量配置，此处showData为n，如果需要showdata数据需要改为y -->
<xsl:param    name="showData" select="'n'"/>
<xsl:param    name="titleReport" select="'Load Test Results'"/>
<xsl:param    name="dateReport" select="'date not defined'"/>

<xsl:template match="testResults">
	<html>
		<head>
			<title><xsl:value-of select="$titleReport" /></title>
			<style type="text/css">

				.td-content{
					width: 60%;
				}
				body {
					font:normal 68% verdana,arial,helvetica;
					color:#000000;
				}

				.space{
					margin-top:35px;
				}

				table tr td, table tr th {
					font-size: 68%;
					
				}
				table.details tr th{
				    color: #ffffff;
					font-weight: bold;
					text-align:center;
					background:#2674a6;
					<!--white-space: nowrap;-->
				}
				table.details tr td{

					background:#eeeee0;
					word-break:break;
					<!--white-space: nowrap;-->
				}

				table{
					width:100%;
					min-width:500px;
					border-collapse:collapse;
					font-weight:bold;
					color:#6b6b6b;
					box-shadow: 0 1px 3px rgba(0,0,0,0.2);
					padding:10px;
					<!-- table-layout:fixed; -->
				}

				table tr{
					height:50px;
					background:#d4d1d5;
					border-bottom:rgba(0,0,0,.05) 1px solid;
				}

				.tableTitle{
					height:60px;
					color:#f6f6f6;
					border:0px solid;
					font-size:18pt;
				}

				.summaryTitle{
					background:#418a95;
				}

				.tableHead{
					height:30px;
					color:#f6f3f7;
					font-size:6pt;
					border:0px solid;
				}

				.summaryHead{
					background:#63acb7;

				}

				.tableContent{
					height:40px;
				}

				.pagesHead{
					background:#ff9933;
				}
				.pagesTitle{
					background:#ee8822;
				}


				.pages-content-detail:hover{
					background:#dddddd;
				}

				.failureTitle{
					background:#cc6666;
				}

				.failureHead{
					background:#cc9999;
				}
				/*.pages-content-detail:hover td{
					background:none;
				}*/

				/*h1 {
					margin: 0px 0px 5px; font: 165% verdana,arial,helvetica
				}
				h2 {
					margin-top: 1em; margin-bottom: 0.5em; font: bold 125% verdana,arial,helvetica
				}
				h3 {
					margin-bottom: 0.5em; font: bold 115% verdana,arial,helvetica
				}*/
				.Failure {
					font-weight:bold; color:red;
				}
				
	
				img
				{
				  border-width: 0px;
				}
				
				.expand_link
				{
				   position: absolute;
				   right: 0px;
				   width: 27px;
				   top: 1px;
				   height: 27px;
				}
				
				.page_details
				{
				   display: none;
				}
                                
				.page_details_expanded
				{
					display: block;
					display/* hide this definition from  IE5/6 */: table-row;
				}

				.page_details_expanded tr{
					background:#aaaaaa;
				}

				.page_details_expanded td{
					padding:0px;
					padding-left:10px;
				}
				
				.detail-table{
					color:#eeeeee;
					box-shadow:none;
				}

				.failureTable{
					table-layout:fixed;
				}

				.failure_demo{
					border-right:rgba(0,0,0,.05) 1px solid;
				}

				.failure_detail{

					word-wrap:break-word;
					overflow: hidden;
					white-space: nowrap;
					text-overflow: ellipsis;
				}

				.failure_detail:hover{
					white-space:normal;
				}

			</style>
			<script language="JavaScript">
				<![CDATA[
				function expand(details_id)
			   {
			      
			      document.getElementById(details_id).className = "page_details_expanded";
			   }
			   
			   function collapse(details_id)
			   {
			      
			      document.getElementById(details_id).className = "page_details";
			   }
			   
			   function change(details_id)
			   {
					if(document.getElementById(details_id).className=="page_details")
						expand(details_id);
					else
						collapse(details_id);
					// if (document.getElementById(details_id + "_image").src.match("expand")) {
					// 	document.getElementById(details_id + "_image").src = "collapse.png";
					// 	expand(details_id);
					// }
					// else {
					// 	document.getElementById(details_id + "_image").src = "expand.png";
					// 	collapse(details_id);
					// }
                }
			]]></script>
		</head>
		<body>
		
			<xsl:call-template name="pageHeader" />
			
			<xsl:call-template name="summary" />
			
			<xsl:call-template name="pagelist" />
			
			<xsl:call-template name="detail" />

		</body>
	</html>
</xsl:template>

<xsl:template name="pageHeader">
	<h1 style="font-family: Times, TimesNR, 'New Century Schoolbook', Georgia,
 'New York', serif; font-size:3.75em"><xsl:value-of select="$titleReport" /></h1>
	<table width="100%">
		<tr>
			<td align="left">Date report: <xsl:value-of select="$dateReport" /></td>
			<td align="right">Designed for use with <a href="http://jmeter.apache.org/">JMeter</a> and <a href="http://ant.apache.org">Ant</a>.</td>
		</tr>
	</table>
	<div class="space"></div>
</xsl:template>

<xsl:template name="summary">
	<table class="summaryTable" align="center"  border="0" cellpadding="5" cellspacing="2" width="95%">
		<tr class="summaryTitle tableTitle" align="left">
			<td>基本统计</td>
			<td colspan="5"></td>
		</tr>
		
		<tr class="summaryHead tableHead" align="left">
			<td># Samples</td>
			<td>Failures</td>
			<td>Success Rate</td>	
			<td>Average Time</td>
			<td>Min Time</td>
			<td>Max Time</td>
		</tr>
		<tr class="summaryContent tableContent" valign="middle" align="left">
			<xsl:variable name="allCount" select="count(/testResults/*)" />
			<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />
			<xsl:variable name="allSuccessCount" select="count(/testResults/*[attribute::s='true'])" />
			<xsl:variable name="allSuccessPercent" select="$allSuccessCount div $allCount" />
			<xsl:variable name="allTotalTime" select="sum(/testResults/*/@t)" />
			<xsl:variable name="allAverageTime" select="$allTotalTime div $allCount" />
			<xsl:variable name="allMinTime">
				<xsl:call-template name="min">
					<xsl:with-param name="nodes" select="/testResults/*/@t" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="allMaxTime">
				<xsl:call-template name="max">
					<xsl:with-param name="nodes" select="/testResults/*/@t" />
				</xsl:call-template>
			</xsl:variable>
			
			<td>
				<div class='td-content' >
					<xsl:value-of select="$allCount" />
				</div>
			</td>
			<td>
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$allFailureCount &gt; 0">Failure</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="$allFailureCount" />
			</td>
			<td>
				<xsl:call-template name="display-percent">
					<xsl:with-param name="value" select="$allSuccessPercent" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="display-time">
					<xsl:with-param name="value" select="$allAverageTime" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="display-time">
					<xsl:with-param name="value" select="$allMinTime" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="display-time">
					<xsl:with-param name="value" select="$allMaxTime" />
				</xsl:call-template>
			</td>
		</tr>
	</table>
	<div class="space"></div>
</xsl:template>



<xsl:template name="pagelist">
	<table class="pagesTable" align="center" border="0" cellpadding="5" cellspacing="2" width="95%">
		<tr class="pagesTitle tableTitle" align="left">
			<td>统计详情</td>
			<td colspan="6"></td>
		</tr>
				
		<tr class="pagesHead tableHead" align="left">
			<td>URL</td>
			<td># Samples</td>
			<td>Failures</td>
			<td>Success Rate</td>
			<td>Average Time</td>
			<td>Min Time</td>
			<td>Max Time</td>
		</tr>
		<xsl:for-each select="/testResults/*[not(@lb = preceding::*/@lb)]">
			<xsl:variable name="label" select="@lb" />
			<xsl:variable name="count" select="count(../*[@lb = current()/@lb])" />
			<xsl:variable name="failureCount" select="count(../*[@lb = current()/@lb][attribute::s='false'])" />
			<xsl:variable name="successCount" select="count(../*[@lb = current()/@lb][attribute::s='true'])" />
			<xsl:variable name="successPercent" select="$successCount div $count" />
			<xsl:variable name="totalTime" select="sum(../*[@lb = current()/@lb]/@t)" />
			<xsl:variable name="averageTime" select="$totalTime div $count" />
			<xsl:variable name="minTime">
				<xsl:call-template name="min">
					<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="maxTime">
				<xsl:call-template name="max">
					<xsl:with-param name="nodes" select="../*[@lb = current()/@lb]/@t" />
				</xsl:call-template>
			</xsl:variable>
			<!--<tr class="pagesContent tableContent" valign="center">-->
			<tr valign="center" align="left">	
				<xsl:attribute name="class">
					<xsl:choose>
						<xsl:when test="$failureCount &gt; 0">Failure pages-content-detail</xsl:when>
						<xsl:otherwise>pages-content-detail</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="onclick">
					<xsl:text/>javascript:change('page_details_<xsl:value-of select="position()" />')
				</xsl:attribute>
				<td>
				<xsl:if test="$failureCount > 0">
				  <a class="Failure" style=""><xsl:attribute name="href">#<xsl:value-of select="$label" /></xsl:attribute>
				  <xsl:value-of select="$label" />
				  </a>
				</xsl:if>
				<xsl:if test="0 >= $failureCount">
				  <xsl:value-of select="$label" />
				</xsl:if>
				</td>
				<td>
					<xsl:value-of select="$count" />
				</td>
				<td>
					<xsl:value-of select="$failureCount" />
				</td>
				<td>
					<xsl:call-template name="display-percent">
						<xsl:with-param name="value" select="$successPercent" />
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$averageTime" />
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$minTime" />
					</xsl:call-template>
				</td>
				<td>
					<xsl:call-template name="display-time">
						<xsl:with-param name="value" select="$maxTime" />
					</xsl:call-template>
				</td>
				<!--<td align="center">
				   <a href="">
				      <xsl:attribute name="href"><xsl:text/>javascript:change('page_details_<xsl:value-of select="position()" />')</xsl:attribute>
				      <img src="expand.png" alt="expand/collapse"><xsl:attribute name="id"><xsl:text/>page_details_<xsl:value-of select="position()" />_image</xsl:attribute></img>				      
				   </a>
				</td>-->
			</tr>
			
            <tr class="page_details">
                <xsl:attribute name="id"><xsl:text/>page_details_<xsl:value-of select="position()" /></xsl:attribute>
                <td colspan="7">
                    <div align="center">
			         	<!--<b>Details for Page "<xsl:value-of select="$label" />"</b>-->
			         	<table class="detail-table" bordercolor="#000000" border="0"  cellpadding="1" cellspacing="1" width="100%">
			         		<tr align="left">
								<td>Thread</td>
								<td>Iteration</td>
								<td>Time (milliseconds)</td>
								<td>Bytes</td>
								<td>Success</td>
							</tr>
			         		         
			         		<xsl:for-each select="../*[@lb = $label and @tn != $label]">	      			            
			            		<tr align="left">
									<td><xsl:value-of select="@tn" /></td>
									<td><xsl:value-of select="position()" /></td>
									<td><xsl:value-of select="@t" /></td>
									<!--  TODO allow for missing bytes field -->
									<td><xsl:value-of select="@by" /></td>
									<td><xsl:value-of select="@s" /></td>
								</tr>
			         		</xsl:for-each>
			         
			        	</table>
			      </div>
                </td>
            </tr>
			
		</xsl:for-each>
	</table>
	<div class="space"></div>
</xsl:template>

<xsl:template name="detail">
	<xsl:variable name="allFailureCount" select="count(/testResults/*[attribute::s='false'])" />

	<xsl:if test="$allFailureCount > 0">
		
		<table class="failureTalbe" align="center" border="0" cellpadding="5" cellspacing="2" width="95%">
		<!--<table class="detailTable">-->
			<!--<h2>Failure Detail</h2>-->
			<tr class="failureTitle tableTitle" align="left">
				<td>失败详情</td>
				<xsl:choose>
					<xsl:when test="$showData = 'y'">
						<td colspan="3"></td>
					</xsl:when>
					<xsl:otherwise>
						<td colspan="2"></td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>

			<tr class="failureHead tableHead" align="left">
				<td width="30%">测试用例</td>
				<td width="20%">响应信息</td>
				<td>错误详情</td>
				<xsl:if test="$showData = 'y'">
				<th>Response Data</th>
				</xsl:if>
			</tr>

			<xsl:for-each select="/testResults/*[not(@lb = preceding::*/@lb)]">

				<xsl:variable name="failureCount" select="count(../*[@lb = current()/@lb][attribute::s='false'])" />

				<xsl:if test="$failureCount > 0">
					<!--<h3><xsl:value-of select="@lb" /><a><xsl:attribute name="name"><xsl:value-of select="@lb" /></xsl:attribute></a></h3>
									-->
					
					<xsl:for-each select="/testResults/*[@lb = current()/@lb][attribute::s='false']">
						<tr align="left" valign="top">	

								<!--<xsl:variable name="resultExist" select="count(/testResults/*[preceding::*/@lb = current()/@lb][attribute::s='false'])"/>-->
								
							<xsl:if test="position() = 1">
								<td class="failure_demo">
								<xsl:attribute name="rowspan">
									<xsl:value-of select="$failureCount"/>
								</xsl:attribute>
								<a><xsl:attribute name="name"><xsl:value-of select="@lb" /></xsl:attribute></a>					
								<xsl:value-of select="@lb"/>
								</td>
							</xsl:if>
							<td class="failure_demo"><xsl:value-of select="@rc | @rs" /> - <xsl:value-of select="@rm" /></td>
							<td class="failure_detail"><xsl:value-of select="assertionResult/failureMessage" /></td>
							<xsl:if test="$showData = 'y'">
								<td><xsl:value-of select="./binary" /></td>
							</xsl:if>
						</tr>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</table>
	</xsl:if>
</xsl:template>

<xsl:template name="min">
	<xsl:param name="nodes" select="/.." />
	<xsl:choose>
		<xsl:when test="not($nodes)">NaN</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$nodes">
				<xsl:sort data-type="number" />
				<xsl:if test="position() = 1">
					<xsl:value-of select="number(.)" />
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="max">
	<xsl:param name="nodes" select="/.." />
	<xsl:choose>
		<xsl:when test="not($nodes)">NaN</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$nodes">
				<xsl:sort data-type="number" order="descending" />
				<xsl:if test="position() = 1">
					<xsl:value-of select="number(.)" />
				</xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="display-percent">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0.00%')" />
</xsl:template>

<xsl:template name="display-time">
	<xsl:param name="value" />
	<xsl:value-of select="format-number($value,'0 ms')" />
</xsl:template>
	
</xsl:stylesheet>
