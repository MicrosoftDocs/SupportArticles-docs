---
title: Open layer exists in purchase receipts table where valuation method not stamped error
description: You may receive an error message that states open layer exists in purchase receipts table where valuation method not stamped when you run the HITB reset tool in Microsoft Dynamics GP.
ms.reviewer: ppeterso, Beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Open layer exists in purchase receipts table where valuation method not stamped" error when you run HITB reset tool

This article provides a resolution for the error **Open layer exists in purchase receipts table where valuation method not stamped** that may occur when you run the Historical Inventory Trial Balance (HITB) IV Reset Tool in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2511801

## Symptoms

When you run Step 2: Perform Data Integrity Checks of the Historical Inventory Trial Balance (HITB) IV Reset Tool in Microsoft Dynamics GP, you receive the following error message on the IV HITB Reset Tool Validation Report:

> Open layer exists in purchase receipts table where valuation method not stamped.

## Cause

You will receive this error message when one or more receipt layers in your Inventory Purchase Receipts (IV10200) table is not sold (RCPTSOLD value = 0) and the valuation method column (VCTNMTHD) is 0 or blank.

This is a normal situation for data to be in when it has been updated from a version of Microsoft Dynamics GP that is before 9.0.

## Resolution

The HITB Reset tool will automatically resolve this error as long as all other errors on the IV HITB Reset Tool Validation Report are corrected. You will want to first correct any other errors that appear on the report, and then select the **Run Data Check** button again. As long as all other errors are resolved, the reset tool will resolve this one for you.

> [!NOTE]
> If the IV HITB Reset tool does not resolve the error, then verify the following:

1. Items where the valuation method is not set in Item Maintenance will not be automatically fixed. Use this script to find those items.

    ```sql
    select VCTNMTHD, * from IV00101 where VCTNMTHD not in (1, 2, 3, 4, 5) and ITEMTYPE <3
    ```

    If the script returns results, then you will need to determine the correct valuation method and update the IV00101 table with it. The values are the following:

    1 - FIFO Perpetual  
    2 - LIFO Perpetual  
    3 - Average Perpetual  
    4 - FIFO Periodic  
    5 - LIFO Periodic

2. Items that do not exist in Item Maintenance but have records in the Purchase Receipts (IV10200) table will not be automatically fixed. Since the items do not exist in the Item Master table (IV00101), the records in the IV10200 can be removed using a delete script.

## More information

Under no circumstances should an update statement be run in SQL to populate the `VCTNMTHD` field in the IV10200 to correct this error.  While doing so will resolve the error message, it will cause future data damage since the receipt sequence number (RCTSEQNM) on these receipts is likely duplicated in the IV10200 table.
