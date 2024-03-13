---
title: Error when changing standard cost on an item
description: An error occurs when changing standard cost on an item in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when changing standard cost on an item in Microsoft Dynamics GP

This article provides a resolution for the issue that you can' change the standard cost on an item in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3090317

## Symptoms

Error when changing standard cost on an item in Microsoft Dynamics GP:

> [Microsoft][SQL Native Client][SQL Server]Procedure or function 'mcstDoltemSCST02' expects parameter '@parent_part2', which was not supplied

## Cause

Low level codes are incorrect.

## Resolution

Select **Tools**, point to **Utilities**, point to **Manufacturing** and select MRP Low Level Codes.
