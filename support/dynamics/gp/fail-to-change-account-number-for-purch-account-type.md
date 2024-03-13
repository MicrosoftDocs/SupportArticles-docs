---
title: Error when you change account number for PURCH account type in the Purchasing Distribution Entry window
description: Describes a problem where you receive an error message (You cannot change the PURCH account at the summary level) when you try to change the account number for the PURCH account type. A resolution is provided.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you try to change the account number for the PURCH account type in the Purchasing Distribution Entry window in Microsoft Dynamics GP: "You cannot change the PURCH account at the summary level"

This article provides a solution to an error that occurs when you change the account number for the PURCH account type in the **Purchasing Distribution Entry** window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952388

## Symptoms

When you try to change the account number for the **PURCH** account type in the **Purchasing Distribution Entry** window in Microsoft Dynamics GP, you receive the following error message:

> You cannot change the PURCH account at the summary level. Change the inventory account for the line item instead.

This problem occurs in the following versions:

- Microsoft Dynamics GP 2010.
- Microsoft Dynamics GP 10.0 Service Pack 2 and later Microsoft Dynamics GP 10.0 versions
- Microsoft Dynamics GP 9.0 Service Pack 3 and later Microsoft Dynamics GP 9.0 versions.

## Cause

This problem occurs because of a design change made to Microsoft Dynamics GP. The design change was made to help with matching the value in the inventory account in the General Ledger to the value of inventory in the Inventory module. Because of this design change, the modification of the purchasing account at the summary level in the Purchase Order Processing module is not allowed.

## Resolution

To resolve this problem, change the account number at the line item level instead of at the summary level. To do this, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then click **Receivings Transaction Entry**.
2. In the **Receipt No.** list, click the receipt number.
3. In the **Item** area, click the blue arrow next to the **Item** field.
4. In the **Receivings Item Detail Entry** window, edit the inventory account.
5. Click **Yes** when you receive the following message:

    > The document distributions don't match the line item distributions for the PURCH distribution type. Do you want to update distributions for this line item?

6. Click **Save**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
