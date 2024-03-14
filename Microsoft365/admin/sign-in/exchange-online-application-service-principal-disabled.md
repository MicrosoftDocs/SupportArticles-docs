---
title: Unable to sign in to Microsoft 365 portal
description: You can't sign in to Microsoft 365 portal when Exchange Online application service principal is disabled.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "Sorry, but we're having trouble signing you in" error when signing in to Microsoft 365

## Symptoms

When you try to sign in to the Microsoft 365 portal, you receive the following error message:

**Sorry, but we're having trouble signing you in.**

Additionally, you might also see the following error message:

**AADSTS7000112: Application '00000002-0000-0ff1-ce00-000000000000'(Office 365 Exchange Online) is disabled.**

## Cause

This issue occurs if the Service Principal for the Exchange Online application is disabled for the tenant.

## Resolution

Before you follow these steps, make sure that the following prerequisites are met:

- Install the Azure Active Directory module for Windows PowerShell. For more information, go to [Connect to Microsoft 365 PowerShell](/office365/enterprise/powershell/connect-to-office-365-powershell
).
- The steps are performed by a Microsoft 365 global administrator.

To resolve this issue, follow these steps:

1. Check the current status of the Service Principal for the Exchange Online application. To do this, run the following cmdlet:

   ```powershell
   (Get-MsolServicePrincipal -AppPrincipalId 00000002-0000-0ff1-ce00-000000000000).accountenabled
   ```

1. Enable the Service Principal for Exchange Online by running the following cmdlet:

   ```powershell
   Get-MsolServicePrincipal -AppPrincipalId 00000002-0000-0ff1-ce00-000000000000 | Set-MsolServicePrincipal -AccountEnabled $true
   ```
