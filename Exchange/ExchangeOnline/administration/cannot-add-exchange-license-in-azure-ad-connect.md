---
title: Cannot add Exchange license in Microsoft Entra Connect
description: Fixes an issue in which you encounter issues when you try to add an Exchange license in Microsoft Entra Connect for Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.reviewer: kerbo, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't add Exchange license in Microsoft Entra Connect for Microsoft 365

_Original KB number:_ &nbsp; 4052036

## Symptoms

You receive an error message when you try to add an Exchange license in Microsoft Entra ID for Microsoft 365.

## Resolution

There are two Windows Azure Active Directory modules to administer Microsoft Entra ID through PowerShell. Both are supported currently.

- MSOL - For more information about MSOL module, see the following articles:

  - [Install-Module (MSOnline)](/powershell/azure/active-directory/install-msonlinev1)
  - [Connect-MsolService](/powershell/module/MSOnline/?view=azureadps-1.0&redirectedfrom=msdn#bkmk_installmodule&preserve-view=true)
- AzureAD - For more information about AzureAD module, see the following articles:

  - [Install-Module AzureAD](/powershell/azure/active-directory/install-adv2?view=azureadps-2.0&preserve-view=true)
  - [Connect-AzureAD](/powershell/module/Azuread/?view=azureadps-2.0&preserve-view=true)

This issue can occur under different circumstances.

- If you receive an error message when assigning a new license, confirm that the object exists in the Microsoft Entra ID by using the Azure AD PowerShell module. A `UsageLocation` parameter is required and has to be populated. For example:

  ```powershell
  Get-MsolUser -SearchString <userPrinicipalName or DisplayName> | fl UsageLocation
  ```

  ```powershell
  Get-AzureADUser -SearchString <userPrinicipalName or DisplayName> | fl UsageLocation
  ```

- To resolve this issue, try assigning the license through PowerShell. See [Assign Microsoft 365 licenses to user accounts with PowerShell](/microsoft-365/enterprise/assign-licenses-to-user-accounts-with-microsoft-365-powershell?view=o365-worldwide&preserve-view=true). If that does not resolve the issue, collect the PowerShell log file that's located here and open a case with Microsoft:

  > %userprofile%\appdata\local\microsoft\Office365\PowerShell

- If DirSync errors are present on an object, you may receive an error message when you try to change the license for the object, including adding or removing features. Check for DirSync errors by using the following support articles:

  - [View directory synchronization errors in Microsoft 365](/microsoft-365/enterprise/identify-directory-synchronization-errors?view=o365-worldwide&preserve-view=true)
  - [How to identify DirSync or Microsoft Entra Connect provisioning errors in Microsoft 365](https://support.microsoft.com/help/4040885)

  For more information about how to troubleshoot, see the following articles:

  - [Troubleshooting Errors during synchronization](/azure/active-directory/hybrid/tshoot-connect-sync-errors)
  - [Troubleshoot an object that is not synchronizing with Microsoft Entra ID](/azure/active-directory/hybrid/tshoot-connect-object-not-syncing)
