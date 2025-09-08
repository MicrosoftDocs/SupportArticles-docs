---
title: Microsoft Management Reporter 2012 Cumulative Update 10 (CU10) is available
description: Lists the fixes of cumulative update 10 for Management Report 2012.
ms.reviewer: theley, gbyer
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# Microsoft Management Reporter 2012 Cumulative Update 10 (CU10) is available

This article lists issues that are fixed in the English version of Microsoft Management Report 2012 Cumulative Update 10 (CU10) 2.1.10001.112. The update has a [prerequisite](#prerequisites). Check out the [list of problems](#fixes-in-the-cumulative-update) fixed in this update. For more information about the installation guide, go to the following Microsoft website:

[Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 3000799

## More information

A supported update rollup for Microsoft Management Reporter is now available.

If you have questions about how to install this rollup, contact Technical Support for Microsoft Dynamics. On to the Microsoft Dynamics Support website, you can [file a new support request](https://mbs2.microsoft.com/support/newstart.aspx).

> [!NOTE]
> When you create a support request, select Financial - Management Reporter 2012 as the Support Topi .

You can also contact Technical Support for Microsoft Dynamics by telephone at (888) 477-7877.

### Prerequisites

Before you install Management Reporter, your system must meet the minimum requirements as listed in the [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916).

New features included with CU10:

- Export TOT formulas from the row to Excel.
- Ability to select what companies to integrate from Microsoft Dynamics GP and whether to include Analytical Accounting data in the company.
- Ability to customize header placement when exporting to Excel.
- Excluding Account Category from generated reports.
- Data mart integration performance improvements.

### Fixes in the cumulative update

The following are some fixes and updates that are included in the English version of Microsoft Management Reporter 2012 CU10.

|ID|Issues|
|---|---|
|415065|Management Reporter is incorrectly validating the version of SQL during data mart configuration|
|793092|Column Justification setting doesn't export to Excel|
|804830|User is not able to generate a report for just the companies they have access to|
|906000|"The operation could not be completed due to a problem in the data provider framework" error occurs when opening a report definition if a company does not contain a current year|
|938671|Using XCR in the column, Rounding Adjustment in the row, and rounding in the report definition results in incorrect rounding adjustment and sign|
|1066769|Configuration of Dynamics AX 2012 Data Mart Next button may not work when multiple integrations are running on the same Dynamics AX database|
|1231438|Query improvements for long running reports while the DDM integration is running|
|1493892|Management Reporter is unable to integrate with AX 2012 CU4 and AX 2012 R2 CU1|
|1510145|Totaling account updates are not reflected in designer|
|1551909|Missing Account Analysis timeout in GetUsedDimensions (`[dbo].[fnGetUsedDimensionsForCompany]`)|
|1564518|Performance improvements to the user integration|
|1574869|Poor performance of the UpdateBalancesForExchangeRate stored procedure if there are a very large number of currencies and exchange rates|
|1587161|Duplicate amounts when same dimension is used in row and tree|
|1602459|CBR calculation shows zero at account level when using rounding in the report definition|
|1603128|Invalid Period warning with consolidated report for Dynamics GP companies with a short fiscal year|
|1603137|Confirmed budget encumbrance reporting incorrect amounts|
|1603192|Add transaction description as an attribute for SL data mart|
|1618848|AX 2012 GL Adapter SQL timeout on ReadDeletedObjectKeys during Fact integration|
|1618873|Incorrect syntax near ')' when generating a report using a custom posting layer if no transactions exist for the company|
|1618874|Report Designer crashes in Dimensions Window when 201+ dimensions lines exist|
|1620372|Transaction Detail Descriptions showing for NP Column|
|1623574|Case difference in Dynamics AX AOS server integration configuration causes UNIQUE KEY constraint 'UC_ControlFolderIntegration_Name_SourceID' error on Hierarchies task|
|1624065|Dynamics AX DM - Base period list does not originate from the Base year shown when Report Definition is opened (first year's periods shown)|
|1631811|Slow performance of general ledger transactions to fact when querying the count() on BUDGETPLANchanges|
|1634910|Side by side company report returns no data for non-default company|
|1636205|More than 32,768 units in a Tree causes "The INSERT statement conflicted with the CHECK constraint "CK_ReportUnit_Index" error message.|
|1636223|Rounding of Thousands or greater returns incorrect data (decimal place issue) on a CALC column at the Account Detail Level|
|1636231|NP on DESC column causes error in Web Viewer|
|1647838|"Dynamics cannot show the selected item" error in Web Viewer when using the Open in Microsoft Dynamics/Drill to Dynamics feature for an encumbrance column with Dynamics AX 2012|
|1676670|Short Fiscal Year with Calc Column returning "An unknown error has occurred while processing report"|
|1676671|Dynamics AX DDM Performance issue after a Master Planning run which updates InventTable records|
|1681960|Adding a specific dimension to row definition with CU9 causes invalid report data|
|1683020|Fiscal Years task errors on LoadMatchingFiscalYears with "An item with the same key has already been added"|
|1687237|Integration select queries locking/blocking Dynamics GP transactions|
|1687286|Calculation/Total in row will be incorrect when it pulls from two other calculations/totals below it and tree is being used|
|1689169|Invalid data from Dynamics GP causes duplicate key exception in fiscal year provider|
|1693183|Missing transaction drill down details when using Dimension Filter in column|
|1693194|Range of account on Row not returning expected data with Management Reporter Data Mart|
|1693894|Cannot drag and drop report to a different folder in the Report Viewer with CU9|
|1697236|Moving MR database to different server causes Decrypt error to occur multiple times every minute|
|1697784|Blank dimension is ignored when included in a range with Management Reporter Data Mart|
|1699179|Ampersands are removed on export to Excel from report header|
|1700625|Dynamics GP DDM - update AA_FindYEC_RetainedEarnings data validation script|
|1702733|Adding DR and CR Print Control to Row Definition using XBRL Taxonomy returns error and crashes|
|1707325|GP Data Validation runs successfully reporting no errors while data issue exists|
|1709158|GP Data Validation AA_FindUnmatchedDists(17) flags bad records when no data issues exist|
|1709176|Exchange rate table that is setup in GP that has rates without an expiration date will not be used to translate balances|
|1713216|Changes in report performance from RU5 to CU9|
|1714931|Dynamics GP Bug 69692 causes incorrect data in Management Reporter when reporting on AA budgets|
|1715493|Users who are not Management Reporter administrators aren't clearly warned by task "You don't have permission to access companies in Management Reporter"|
|1716469|GP Data Validation - Remove Dynamics GP 9 validation scripts|
|1716470|GP Data Validation - Add French localization in AA_FindUnmatchedDists scripts|
|1716510|GP Data Validation - Update AA_FindUnmatchedDists description|
|26370|DDM must be re-created when a new company is added with Dynamics SL|
|30776|Period 13 missing data if period 12 and 13 share the same date with Dynamics SL|
|31870|Integration performance issue with a large number of companies with Dynamics SL|
|31976|Transaction description attribute missing with Dynamics SL|
