---
title: PA Returned Item Lookup does not show expected information
description: The PA Returned Item Lookup window does not show the expected information in Microsoft Dynamics GP. Provides resolutions.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# The PA Returned Item Lookup window does not show the expected information in Microsoft Dynamics GP

This article provides resolutions for the issue that the PA Returned Item Lookup window does not show the expected information in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2015599

## Symptoms

When you use the Project Accounting Inventory Transfer window to enter a **Return** transaction, the PA Returned Item Lookup window does not show your original document or the **QTY to Return** field is incorrect in **Microsoft Dynamics GP**.

## Cause

There are several causes for this issue. If the first does not apply, then check the next item on the list. Review the solution that corresponds to the cause you are experiencing.

Cause 1:

An unposted Inventory Transfer transaction exists for the transaction you are currently attempting to return. See Resolution 1.

Cause 2:

The Inventory Transfer transaction has been returned on a previous transaction. See Resolution 2.

Cause 3:

There is an incorrect record in the EEPAIVLN (PA Inventory Transfer Line) table. See Resolution 3.

Cause 4:

There is an incorrect record in the EEPAIVRQ (PA Inventory Returned Quantities) table. See Resolution 4.

## Resolution 1

Review the Inventory Transfer Detail Inquiry window to see if a Return transaction for the project, cost category and item you are currently attempting to return is displayed as unposted. To do this follow these steps:

1. On the tool bar select **Inquiry**, point to **Project**, point to **PA Transaction Documents**, and then select **Inventory Transfer - Detail** to open the Inventory Transfer Detail Inquiry window.
2. In the **Documents** field, select **by Project No.**
3. In the **Filter** field, select by **Cost Category ID.**
4. Leave the **Unposted** radio button marked, and then click Redisplay.

   This will show any unposted transactions for this project and cost category.

5. If return documents are displayed for the same item number you are attempting to return now, then verify if they should be deleted or posted.

## Resolution 2

Review the Inventory Transfer Detail Inquiry window to see if a Return transaction for the project, cost category and item you are currently attempting to return is displayed as already having been returned. To do this follow these steps:

1. On the tool bar select **Inquiry**, point to **Project**, point **to PA Transaction Documents**, and then select **Inventory Transfer - Detail** to open the Inventory Transfer Detail Inquiry window.
2. In the **Documents** field, select **by Project No.**
3. In the **Filter** field, select by **Cost Category ID.**
4. Select the **Posted** radio button, and then select Redisplay.

   This will show any posted transactions for this project and cost category.

5. If return documents are displayed for the same item number you are attempting to return now, then verify if they have already partially or fully returned the original inventory transfer.

## Resolution 3

If the original inventory transfer document has already been returned, then the document that returned it will be in the PA Inventory Transfer Line (EEPAIVLN) table. To review this information, follow these steps:

1. Back up the company database.
2. Open one of the following query tools, depending on the version of Microsoft SQL Server that you are using:
   - SQL Query Analyzer
   - SQL Server Management Studio
   - Support Administrator Console
3. Run the following statement against the company database.

   ```sql
   SELECT * FROM EEPAIVLN WHERE ORIG_DOC_NUMBER = 'XX'
   ```

    > [!NOTE]
    > Replace the XX value with the document number of the original inventory transfer that you are attempting to return against.

4. If results are returned, then review the value of the PAIV_Document_No field to see which document has already returned this Inventory Transfer. This could be a posted, unposted or partially posted and damaged document.

5. If the document number in the PAIV_Document_No field does not exist in the system, then the record should be removed from the EEPAIVLN table since it is a partially posted, damaged record.

## Resolution 4

If the original inventory transfer document has already been returned, then the quantity that has already been returned will be in the PA Inventory Returned Quantities (EEPAIVRQ) table. To review this information, follow these steps:

1. Back up the company database.
2. Open one of the following query tools, depending on the version of Microsoft SQL Server that you are using:

     - SQL Query Analyzer
     - SQL Server Management Studio
     - Support Administrator Console
3. Run the following statement against the company database.

   ```sql
    SELECT * FROM EEPAIVRQ WHERE PAIV_Document_No = 'XX'
   ```

     > [!NOTE]
     > Replace the XX value with the document number of the original inventory transfer that you are attempting to return against.

4. If results are returned, then review the value of the `QTYRTRND` field to see how many quantities have already been returned on this Inventory Transfer. This could be a posted, unposted or partially posted and damaged document.

5. If there were no results from Resolution 1 or 2, then the record should be removed from the EEPAIVRQ table.
