---
title: Fail to perform an in-place upgrade
description: Describes behavior that occurs when you receive a "Windows could not parse or process the unattend answer file for pass [specialize]" error message when you perform an in-place upgrade. This behavior occurs on computers that are running Windows 7 or Windows Server 2008 R2.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, yuakib
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# "Windows could not parse or process the unattend answer file for pass [specialize]" error message when you perform an in-place upgrade

This article provides help to fix an error (Windows could not parse or process the unattend answer file for pass [specialize]) that occurs when you perform an in-place upgrade.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2425962

## Symptoms

Consider the following scenario:

- You are running a version of Windows 7 or of Windows Server 2008 R2 that was installed by using an Unattend.xml file.
- You start the computer from this image, and then you select the **Repair in-place upgrade (overwrite installation)** option.
- You start the in-place upgrade.

In this scenario, you receive the following error message: Windows could not parse or process the unattend answer file for pass [specialize].

Generally, the Unattend.xml files are used for OEM or corporate environment deployment. Therefore, the image could contain an Unattend.xml file, and you may not be aware that this file is included.

## Cause

This problem occurs because the Unattend.xml file is applied during the in-place upgrade. This scenario is not supported.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

When this behavior occurs, you cannot recover the system. Therefore, you must perform a clean installation.

To avoid this behavior, you can remove a registry subkey before you use the OEM installation image to run an in-place upgrade. To do this, follow these steps:

1. Log on to the computer by using a user account that has administrative permissions.
2. Click **Start**, type **regedit** in the **Start search** box, and then in the **Programs** list, click **regedit.exe**.
3. Locate and then right-click the following registry subkey: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\UnattendBackup\ActiveSetup\FavoritesList\Favorite\<XX>**  
    > [!NOTE]
    >  In this subkey, \<**XX**> is a placeholder for numbers that begin with 1.
4. Click **Delete**, click **Yes**, and then exit Registry Editor.

## Status

This behavior is by design.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
