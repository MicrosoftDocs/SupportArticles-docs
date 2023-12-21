---
title: Wrong values in Amounts Since Last Closed
description: Provides a solution to an issue where the Amounts Since Last Close view for Customer or Vendor Summary Inquiry show incorrect Year-to-Date or Last Year values.
ms.reviewer: theley 
ms.topic: troubleshooting
ms.date: 12/21/2023
---
# Amounts Since Last Closed view in Customer or Vendor Summary reflects incorrect close date in Microsoft Dynamics GP

This article provides a solution to an issue where the Amounts Since Last Close view for Customer or Vendor Summary Inquiry show incorrect Year-to-Date or Last Year values.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3193375

## Symptoms

The Amounts Since Last Close view for Customer or Vendor Summary Inquiry show incorrect Year-to-Date or Last Year values.

- The Payables Management year is closed at an incorrect date.
- The Receivables Management year is closed at an incorrect date.
- The YTD and LYR values for Payables Management Vendors doesn't reflect the correct amount.
- The YTD and LYR values for Receivables Management Customers doesn't reflect the correct amount.

## Cause

The Year End Close process for Receivables Management and Payables Management isn't date specific to transactions. Which means that transactions up to the date the close process is done are considered Last Year (LYR) and the transactions entered after the close are considered Year to Date (YTD). The date of the transaction isn't a consideration.

For example, if you do the close process in Receivables Management or Payables Management at the end of February, the transactions in January and February will also be moved to 'last year' for the "Amounts Since Last Close' view in the Customer or Vendor Summary window.

## Resolution

It can be resolved through a SQL scripting solution. Below are the steps for this resolution:

Make a current backup of your company database, and do these steps in a Test company first to verify it works the way you expect.

PAYABLES MANAGEMENT:

1. Download the [PMCALC.zip](https://mbs2.microsoft.com/fileexchange/?fileID=9273a3c9-dad4-4128-b4be-d5dbd3413d2f) that contains scripts for Payables Management:

2. Go to the location you saved the zip file and extract the five SQL statements in it.

3. In SQL Server Management Studio, execute these SQL statements (from the PMCALC.zip file) against the company database:

4. Open the LAST YEAR PM Recalc.sql script and copy it in to a query window. Edit the dates as needed for Last Year and execute it against the company database. For instance, if your last closed year was 2023 and the dates were 01/01/2023 through 12/31/2023, then edit this script to look as follows:

    `exec smPMSummaryNOINVYTDLYR '01/01/2023', '12/31/2023'`

5. Open the THIS YEAR PM Recalc.sql script and copy it into a query window. Edit the dates as needed for the current year and execute it against the company database. For instance, if your current open year is 2024 and the dates are 01/01/2024 through 12/31/2024, then edit to this script to look as follows:

    `exec smPMSummaryNOINVYTD '01/01/2024', '12/31/2024'`

6. Review your YTD and LYR values in your company for accuracy.

RECEIVABLES MANAGEMENT:

1. Download the [RMRECALC.zip](https://mbs2.microsoft.com/fileexchange/?fileID=c9d45418-1de2-4968-a8c5-af6119ed50bf) that contains scripts for Receivables Management:

2. Go to the location you saved the zip file and extract the five SQL statements in it.

3. In SQL Server Management Studio, execute the following statements (from the RMRECALC.zip file) against the company database:

4. Open the LAST YEAR RM Recalc.sql script and copy it in to a query window. Edit the dates as needed for Last Year and execute it against the company database. For instance, if your last closed year was 2023 and the dates were 01/01/2023 through 12/31/2023, then edit this script to look as follows:

    `exec smRMSummaryLYR '01/01/2023', '12/31/2023'`

5. Open the THIS YEAR RM Recalc.sql script and copy it in to a query window. Edit the dates as needed for the current year and execute it against the company database. For instance, if your current open year is 2016 and the dates are 01/01/2024 through 12/31/2024, then edit this script to look as follows:

    `exec smRMSummary '01/01/2024', '12/31/2024'`

6. Review your YTD and LYR values in your company for accuracy.
