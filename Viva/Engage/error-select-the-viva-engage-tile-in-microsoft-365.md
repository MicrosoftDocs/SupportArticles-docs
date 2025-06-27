---
title: Sign-in error when you select the Viva Engage tile in Microsoft 365
description: Provides a fix for an error that displays when you select the Viva Engage tile in Microsoft 365.
ms.author: luche
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: viva-engage
search.appverid:
 - MET150
ms.date: 08/08/2024
---

# Sign-in error when you select the Viva Engage tile in Microsoft 365

## Symptoms

You recently activated Microsoft Viva Engage Enterprise by using the Microsoft 365 admin center. The Viva Engage tile appears in the app launcher, but when you select it, you receive the following error message:

> Sorry, but we're having trouble signing you in. We received a bad request.

## Resolution

To resolve this issue, make sure that the Viva Engage Service Principal is enabled.

**Note:** You must have Yammer Administrator permissions to perform these steps.

Follow these steps:

1. [Connect to Microsoft 365 with PowerShell](/microsoft-365/enterprise/connect-to-microsoft-365-powershell).
1. Check whether the Viva Engage Service Principal is currently disabled. To do so, run the following cmdlets, press Enter after you type each cmdlet:

   ```powershell
   Connect-MsolService
   SMSP = Get-MsolServicePrincipal -AppPrincipalId "00000005-0000-0ff1-ce00-000000000000"
   SMSP.AccountEnabled
   ```

1. If the last cmdlet returns **False**, change the **Account** setting for this service principal to **True**. To do so, run the following cmdlet:

   ```powershell
   Set-MsolServicePrincipal -AppPrincipalId $MSP.AppPrincipalId -AccountEnabled $true
   ```

1. Sign in to Microsoft 365. Select the Viva Engage tile again to verify that you can sign in.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
