---
title: Offer updates for Office programs that you do not have installed
description: Describes how Microsoft Update or Windows Update may offer updates to programs that you do not have installed on your computer. We provide steps to resolve this issue.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: v-chasec
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
  - Office 2010
  - Office 2007
  - Office 2003
ms.date: 03/31/2022
---

# Microsoft Update and Windows Update offer updates for Office programs that you do not have installed

## Symptoms

When you visit the Microsoft Update Web site or start Windows Update to scan for updates for the Microsoft Office programs, Microsoft Update or Windows Update may offer updates to programs that you do not have installed on your computer.

For example, you may be offered an update for an Office product even though you do not have the specific Office product installed. 

In addition, you may be offered an Office security update even though the associated security bulletin indicates that the Office products that you do have installed are not affected.

To look for updates for Office, do one of the following: 

- On Windows 7, on Windows Vista or on a Windows Server 2008 client, click **Start**, point to **All Programs** and then click **Windows Update**.   
- On Windows XP or on a Windows Server 2003 client, see [Windows Update: FAQ](https://update.microsoft.com/microsoftupdate/v6/default.aspx).   

## Cause

### Scenario 1

This behavior may occur when you upgrade the Microsoft Office programs from one Office version to another. 

In this scenario, some components may be left on the computer from the earlier version. For example, by default, if you install Microsoft Office 2003 Professional Enterprise, Microsoft InfoPath is installed. 

When you upgrade to Microsoft Office Professional 2007, the earlier version of Microsoft InfoPath may be left on the computer because InfoPath is not upgraded by Office Professional 2007. Additionally, InfoPath is not removed by the upgrade.

Therefore, some Microsoft Office components are left on the computer. When you visit Microsoft Update or Windows Update and scan for updates, the components from the earlier version may be found, and any updates for that version may be offered to you to install.

### Scenario 2

This behavior may occur when updates become available for components that may not be installed. Additionally, this behavior may occur when users choose not to install certain components.

The Microsoft Update or Windows Update detection program checks for installed products. The program makes recommendations for updates for any part of all installed Office products. For example, the English version of Microsoft Office only installs the English language proofing tools unless you have customized your installation.

When you visit Microsoft Update or Windows Update, and then you scan for updates, the update for the French language proofing tool is recommended if there is an update to the French proofing tool. This recommendation is made regardless of whether the French proofing tool is installed.

### Scenario 3

This behavior may occur when you install Microsoft Office products that use shared components.

For example, if you install Project 2007 but not the 2007 Microsoft Office system, you may still be offered an update for the 2007 Microsoft Office system, because Office updates target every product in which a component was included. This maintains consistency for shared files across Office products. For example, depending on the version of Office, the files MSO.DLL and OGL.DLL are shared across Office products. When an update applies to MSO.DLL or OGL.DLL, all Office products with either of these shared components will be offered the update. For security updates, you may have a product indicated in the security bulletin as not affected. However, you will still be offered the update because the product includes the affected shared component.

## Resolution

### Resolution for Scenario 1

To resolve the issue that is described in Scenario 1, remove the earlier Office components that you do not want on your computer. To do this, follow these steps:

1. Exit all Office programs.   
2. Click **Start**, and then click
**Control Panel**.   
3. Click **Add or Remove Programs**.   
4. In the **Currently installed programs** list, click the earlier version of the Office program that you no longer want on the computer, and then click **Remove**.   

### Resolution for Scenario 2 and Scenario 3

To resolve the issue that was described in Scenario 2 and in Scenario 3, use one of the following methods: 

#### Method 1: Install the recommended update

Install the recommended update even if the feature is not being used. 

#### Method 2: Only install the updates that you want

To prevent the update from installing on your computer, click to clear the check box for the update on the Microsoft Update or Windows Update detection results list. Only install the updates that you want. The next time that you visit Microsoft Update or Windows Update, the update that you chose not to install will be recommended again.

> [!NOTE]
> If you apply a security update for a component that is not installed but that is included with your version of the Microsoft Office suite or another Microsoft Office product, there is no adverse effect on the security or performance of the system.
