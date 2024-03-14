---
title: Error when you enter a non-inventoried item in Field Service
description: This article provides a resolution for the problem that occurs when you try to enter a non-inventoried item on a Field Service transaction in Microsoft Dynamics GP 2010.
ms.topic: troubleshooting
ms.reviewer: theley, Beckyber
ms.date: 03/13/2024
ms.custom: sap:Field Service Series
---
# Error message when you enter a non-inventoried item in Field Service in Microsoft Dynamics GP 2010 (Item's master record does not exist)

This article helps you resolve the problem that occurs when you try to enter a non-inventoried item on a Field Service transaction in Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2490222

## Symptoms

When you try to enter a non-inventoried item on a Field Service transaction in Microsoft Dynamics GP 2010, you receive the following message:

> Item's master record does not exist.

This behavior occurs even though Microsoft Dynamics GP 2010 allows the use of non-inventoried items

## Cause

This problem occurs when the option to allow non-inventoried items has not been marked.

## Resolution

In order to enter non-inventoried transactions in Field Service in Microsoft Dynamics GP 2010, you must mark the option to allow non-inventory items. To do this, follow these steps:

1. On the Microsoft Dynamics GP menu, point to **Tools**, point to **Setup**, point to **Project**, and then click **Service Setup**.

2. In the **Service Setup** window, find the **Options** section.

3. Click to select the **Allow Non-Inventoried Items** checkbox.
