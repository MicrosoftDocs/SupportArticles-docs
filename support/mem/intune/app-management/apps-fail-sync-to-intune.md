---
title: Microsoft Store for Business apps don't sync to Intune
description: Discusses an issue in which applications don't synchronize from Microsoft Store for Business to Intune. Provides a workaround.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Work with volume-purchased apps and books
ms.reviewer: kaushika, intunecic, waluja
---
# Apps don't synchronize from Microsoft Store for Business to Intune

This article discusses an issue in which applications don't synchronize from Microsoft Store for Business to Microsoft Intune.

## Symptoms

Microsoft Store for Business apps that are volume-purchased do not synchronize and do not appear in the Microsoft Intune portal.

## Cause

This issue occurs if the apps use the encrypted app package format (EAppxBundle). Apps that have encrypted app packages are currently not supported and do not synchronize to Intune.

## Solution

To work around this issue, distribute these apps by using your private store instead. For more information, see [Distribute apps using your private store](/microsoft-store/distribute-apps-from-your-private-store).
