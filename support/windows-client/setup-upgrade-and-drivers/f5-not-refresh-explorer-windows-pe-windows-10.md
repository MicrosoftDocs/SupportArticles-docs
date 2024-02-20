---
title: F5 doesn't refresh Explorer in Windows PE of Windows 10
description: Describes how to work around F5 not refreshing file and folder list in Windows 10 Creators Update.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jeffbo
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# F5 doesn't refresh Explorer in Windows PE of Windows 10 Creators Update

This article provides a workaround to the issue in which F5 doesn't refresh Explorer in Windows PE of Windows 10 Creators Update.

_Applies to:_ &nbsp; Windows 10, version 1903, Windows 10, version 1809  
_Original KB number:_ &nbsp; 4033241

## Symptoms

Consider the following scenario:

- You start Windows 10 in Windows Preinstallation Environment (PE) mode.
- You create a folder or rename a folder.
- You press the F5 key.

In this scenario, the folder and file list do not refresh.

## Workaround

To refresh the files, use one of the following methods:

- Click another folder, and then click the previous folder.
- Move the mouse cursor over the folder and file list.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
