---
title: Error when you run a Fixed Assets integration in Integration Manager for Microsoft Dynamics GP
description: Describes a problem that occurs when you run a Fixed Assets integration in Integration Manager for Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/19/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "If Special Depreciation Allowance (SPECDEPRALLOW) is false, the Special Depreciation Allowance Percentage (SPECDEPRALLOWPCT) must be 0" error when running a Fixed Assets integration in Integration Manager for Microsoft Dynamics GP

This article provides a resolution for an issue that occurs when you run a Fixed Assets integration.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 973567

## Symptoms

When you run a Fixed Assets integration in Integration Manager for Microsoft Dynamics GP, you receive the following error message:

> If Special Depreciation Allowance (SPECDEPRALLOW) is false, the Special Depreciation Allowance Percentage (SPECDEPRALLOWPCT) must be 0.

## Cause

This problem occurs because the **Special Depreciation Allowance** field and the **Special Depreciation Allowance Percent** field aren't mapped.

## Resolution 1: Create a book class in Fixed Assets in Microsoft Dynamics GP

1. Open Microsoft Dynamics GP.
2. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Fixed Assets**, and then select **Book Class**.

## Resolution 2: Map the "Special Depreciation Allowance" and "Special Depreciation Allowance Percentage" fields

1. Open Integration Manager.
2. Open the Fixed Assets integration that you run.
3. On the menu bar, select **Destination Mapping**.
4. Select the **Book** folder.
5. Map the **Special Depreciation Allowance** and **Special Depreciation Allowance Percentage** fields in the **Book** folder in Integration Manager by using the book source that you use.
