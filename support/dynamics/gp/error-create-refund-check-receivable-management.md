---
title: Error when you create a refund check
description: This article provides a resolution for the problem that occurs when you try to create a refund check in Receivables Management in Microsoft Dynamics GP 9.0.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to create a refund check in Receivables Management in Microsoft Dynamics GP 9.0 (The refund checks setup information is missing or damaged)

This article helps you resolve the problem that occurs when you try to create a refund check in Receivables Management in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933934

## Symptoms

When you try to create a refund check in Receivables Management in Microsoft Dynamics GP 9.0, you receive the following error message:

> The refund checks setup information is missing or damaged.

## Cause

This problem occurs if the Refund Checks feature is not set up correctly.

## Resolution

To resolve this problem, follow these steps:

1. Log on to Microsoft Dynamics GP 9.0.
2. On the **Tools** menu, point to **Setup**, point to **Sales**, and then click **Refund Checks**.
3. In the Refund Checks Setup window, click the lookup button next to the **Default Suspense Account** field.
4. In the Accounts window, click an account, and then click **Select**.
5. In the **Next Voucher Document Number** box, enter a number.
6. If the **Auto-create Vendors from Customers** check box is selected, click the lookup button next to the **Default Vendor Class ID** field, click a class identifier, and then click **Select**.
7. Click **OK**.
