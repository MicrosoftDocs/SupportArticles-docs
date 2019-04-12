---
title: Sorry, but we're having trouble signing you in when you click the Yammer tile in Office 365
description: Describes an issue in which you receive "Sorry, but we're having trouble signing you in" error when you click the Yammer tile in Office 365.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# "Sorry, but we're having trouble signing you in" error when you click the Yammer tile in Office 365

## Problem

You recently activated Yammer Enterprise by using the Office 365 admin center. The Yammer tile appears in the app launcher, but when you click it, you receive the following error message:

**Sorry, but we're having trouble signing you in. We received a bad request.**

## Solution

To resolve this issue, the Yammer Service Principal must be enabled.

Before you follow these steps, make sure that the following prerequisites are met:

- Install the Azure Active Directory Module for Windows PowerShell. For more information, go to [Connect PowerShell to Office 365 services](https://support.office.com/article/managing-office-365-and-exchange-online-with-windows-powershell-06a743bb-ceb6-49a9-a61d-db4ffdf54fa6).

- These steps can only be performed by an Office 365 global admin.

Follow these steps:

1. Verify the Yammer Service Principal is currently disabled. To do this, open Azure Active Directory Module for Windows PowerShell, and then run the following cmdlets:

   > [!NOTE]
   > Press Enter after you type each cmdlet. The response to the last cmdlet should be **False**.

   ```
   Connect-MsolService
   SMSP = Get-MsolServicePrincipal -AppPrincipalId "00000005-0000-0ff1-ce00-000000000000"
   SMSP.AccountEnabled
   ```

2. Change the **Account** setting for this service principal to **True**. To do this, run the following cmdlet:

   ```
   Set-MsolServicePrincipal -AppPrincipalId $MSP.AppPrincipalId -AccountEnabled $true
   ```

3. Sign in to Office 365. Click the Yammer tile again to verify that you can sign in.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
