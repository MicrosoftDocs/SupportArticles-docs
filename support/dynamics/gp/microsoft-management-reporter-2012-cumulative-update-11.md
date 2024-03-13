---
title: Microsoft Management Reporter 2012 Cumulative Update 11 (CU11) is available
description: Lists the fixes of cumulative update 11 for Management Report 2012.
ms.reviewer: gbyer, jopankow
ms.date: 03/13/2024
---
# Microsoft Management Reporter 2012 Cumulative Update 11 (CU11) is available

This article lists issues that are fixed in the English version of Microsoft Management Report 2012 Cumulative Update 11 (CU11) 2.1.11000.32. The update has a [prerequisite](#prerequisites). Check out the [list of problems](#fixes-in-the-cumulative-update) fixed in this update. For more information about the installation guide, go to the following Microsoft website:

[Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916)

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 3028110

## More information

A supported update rollup for Microsoft Management Reporter is now available.

If you have questions about how to install this rollup, contact Technical Support for Microsoft Dynamics. On to the Microsoft Dynamics Support website, you can [file a new support request](https://mbs2.microsoft.com/support/newstart.aspx).

> [!NOTE]
> When you create a support request, select Financial - Management Reporter 2012 as the Support Topic.

You can also contact Technical Support for Microsoft Dynamics by telephone at (888) 477-7877.

### Prerequisites  

Before you install Management Reporter, your system must meet the minimum requirements as listed in the [Management Reporter 2012 for Microsoft Dynamics ERP: Installation, Migration, and Configuration Guides](https://www.microsoft.com/download/details.aspx?id=5916).

New features included with CU11:

- Drill into TOT rows from Web Viewer
- Ability to select closing period in Management Reporter
- Company selection with Microsoft Dynamics GP 2015 and Microsoft Dynamics SL 2011 and 2015
- Improved performance for integration and report generation
- Currency Translation fixes for Microsoft Dynamics GP.

### Fixes in the cumulative update  

|352086|Trying to modify a Dimension Set that contains a blank line causes Management Reporter to close unexpectedly|
|---|---|
|352594|Excluding users from a role in Microsoft Dynamics AX does not remove them from Management Reporter|
|358469|Active Directory groups in Microsoft Dynamics AX are included in the Management Reporter data mart|
|387414|If Account Security is on in Microsoft Dynamics GP and multiple organizational entities are assigned to an account, Management Reporter will pull the value for that time frame multiplied by the number of entities on that account|
|1066276|Report Designer provides access to all accounts for all entities at the same level when account level security is configured in Microsoft Dynamics GP to restrict access|
|1078881|Update format codes, print controls, page options and column restrictions to be friendlier, localizable terms|
|1721610|The Generate to a single report library and link location gets deleted when the Report Group Definition form is opened and saved without making any changes|
|1721895|After a generated report opens in the Report Viewer, clicking the Report Library button shows a blank report list|
|1737774|Removing Indent from a row in the row definition doesn't update font override setting|
|1740092|No periods display when using the P=B print control and hardcoding periods into the column definition|
|1750242|Retained earnings are calculated taking the full opening balance each year times the exchange rate instead of the entry each year times the exchanged resulting in incorrect data. Applies to MR with Dynamics GP only.|
|2195690|Data mart integration fails to recover after being disconnected from SQL Server|
|2715979|Conditional Print Control with period ranges doesn't work the same between Management Reporter 2.0 and Management Reporter 2012|
|2716000|When unit accounts are cleared during year-end-close, the beginning balance is incorrect for Microsoft Dynamics GP data mart|
|2731789|Currency methods aren't consistent in how exchange rate expiration dates are honored|
|2743989|Box border doesn't outline the correct column when using column restrictions and conditional printing|
|2755849|Report Viewer closes unexpectedly when drilling to transaction detail if comments exist at transaction level and the data mart has been rebuilt|
|2808657|Column Restriction (DR/CR) doesn't work when also using a Currency Display and Currency Filter in the same column|
|2810949|Export and include formulas in Excel fail with a dictionary error when the total row references a row that doesn't return data|
|2810950|Export and include formulas in Excel fail with a variableOffsets error when a TOT range start or end are not next to a row that generates data|
|2816177|Report Viewer closed unexpectedly with the following error when trying to print or export to Excel with "Selected reporting units" option selected: "Specified cast is not valid"|
|2855374|Management Reporter 2012 data mart pre-deployment scripts time out after two minutes|
|3003041|If there are more than 2100 versions of a report, an error is displayed in the web viewer and the report is not displayed|
|3006929|When using conflicting attribute filters on row and column definitions, data is returned for both conditions|
|3006986|Transactions entered in a currency other than the functional currency with a zero rate (resulting in no functional amount) aren't integrated correctly into the data mart|
|3127783|Export and include formulas in Excel fail with rows with X0 format codes that don't return data|
|3127823|Error with Fact task "Conversion overflows" / "SqlDateTime overflow. Must be between 1/1/1753 12:00:00 AM and 12/31/9999 11:59:59 PM"|
|3128081|IF statements in row definitions overwrite column calculations when rounding adjustments are used|
|3128878|Unexpected error in the Management Reporter data mart integration when projects are updated in Microsoft Dynamics AX 2012|
|3140307|When validating or submitting an XBRL instance document, the follow error occurs: "An unknown error occurred while validating or submitting the XBRL instance document."|
|3186084|Current Translation Type accounts don't calculate beginning balance correctly if the fiscal years and/or periods aren't added to the data mart in chronological order|
|3190703|With a large number of reports in the Management Reporter data base, the CU10 upgrade causes disk space issues and the upgrade may not complete|
|3190739|Performance issues with adding users and companies to the data mart if a large number of users and companies are in Microsoft Dynamics AX|
|3190767|When upgrading data mart database to CU10 if the data mart database and/or log is larger than 2 GB the following error occurs: "Specified size is less than or equal to current size"|
|3205705|Changing an exchange rate table used for a currency does not correctly update the associated exchange rates in the data mart with Microsoft Dynamics GP|
|3209403|Data mart integration fails when the collation is different between tempdb and the data mart database|
|3213527|Performance issues generating reports|
|3240510|Performance issues and data base growth when dimension combinations are integrated into all companies in a partition|
