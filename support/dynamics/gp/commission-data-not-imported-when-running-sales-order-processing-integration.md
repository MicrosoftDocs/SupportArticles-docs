---
title: Commission data not importing when running integration
description: When you map sales commission data in Integration Manager together with Microsoft Dynamics GP or Microsoft Great Plains 8.0, the data is not imported into the program. A service pack is now available to resolve this problem.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Commission data does not import when running a Sales Order Processing integration in Integration Manager with Microsoft Dynamics GP or Great Plains

This article provides a resolution for the issue that commission data isn't imported when you run a Sales Order Processing integration in Integration Manager with Microsoft Dynamics GP or Microsoft Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918078

## Symptoms

When you run a Sales Order Processing integration in Integration Manager together with Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0 to map the sales commission data that is in the Commissions mapping folder, the data is not imported into Microsoft Dynamics GP or into Microsoft Great Plains.

## Cause

This problem occurs because the Sales Commission Entry window in Microsoft Dynamics GP and in Microsoft Great Plains recalculates some of the field values.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP.
