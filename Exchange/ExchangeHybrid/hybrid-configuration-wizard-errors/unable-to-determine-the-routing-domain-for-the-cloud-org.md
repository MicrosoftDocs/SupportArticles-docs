---
title: "HCW8001 - Unable to determine the Tenant Routing Domain" error when running the Hybrid Configuration Wizard
description: Resolves an issue in which you receive the HCW8001 error message when you run Hybrid Configuration Wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 3945
  - no-azure-ad-ps-ref
ms.reviewer: haembab, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 03/30/2026
---

# "HCW8001 - Unable to determine the Tenant Routing Domain" error when running the Hybrid Configuration Wizard

<!-- This article has been reviewed and approved for the specific use of global admin perms. -->

_Original KB number:_ 3068010

## Summary

This article discusses error code HCW8001 that is displayed when the Hybrid Configuration Wizard is unable to determine the routing domain for your tenant. The article lists the cause of the error and provides a resolution to fix the issue.

## Symptoms

When you run the Hybrid Configuration Wizard, you receive the "HCW8001 - Unable to determine the Tenant Routing Domain" error message. The full text of the message resembles the following example:

> ERROR: Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites  
> Microsoft.Exchange.Data.Common.LocalizedException: Unable to determine the routing domain for the cloud organization.  
> Unable to determine the routing domain for the cloud organization.  
> at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(ITask taskBase, ITaskContext taskContext)'

## Cause

Directory sync is disabled. When directory sync is enabled, the routing domain for the cloud organization is created.

## Resolution

Use the following steps to enable directory sync:

1. Run the following PowerShell cmdlets to install and connect to Microsoft Entra ID:

   ```powershell
   Install-Module -Name Microsoft.Entra -Repository PSGallery -Scope CurrentUser -Force -AllowClobber
   Connect-Entra -Scopes 'OnPremDirectorySynchronization.ReadWrite.All', 'Organization.ReadWrite.All'
   ```

   When you're prompted, sign in as a Microsoft 365 global administrator to grant consent.

   > [!NOTE]
   > To enable directory sync, you must be assigned the Microsoft 365 global administrator role.

2. Run the following PowerShell cmdlet to enable directory sync:

   ```powershell
   Set-EntraDirSyncEnabled -EnableDirSync $true -Force
   ```
