---
title: Unclosed quotation mark error when running Historical Aged Trial Balance
description: Provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management.
ms.reviewer: theley, kenhub, cwaswick
ms.topic: troubleshooting
ms.date: 10/14/2024
ms.custom: sap:Financial - Payables Management
---
# "Unclosed quotation mark" error when running the Historical Aged Trial Balance for Payables Management

This article provides a solution to an error that occurs when you run the Historical Aged Trial Balance report for Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2580792

## Symptoms

When you run the Historical Aged Trial Balance (HATB) report for Payables Management, you receive one of the following error messages:

Error message 1 (for Credit memo):

> [Microsoft][ODBC SQL Server Driver][SQL Server]Line 1 : Incorrect syntax near 'XXXXX'.[Microsoft][ODBC SQL Server Driver][SQL Server]Unclosed quotation mark before the character string ' and DocumentType=5'.

Error message 2 (for Payment):

> [Microsoft][SQL Native Client][SQL Server]incorrect syntax near 'S'[Microsoft][SQL Native Client][SQL Server] Unclosed quotation mark after the character string ' and DocumentType = 6"

It's followed by the following message:

> The stored proc pmHistoricalAgedTrialBalance returned the following results: DBMS: 105, Microsoft Dynamics GP: 0

## Cause

This issue occurs when a credit memo or manual payment document is entered with an apostrophe in the **Voucher Number** field.

## Resolution

 If the voucher number or payment number is posted with special characters, to print the HATB report successfully, you can upgrade to [Microsoft Dynamics GP 18.7](https://community.dynamics.com/blogs/post/?postid=da2b849a-e349-ef11-a317-6045bda6fe6a).

If you use an ealier version of Microsoft Dynamics GP, you can follow these steps:

1. Run the following script in SQL against the company database to look for any voucher number, document number or vendor ID with a single apostrophe in it, which is read as an unclosed quotation by the process. Any results for the voucher number (`CONTRLNUM`) are likely the clause, but the document number and vendor ID are also added to the script, and might or might not be an issue.

    ```sql
    SELECT * FROM PM00400
    WHERE 
    CNTRLNUM LIKE '%''%' or 
    DOCNUMBR LIKE '%''%' or 
    VENDORID LIKE '%''%' 
    ```

   > [!NOTE]
   > If the issue is with the vendor ID, then don't follow these steps. You can use the vendor modifier tool in the [Professional Services Tools Library](/dynamics-gp/installation/profservicestoolslibrary) to change a vendor ID.

2. Run the _ALL Payables_ script for each result returned by the preceding script. (The problem is most likely with the voucher number because that's an editable field for the user. Check your payables setup to make sure you don't have an apostrophe in the default next voucher number.)

3. Manually fix the voucher number with a direct `update` statement in SQL for all the tables returned by the _ALL Payables_ script to remove the single apostrophe from a voucher number and document number. Be sure to write the field to be the exact same in all fields or tables where you change it.

## More information

To prevent this issue from occurring in the future, you can lock the **Voucher Number** field to prevent users from modifying the voucher number. To do it, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Setup** > **Purchasing** > **Payables**.

2. Clear the **Override Voucher Number at Transaction Entry** checkbox, and then select **OK**.
