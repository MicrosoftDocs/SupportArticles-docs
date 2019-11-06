---
title: Move-CsUser HostedMigration fault when you move users to Skype for Business Online
description: Describes the error message Move-CsUser HostedMigration fault when you move users to Skype for Business Online from an on-premises Lync Server. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# "Move-CsUser : HostedMigration fault" when you move users to Skype for Business Online from an on-premises Microsoft Lync Server

## Problem

In a Lync hybrid deployment, when you try to move users from the on-premises server that is running Lync to Skype for Business Online (formerly Lync Online) in Office 365, you receive the following error message in Skype for Business Online PowerShell:

```powershell
Move-CsUser : HostedMigration fault: Error=(510), Description=(This user’s tenant is not enabled for shared sip address space.)
```

## Solution

Before you try to migrate an on-premises Lync user to Skype for Business Online in Office 365, your Office 365 Skype for Business Online organization must be enabled for Shared Session Initiation Protocol (SIP) Address Space. 

## More Information

[Connect to Skype for Business Online PowerShell](#how-to-connect-to-skype-for-business-online-powershell), and then run the following command: 

```powershell
Set-CsTenantFederationConfiguration -SharedSipAddressSpace $true
```

### How to connect to Skype for Business Online PowerShell

The first step is to install the Windows PowerShell Module for Skype for Business Online. For information, go to the following Microsoft website:

[Windows PowerShell Module for Skype for Business Online](https://www.microsoft.com/download/details.aspx?id=39366)

After you have the Skype for Business Online Connector module installed, open Windows PowerShell, and then run the following commands:

```powershell
Import-Module LyncOnlineConnector 
$cred = Get-Credential 
$CSSession = New-CsOnlineSession -Credential $cred 
Import-PSSession $CSSession -AllowClobber 
```

For more information about how to connect to Skype for Business Online by using Windows PowerShell, see [Set up your computer for Windows PowerShell](https://technet.microsoft.com/library/dn362795.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
