---
title: Purchase Order Processing setup is missing
description: Provides a solution to an error that occurs when you try to open the Purchase Order Entry window in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Purchase Order Processing setup information is missing or damaged" Error message when you try to open the Purchase Order Entry window in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to open the Purchase Order Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916687

## Symptoms

When you try to open a purchase order entry window in Microsoft Dynamics GP, you receive the following error message:
> Purchase Order Processing setup information is missing or damaged.

## Cause

This problem occurs because Microsoft Dynamics GP integrates purchase order transactions from Project Accounting into Purchase Order Processing in Microsoft Dynamics GP.

## Resolution

To resolve this problem, use the following steps:

### Method 1: Check the setup/security

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, point to **Security**, and then select **Alternate/Modified Forms and Reports**.
2. In the **ID** box, type the user ID.
3. In the **Product** list, select **Project Accounting**. (If it isn't in the list, then go to Method 2.)
4. In the **Type** list, select **Windows**.
5. Expand the **Purchasing** folder.
6. Expand the **Purchase Order Processing Setup** folder.
7. Select **Project Accounting**.
8. Select **Save**.
9. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.
10. Select **Project**.
11. Make the appropriate selections.
12. Select **OK**.

### Method 2: Check the registration

1. Select **Tools** under Microsoft Dynamics GP, point to **Setup** , point to **Company** and select **Registration**.

2. Scroll down and see if Project Accounting is listed (which means it's in your registration keys). If the checkbox is marked, which is why it's looking to Project Accounting for the POP window, even if you don't have Project Accounting installed. If you aren't using Project Accounting or don't wish to install it, the checkbox should be unmarked.
