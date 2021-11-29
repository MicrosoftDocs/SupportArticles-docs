---
title: You don't have security privileges to open this window error when using Payroll Clerk security role
description: Explains how to resolve the security-privileges error that occurs if the Payroll Clerk security role is not set up correctly in Microsoft Dynamics GP 10.0.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "You don't have security privileges to open this window" error when using Payroll Clerk security role to calculate payroll checks

This article provides a workaround for the issue that you can't use  the Payroll Clerk security role to calculate payroll checks in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942007

## Symptoms

When you use the Payroll Clerk security role to calculate payroll checks in Microsoft Dynamics GP, you receive the following error message:

> You don't have security privileges to open this window. Contact your system administrator for assistance.

Specifically, this problem occurs when you select **OK** in the Calculate Checks window.

## Cause

When you assign the Payroll Clerk security role to a user, the Calculate Payroll Taxes window is not included with the **TRX_PAYRL_003*** task ID.

## Workaround

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To work around this problem, follow these steps:

1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then select **Security Tasks**.
2. In the **Task ID** list, select **TRX_PAYRL_003***.
3. In the **Product** list, select **Microsoft Dynamics GP**.
4. In the **Type** list, select **Windows**.
5. In the **Series** list, select **System**.
6. Select the **Payroll Calculate Taxes** check box.
7. Select **Save**.
