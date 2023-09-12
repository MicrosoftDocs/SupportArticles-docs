---
title: WinStoreUI.admx conflict with Windows 10 ADMX file
description: Discusses a WinStoreUI.admx conflict that occurs when Central Store is updated by using Windows 10 Version 1511 ADMX files. This problem is fixed in Windows 10 Version1511.
ms.date: 12/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.technology: windows-server-group-policy
---
# WinStoreUI.admx conflict when Central Store is updated with Windows 10 Version 1511 ADMX files

This article provides help to solve a WinStoreUI.admx conflict that occurs when Central Store is updated by using Windows 10 Version 1511 ADMX files.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3190327

## Symptoms

The WinStoreUI.admx file is available in Windows Server 2012 R2 but is not included in the initial release of Windows 10. However, after you update the Central Store by using the .admx files from Windows 10 Version 1511, the following error is displayed as soon as you start editing a Group Policy object (GPO):

> Namespace 'Microsoft.Policies.WindowsStore' is already defined as the target namespace for another file in the store.

:::image type="content" source="media\winstoreui-conflict-with-windows-10-1151-admx-file/error-message-edit-gpo.png" alt-text="Screenshot of the Administrative Templates window which shows the error message.":::

Comparing the .admx files of Windows Server 2012 R2 and Windows 10 Version 1511 shows that WindowsStore.admx contains the same information as WinStoreUI.admx, plus a few additional policy settings. After you delete WinStoreUI.admx, this error no longer occurs. However, the Resultant Set of Policies on a 2012 R2-based computer contains the following error:

:::image type="content" source="media\winstoreui-conflict-with-windows-10-1151-admx-file/error-message-resultant-set-policies.png" alt-text="Screenshot of the error message which is An error has occurred while collecting data for Administrative Templates.":::

An error has occurred while collecting data for Administrative Templates. The following errors were encountered

> An appropriate resource file could not be found for \\\\\<domain>\sysvol\\<domain.dns>policies\PolicyDefinitions\WinStoreUI.admx\(error = 2): The system cannot find the file specified.

## Cause

In Windows 10 Version 1507, the Store .admx file was removed. A fix restored the .admx file. However, this file now has a new name. After Version 1511 is installed, when customers update their Central Store, they now have two .admx files that have identical settings. Because this is not allowed, the error that's described in the "Symptoms" section occurs.

The .admx files are the following:

- Original Store Group Policy file name: winstoreui.admx
- New Store Group Policy file name: windowsstore.admx

## Resolution

This problem is fixed in Windows 10 Version 1511 and by the most recent cumulative update. Affected customers should upgrade to that release if possible. To prevent the error from occurring when you open Gpedit.msc and when you run Gpresult.exe, follow these steps:  

1. Verify that you have both winstoreui.admx and windowsstore.admx in the Central Store.
2. Delete the winstoreui.admx and winstoreui.adml files from the Central Store.
3. Verify that both opening Gpedit.msc and running Gpresults.exe work without error.
