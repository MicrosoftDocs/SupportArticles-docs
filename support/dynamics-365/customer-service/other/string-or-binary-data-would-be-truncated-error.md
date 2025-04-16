---
title: String Or Binary Data Would Be Truncated Error
description: Solves an issue where you can't delete records from a custom table in Microsoft Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ms.reviewer: courtser
ai-usage: ai-assisted
ms.date: 04/16/2025
ms.custom: sap:Other, DFM
---
# "String or binary data would be truncated" error when deleting records from a custom table

This article provides guidance on resolving an error that occurs when you try to delete records from a custom table in Dynamics 365 Customer Service.

## Symptoms

When you try to delete records from a [custom table](/power-apps/maker/data-platform/create-custom-entity), you receive the following error message:

> String or binary data would be truncated.

The error message usually specifies the table and [column](/power-apps/maker/data-platform/types-of-fields) that cause the truncation error.

## Cause

The issue occurs because the data in one or more columns exceeds the maximum allowed character limit for those columns. Specifically, the data length in the affected column(s) is larger than the defined maximum character count.

## Resolution

To resolve this issue, follow these steps:

1. [Select your environment in Power Apps](/power-apps/maker/canvas-apps/sign-in-to-power-apps#choose-an-environment).
2. In the left navigation, select **Tables**, and then select the table where the error occurs.
3. Select **Columns**, and locate the problematic column.
4. Expand **Advanced options** for the selected column.

   > [!TIP]
   > You also can find the **Advanced options** in the [table designer](/power-apps/maker/data-platform/create-edit-entities-portal?tabs=excel#table-designer).

5. Increase the **Maximum character count** to accommodate the data length.
6. Save and publish the changes.
7. After updating the maximum character count, proceed to delete the records again.

If increasing the maximum character count doesn't solve the issue, you can try truncating the data in the column before deleting the records.
