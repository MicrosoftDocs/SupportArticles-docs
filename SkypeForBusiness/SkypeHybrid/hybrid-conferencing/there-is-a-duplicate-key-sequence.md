---
title: There is a duplicate key sequence after you run New-CSHostingProvider
description: Describes an error in Lync Server, Skype for Business Server, and Skype for Business Online that occurs after you run the New-CSHostingProvider PowerShell cmdlet. Provides a solution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
ms.reviewer: v-tain, corbinm, dahans
appliesto: 
  - Skype for Business Online
  - Skype for Business Server 2015
  - Lync Server 2013
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2010 Standard Edition
ms.date: 03/31/2022
---

# "There is a duplicate key sequence" in Lync or Skype for Business after you run the New-CSHostingProvider cmdlet

## Problem

Consider the following scenario: 

- You're setting up a Skype for Business Online (formerly Lync Online) hybrid environment in Skype for Business Server 2015, Microsoft Lync Server 2013, or Microsoft Lync Server 2010.   
- You run the following Lync Server or Skype for Business Server PowerShell cmdlet:

    ```powershell
    New-CSHostingProvider -Identity LyncOnline -ProxyFqdn "sipfed.online.lync.com" -Enabled 
    $true -EnabledSharedAddressSpace $true -HostsOCSUsers $true -VerificationLevel UseSourceVerification 
    -IsLocal $false -AutodiscoverUrl https://webdir.online.lync.com/Autodiscover/AutodiscoverService.svc/root    
    ```

In this scenario, you receive the following error message:  

```adoc
There is a duplicate key sequence "LYNCONLINE" for the 'urn:schema:Microsoft.Rtc.Management.Settings.Edge.2008:ProviderName' key or unique identity constraint.
```

## Solution

To resolve this issue, remove the existing LyncOnline provider, and then run the original cmdlet again.  Run both **Get-CSHostingProvider** and **Get-CSPublicProvider** cmdlets to see all existing providers and determine whether any providers have the same name as the name that you're trying to create. (For example, determine whether any providers have the name "LyncOnline.")

If the existing LyncOnline connector is a hosting provider, use the following command to remove it: 

```powershell
Remove-CSHostingProvider –Identity LyncOnline If the conflicting provider is a public provider, use the following command to remove it:Remove-CSPublicProvider –Identity LyncOnline 
```

## More Information

This issue occurs because there is a public provider that has the duplicate name "LyncOnline configured in the topology. This can be verified by viewing the following settings in the Lync control panel:

- In Lync 2010, click **External User Access**, and then click **Provider**.   
- In Lync 2013, click **Federation and External Access**, and then click **SIP Federated Providers**.   


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
