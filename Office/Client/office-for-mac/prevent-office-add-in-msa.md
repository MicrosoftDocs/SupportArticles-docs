---
title: Block Office add-ins when using MSA
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
# Prevent Office add-ins when accessing corporate resources with Microsoft accounts

## Symptom

Consider the following scenario:

- Users in your organization can use their personal iOS devices to access corporate resources.
- Office add-ins are blocked by policies in corporate resources.
- Users sign in to Office apps with their Microsoft accounts, create a file with add-in enabled, and then save the file to a corporate storage location. For example, they create an Excel workbook with add-in enabled, then save the file to corporate OneDrive.

In this scenario, Office add-ins aren't blocked when users reopen the file from the corporate storage location.

This issue also occurs when users perform these actions while their Microsoft account is selected as the active account in the Office app.

## Cause

This issue occurs because the policies that prevent Office add-ins are applied to work or school accounts, not Microsoft accounts. Therefore, these policies don't take effect when users use their Microsoft accounts as the active account in Office apps.

## Resolution

To fix this issue, set a preference to prevent the use of Office add-ins.

> [!NOTE]
> The following keys are available in Office apps for iOS version 2.60 or later.

- To block only add-ins from the Office Store, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableOMEXCatalog`

  For example, you can use [app configuration policies](/mem/intune/apps/app-configuration-policies-overview) in Microsoft Intune to configure this setting.

  :::image type="content" source="media/prevent-office-add-in-msa/app-configuration-setting.png" alt-text="Screenshot to specify app configuration settings.":::

- To block all add-ins from the Office Store and sideloaded add-ins, set the following key to **1**:

  `com.microsoft.office.OfficeWebAddinDisableAllCatalogs`

This preference can be deployed through a mobile device management (MDM) server, or [Microsoft Intune app protection policies (APP)](/mem/intune/apps/app-protection-policy). If you use Intune to deploy the preference, make sure the Office apps are managed by Intune.
