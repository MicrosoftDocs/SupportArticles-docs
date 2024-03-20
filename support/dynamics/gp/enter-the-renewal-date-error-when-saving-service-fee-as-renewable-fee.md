---
title: Please enter the renewal date error when saving a service fee as a renewable fee 
description: Describes a problem where you receive the error - Please enter the renewal date when saving a service fee as a renewable fee in the Fee Maintenance window in Project Accounting. Provides a resolution.
ms.reviewer: theley, ansather, beckyber
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Project Accounting
---
# "Please enter the renewal date" error when saving a service fee as a renewable fee in the Fee Maintenance window in Project Accounting

This article provides a resolution for **Please enter the renewal date** error that occurs when saving a service fee as a renewable fee in the Fee Maintenance window in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952228

## Symptoms

When you save a service fee as a renewable fee in the Fee Maintenance window in Project Accounting in Microsoft Dynamics GP, you receive this error message:

> Please enter the renewal date.

## Resolution

To resolve this problem, make sure that the **Renewable** check box isn't selected in the Fee Maintenance window. Instead, select the **Renewable** check box for the fee in the Fee Details window. To enable the **Renewable** check box, follow these steps:

1. On the **Cards** menu, point to **Project**, and then select **Project**.
2. In the **Project No.** list, select a project.
3. Select **Fees**.
4. Select the fee, and then select the blue arrow next to the **Fee ID** field.
5. In the **Begin Date** field, type the appropriate date.
6. Select the **Renewable** check box, and then select **Save**.
