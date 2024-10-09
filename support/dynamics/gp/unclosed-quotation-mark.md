---
title: Unclosed quotation mark
description: Provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management.
ms.reviewer: theley, kenhub, cwaswick
ms.topic: troubleshooting
ms.date: 10/9/2024
ms.custom: sap:Financial - Payables Management
---
# "Unclosed quotation mark after the character string" Error message when running the Historical Aged Trial Balance for Payables Management in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2580792

## Symptoms

When you run the Historical Aged Trial Balance report for Payables Management, you receive one of the following error messages:

Error Message 1 (for Credit memo)

> [Microsoft][ODBC SQL Server Driver][SQL Server]Line 1 : Incorrect syntax near 'XXXXX'.[Microsoft][ODBC SQL Server Driver][SQL Server]Unclosed quotation mark before the character string ' and DocumentType=5'.

Error Message 2 (for Payment)

> [Microsoft][SQL Native Client][SQL Server]incorrect syntax near 'S'[Microsoft][SQL Native Client][SQL Server] Unclosed quotation mark after the character string 'and DocumentType = 6"

It's followed by the following message:

> The stored proc pmHistoricalAgedTrialBalance returned the following results: DBMS: 105, Microsoft Dynamics GP: 0

## Cause

This can happen when a credit memo or manual payment document is entered with an apostrophe in the **Voucher Number** field.

## Resolution

With the release of [Microsoft Dynamics GP 18.7](https://community.dynamics.com/blogs/post/?postid=da2b849a-e349-ef11-a317-6045bda6fe6a), you will now be able to print the HATB when the voucher number or payment number is posted with special characters.  If you are encountering this error message, you should upgrade.

If you are on an older version of Microsoft Dynamics GP you can review the below.

1. Run this script in SQL against the company database to look for any voucher number, document numbers or vendor ID's with a single apostrophe in it, which is read as an unclosed quotation by the process. Any results for the voucher number (CONTRLNUM) are likely the clause, but the document number and vendor ID are also added to the script, and may or may not be an issue:

    ```sql
    SELECT * FROM PM00400
    WHERE 
    CNTRLNUM LIKE '%''%' or 
    DOCNUMBR LIKE '%''%' or 
    VENDORID LIKE '%''%' 
    ```

2. For any results returned by the script above, run the 'ALL Payables' script for each result returned above. (As the problem is more than likely a voucher number as that is an editable field to the user. Check your payables setup to make sure you don't have an apostrophe in the default next voucher number.)

3. Manually fix the Voucher number with a direct 'update' statement in SQL for all the tables returned by the 'ALL Payables' script to remove the single apostrophe from a voucher number and Document number Be sure to write the field to be the exact same in all fields/tables where you change it. (If the issue is with the vendor ID, then don't use these steps. You can use the vendor modifier tool in PSTL to change a vendor ID.)


## More information

To prevent this issue from happening in the future, you can lock the **Voucher Number** field to prevent users from modifying the voucher number. To do it, following these steps:

1. Select Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Purchasing** > **Payables**.

2. Unmark the **Override Voucher Number at Transaction Entry** option, and then select **OK**.
