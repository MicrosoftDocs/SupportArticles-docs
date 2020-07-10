---
title: Microsoft Store for Business apps don't sync to Intune
description: Discusses an issue in which applications don't synchronize from Microsoft Store for Business to Intune. Provides a workaround.
ms.date: 05/18/2020
ms.prod-support-area-path: Work with volume-purchased apps and books
ms.reviewer: intunecic, waluja
---
# Applications don't synchronize from Microsoft Store for Business to Intune

This article discusses an issue in which applications don't synchronize from Microsoft Store for Business to Microsoft Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4492340

## Symptoms

Microsoft Store for Business applications that are volume-purchased do not synchronize and do not appear in the Microsoft Intune portal.

## Cause

This issue occurs if the applications use the encrypted application package format (EAppxBundle). Applications that have encrypted application packages are currently not supported and do not synchronize to Intune.

## Workaround

To work around this issue, distribute these applications by using your private store instead. For more information, see [Distribute apps using your private store](/microsoft-store/distribute-apps-from-your-private-store).
