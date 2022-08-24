---
title: Error when you run a Fixed Assets integration in Integration Manager 10.0 for Microsoft Dynamics GP 10.0
description: Describes a problem that occurs when you run a Fixed Assets integration in Integration Manager 10.0 for Microsoft Dynamics GP 10.0. A resolution is provided.
ms.reviewer: v-anlang
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error when you run a Fixed Assets integration in Integration Manager 10.0 for Microsoft Dynamics GP 10.0: "If Special Depreciation Allowance (SPECDEPRALLOW) is false, the Special Depreciation Allowance Percentage (SPECDEPRALLOWPCT) must be 0"

This article provides a resolution for an issue that occurs when you run a Fixed Assets integration.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 973567

## Symptoms

When you run a Fixed Assets integration in Integration Manager 10.0 for Microsoft Dynamics GP 10.0, you receive the following error message:
> If Special Depreciation Allowance (SPECDEPRALLOW) is false, the Special Depreciation Allowance Percentage (SPECDEPRALLOWPCT) must be 0.

## Cause

This problem occurs because the **Special Depreciation Allowance** field and the **Special Depreciation Allowance Percent** field aren't mapped.

## Resolution 1: Create a book class in Fixed Assets in Microsoft Dynamics GP 10.0

1. Open Microsoft Dynamics GP 10.0.
2. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Fixed Assets**, and then click **Book Class**.

## Resolution 2: Map the "Special Depreciation Allowance" field and the "Special Depreciation Allowance Percentage" field

1. Open Integration Manager 10.0.
2. Open the Fixed Assets integration that you run.
3. On the menu bar, click **Destination Mapping**.
4. Click the **Book** folder.
5. Map the **Special Depreciation Allowance** field and the **Special Depreciation Allowance Percentage** field in the **Book** folder in Integration Manager by using the book source that you use.
