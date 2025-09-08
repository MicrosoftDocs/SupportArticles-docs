---
title: You are not allowed to print Purchase Orders error when you print purchase orders in Microsoft Dynamics GP 9.0 
description: Describes an error that occurs when you try to print purchase orders in Microsoft Dynamics GP 9.0.
ms.reviewer: theley, lmuelle, krasmuss
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# "You are not allowed to print Purchase Orders" error when you try to print purchase orders in Microsoft Dynamics GP 9.0

This article describes an issue where you can't print purchase orders in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921628

## Symptoms

When you try to print purchase orders in Microsoft Dynamics GP 9.0, you receive the following error message:
> You are not allowed to print Purchase Orders.

You may receive this error message in the following windows:

- Purchase Order Entry
- Print Purchasing Documents

This problem also occurs in Microsoft Business Solutions - Great Plains 8.0 and in Microsoft Business Solutions - Great Plains 7.5. In these versions, you may receive this error message in the following windows:

- PA Purchase Order Entry
- PA Print Purchasing Documents

## Cause

This problem may occur if Project Accounting in Microsoft Dynamics GP is installed. However, permission to print purchase orders isn't granted.

## Resolution

To resolve this problem, follow these steps:

1. On the **Tools** menu, point to **Setup** > **Project**, and then click **User**.
1. In the User Project Accounting Settings window, enter your user ID in the **User ID** box, and then click **Purchase Order**.
1. Click to select the **Allow PO Printing** check box, and then click **OK**.
