---
title: Warning when you open a Purchase Order Processing window
description: This article provides a resolution for the problem that occurs when you try to open a Purchase Order Processing window in Microsoft Dynamics GP 9.0.
ms.topic: troubleshooting
ms.reviewer: ppeterso
ms.date: 03/13/2024
---
# Warning message when you try to open a Purchase Order Processing window in Microsoft Dynamics GP 9.0 (Please set up this user first)

This article helps you resolve the problem that occurs when you try to open a Purchase Order Processing window in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 916686

## Symptom

When you try to open a Purchase Order Processing window in Microsoft Dynamics GP 9.0, you receive the following warning message:

> Please set up this user first.

## Cause

This problem occurs because Microsoft Dynamics GP 9.0 integrates purchase order transactions from Project Accounting in Microsoft Dynamics GP 9.0 into Purchase Order Processing in Microsoft Dynamics GP 9.0.

## Resolution

To resolve this problem, follow these steps:

1. On the **Tools** menu, point to **Setup**, point to **Project**, and then click **User**.
2. In the **User Project Accounting Settings** dialog box, click a user in the **User ID** list.
3. Click **Purchase Order**, and then click **OK**.
4. Click **Purchasing Invoice**, and then click **OK**.
5. Click **Save**.
6. Repeat steps 2 through 5 for each user.
