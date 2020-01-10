---
title: There is an error in XML document when you run New-CsOnlineSession
description: Describes an issue that triggers a There is an error in XML document (5,2) error when you try to connect to Skype for Business Online by using a remote Windows PowerShell session. Provides a workaround.
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
appliesto:
- Skype for Business Online
---

# "There is an error in XML document (5,2)" when you run the New-CsOnlineSession cmdlet to connect to Skype for Business Online

## Symptoms

You try to connect to Skype for Business Online (formerly Lync Online) by using the following cmdlet in a remote Windows PowerShell session:

```powershell
$O365Session = New-CsOnlineSession -Credential $credential
```

However, the connection to **Get-CsPowerShellEndpoin**t fails, and you receive the following error message: 

"There is an error in XML document (5,2)"

## Resolution

This is a known issue in Skype for Business Online that Microsoft is working to resolve. To work around this issue, include the **OverridePowerShellUri** parameter, and specify the fully qualified domain name (FQDN) of the Skype for Business Administration center URL, as in the following example:

```powershell
$O365Session = New-CsOnlineSession -Credential $credential –OverridePowershellUri "https://admin1a.online.lync.com/OcsPowershellLiveid”
```

> [!NOTE]
> To determine the Skype for Business Administration center URL, see the "To determine the Hosted Migration Service URL for your Office 365 tenant" section of [Administering users in a hybrid Lync Server 2013 deployment](https://technet.microsoft.com/library/jj204967.aspx).

## More Information

For more information, see [Using Windows PowerShell to manage Skype for Business Online](https://technet.microsoft.com/library/dn362831%28v=ocs.15%29.aspx).
