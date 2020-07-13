---
title: Look up free and used Intune licenses
description: Describes how to use Windows PowerShell to determine the number of free and used Microsoft Intune licenses.
ms.date: 03/27/2020
ms.prod-support-area-path: General guidance or advisory
---
# How to use PowerShell to look up licenses for a Microsoft Intune subscription

The article describes how to use Windows PowerShell to determine the number of free and used Microsoft Intune licenses.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 3117663

## Determine the number of free and used Intune licenses

To view the number of free and used licenses on a Microsoft Intune subscription, run the following PowerShell commands:

1. From a PowerShell prompt, run the following command:

   ```powershell
   $creds = Get-Credential
   ```

2. A pop-up window will prompt for credentials. Enter your Microsoft Intune credentials.
3. Run the following command:

   ```powershell
   Connect-MsolService -Credential $creds
   ```

4. Run the following command:

   ```powershell
   Get-MsolAccountSku
   ```

A list of the **Account ID**, the **Active Units**, and the **Consumed Units** will appear. Note that this will also display any Microsoft Office 365 licenses on the subscription.
