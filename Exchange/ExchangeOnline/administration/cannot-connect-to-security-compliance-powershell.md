---
title: Can't connect to Security & Compliance PowerShell
description: Provides a resolution for an issue in which you can't connect to Security & Compliance PowerShell when you use the Connect-IPPSSession PowerShell cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
  - CI 185022
ms.reviewer: shahmul, lindabr, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/11/2024
---

# Can't connect to Security & Compliance PowerShell

## Symptoms

When you try to connect to [Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell) by using the [Connect-IPPSSession](/powershell/module/exchange/connect-ippssession) PowerShell cmdlet, you receive the following error message:

> WARNING: Your connection has been redirected to the following URI: \<URI\>  
> Connecting to remote server \<server name\>.ps.compliance.protection.outlook.com failed with the following error message: For more information, see the about_Remote_Troubleshooting Help topic.  
> At C:\Program Files\WindowsPowerShell\Modules\ExchangeOnlineManagement \3.1.0\netFramework\ExchangeOnlineManagement.psm1:733 char:21...  
> \+ FullyQualifiedErrorId : System.Management. Automation.Remoting. PSRemotingDataStructureException

## Cause

The issue occurs if version [3.1.0](/powershell/exchange/exchange-online-powershell-v2#version-310) of the [Exchange Online PowerShell V3 module](https://www.powershellgallery.com/packages/ExchangeOnlineManagement) is installed on the computer that you used to run the cmdlet.

You can run the following PowerShell cmdlet to verify that version 3.1.0 of the Exchange Online PowerShell V3 module is installed:

```powershell
Get-InstalledModule ExchangeOnlineManagement | FL Name,Version,InstalledLocation
```

## Resolution

To fix the issue, follow these steps:

1. Run the following PowerShell cmdlet in an elevated PowerShell session to [update the Exchange Online PowerShell V3 module](/powershell/exchange/exchange-online-powershell-v2#update-the-exchange-online-powershell-module) to the latest version:

   ```powershell
   Update-Module -Name ExchangeOnlineManagement
   ```

2. Run the following PowerShell cmdlet to verify that the Exchange Online PowerShell V3 module is updated:

   ```powershell
   Get-InstalledModule ExchangeOnlineManagement | FL Name,Version,InstalledLocation
   ```

3. Try again to run the [Connect-IPPSSession](/powershell/module/exchange/connect-ippssession) PowerShell cmdlet to connect to Security & Compliance PowerShell.
