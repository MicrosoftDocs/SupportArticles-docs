---
title: Unposted data not showing for prior years
description: Describes an issue in which unposted data is not displayed in Management Reporter for prior years.
ms.reviewer: theley, erikjohn, kevogt
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# Unposted data does not show for prior years in Microsoft Management Reporter

This article provides a resolution for the issue that the unposted data is not shown for prior years in Microsoft Management Reporter.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2639564

## Symptoms

When you create a report in Management Reporter, with the legacy provider, unposted data is not displayed for prior years.

## Cause

The prior year in Microsoft Dynamics GP is a historical year.

## Resolution

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** menu, and then select **Tools**. Point to **Setup**, point to **Company** and then select **Fiscal Periods**.
2. Select the year that is not displaying the unposted transactions.
3. Make sure that the year is not set as a historical year.

By design, Management Reporter with the legacy provider will only display unposted transactions for open years. You can successfully report on unposted transactions for a historical year with the data mart provider.
