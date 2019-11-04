---
title: Lync administrator can't connect to Skype for Business Online Remote PowerShell
description: Describes an issue in which Lync administrators can't connect to Skype for Business Online Remote PowerShell in a Lync hybrid environment. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# Lync administrators can't connect to Skype for Business Online Remote PowerShell in a Lync hybrid environment

## Problem

Administrators who have a Lync hybrid deployment may receive the following error message when they try to connect to Skype for Business Online (formerly Lync Online) Remote PowerShell: 

```powershell
Get-CsPowerShellEndpoint : Unable to query AutoDiscover URL at: http://lyncdiscover.contoso.com?Domain=contoso.com
```

## Solution

To resolve this issue, run the cmdlet again, but instead specify the OverrideAdminDomain property. Use the default domain that was included with your Office 365 subscription. For example, use contoso.onmicrosoft.com. The PowerShell cmdlet should resemble the following:

```powershell
$cssession = New-CsOnlineSession –Credential $cred –OverrideAdminDomain "contoso.onmicrosoft.com"
```

## More Information

This issue occurs when the DNS records for AutoDiscover are pointed to the on-premises Lync server.

For more information about the **New-CsOnlineSession** cmdlet, or about how to manage Skype for Business Online with Skype for Business Online Remote PowerShell, see [Set up your computer for Windows PowerShell](https://technet.microsoft.com/library/dn362831.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).