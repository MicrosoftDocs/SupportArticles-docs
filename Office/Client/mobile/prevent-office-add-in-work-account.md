---
title: Block use of Office Add-ins for work or school accounts
description: Describes how to prevent iOS users from using Office add-ins for Word, Excel, and PowerPoint when users are signed into their work or school accounts.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: patkling, seanla, sofianeh, jarnold, dysturm
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office app for iOS
ms.date: 05/20/2022
---
# Block use of Office add-ins from work or school accounts

**Note** The information in this article applies to Office add-ins for Word, Excel, and PowerPoint.

## Symptom

Users in your organization use personal iOS devices and their personal or Microsoft account (MSA) to access corporate resources. They can install Office add-ins when they're signed into their MSA.

When users are signed into their work or school account, the installation of Office add-ins is blocked. However, they're still able to use the Office add-ins that have been installed in files that were created by using their MSA.

For example, users sign in to Office apps with their MSA, create a file such as an Excel workbook, install a few Office add-ins in it and use them. Then they save the file to a corporate storage location, such as the organization's OneDrive for Business. In this scenario, when users sign into their work or school account later and reopen the file, they're able to continue using the Office add-ins that are installed in the file.

If account switching is available to users in your organization, this issue also occurs when users switch the active account in Office apps from their MSA to their work or school account.

## Cause

This issue occurs if you've blocked Office add-in installation for work or school accounts by [turning off the Office Store across all clients](/microsoft-365/admin/manage/manage-addins-in-the-admin-center?view=o365-worldwide#prevent-add-in-downloads-by-turning-off-the-office-store-across-all-clients-except-outlook&preserve-view=true). However, this method doesn't prevent the use of Office add-ins in files that users create by using their MSA.

## Resolution

To block the use of Office add-ins, set a preference in the [app configuration policies](/mem/intune/apps/app-configuration-policies-overview#managed-apps) for managed apps. This method can be used for both managed and unmanaged devices.

> [!NOTE]
>
> - Make sure the Office apps (Word, Excel, PowerPoint) are managed by Intune, and are configured with [Intune app protection policies](/mem/intune/apps/app-protection-policy).
> - The following keys are available in Office apps for iOS version 2.60 or later.

- To block add-ins from the Office Store only, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableOMEXCatalog`
  
- To block all add-ins from the Office Store and sideloaded add-ins, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableAllCatalogs`
