---
title: Block use of Office Add-ins for work or school accounts
description: When users use their Microsoft account as the active account in the Office app, corporate policies that block Office add-ins don't take effect.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: patkling, seanla, sofianeh, jarnold
ms.custom: CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office app for iOS
ms.date: 04/29/2022
---
# Block use of Office add-ins from work or school accounts

## Symptom

Consider the following scenario:

- Users in your organization use personal iOS devices and their personal Microsoft accounts (MSA) to access corporate resources.
- When users are signed into their work or school accounts, installation of Office add-ins is blocked. Users can install Office add-ins when they're signed into MSA.
- Users sign in to Office apps with MSA, create a file such as an Excel workbook, install a few Office add-ins and use them. Then they save the file to a corporate storage location, such as the organization's OneDrive for Business.

In this scenario, when users sign in to their work or school accounts and reopen the file, they can use the Office add-ins that were installed when the file was created with MSA.

If account switching is available to users in your organization, this issue also occurs when users switch the active account in Office apps from MSA to their work or school accounts.

## Cause

This issue occurs if Office add-in installation is blocked for work or school accounts by [turning off the Office Store across all clients](/microsoft-365/admin/manage/manage-addins-in-the-admin-center?view=o365-worldwide#prevent-add-in-downloads-by-turning-off-the-office-store-across-all-clients-except-outlook&preserve-view=true). This method doesn't prevent the use of Office add-ins that exist in files created with MSA.

## Resolution

To prevent the use of Office add-ins, set a preference in the [app configuration policies](/mem/intune/apps/app-configuration-policies-overview#managed-apps) for managed apps. This method can be used for both managed and unmanaged devices.

> [!NOTE]
>
> - Make sure the Office apps (Word, Excel, PowerPoint) are managed by Intune, and are configured with [Intune app protection policies](/mem/intune/apps/app-protection-policy).
> - The following keys are available in Office apps for iOS version 2.60 or later.

- To block only add-ins from the Office Store, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableOMEXCatalog`
  
- To block all add-ins from the Office Store and sideloaded add-ins, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableAllCatalogs`
