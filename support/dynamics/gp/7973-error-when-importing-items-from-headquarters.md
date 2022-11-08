---
title: 7973 The Sales Return Account is Inactive error when importing items from Headquarters
description: Describes that you receive the 7973 - The Sales Return Account is Inactive error message when importing items from Microsoft Dynamics RMS Headquarters into Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "7973 - The Sales Return Account is Inactive" error when importing items from Microsoft Dynamics RMS Headquarters

This article provides a resolution for the **7973 - The Sales Return Account is Inactive** error that may occur when you import items from Microsoft Dynamics RMS Headquarters into Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961579

## Symptoms

When you use the Item Import function to import items from Microsoft Dynamics Retail Management System (RMS) Headquarters into Microsoft Dynamics GP, you receive the following error message:

> 7973 - The Sales Return Account is Inactive

## Cause

This problem occurs if the sales return account in Microsoft Dynamics GP is inactive.

## Resolution

To resolve this problem, follow these steps:

1. In Microsoft Dynamics GP, point to **Financials** on the **Cards** menu, and then select **Accounts**.
2. In the Account Maintenance window, select the lookup button in the **Account** field.
3. Double-click the sales return account.
4. Clear the **Inactive** check box.
5. Select **Save**.
6. Close the Account Maintenance window.
7. On the **Transactions** menu, point to **Retail Management**, and then select **Item Import**.
8. Select an appropriate date range, and then select **Import**.
