---
title: Cmdlet or parameter combinations not working
description: This article describes how to work around an issue in which some PowerShell cmdlet or parameter combinations do not work as expected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11876
ms.reviewer: jarrettr, ralfle, v-six
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/28/2026
---

# Some PowerShell cmdlet or parameter combinations are unsuccessful in Exchange Server

_Original KB number:_ &nbsp; 4295103

## Summary

This article describes an issue in which certain PowerShell cmdlets or parameter combinations fail in multi-domain Exchange Server environments. The issue occurs by design if the mailbox object resides in a different domain or on a different server than the one that's used by Exchange Management Shell (EMS). To work around the issue, specify a domain controller from the correct Active Directory domain by using the `-DomainController` parameter.

## Symptoms

Consider the following scenario:

- You have a Microsoft Exchange Server environment that contains two or more mailbox servers.
- Your Active Directory Forest contains two or more domains.
- Your Exchange Servers and user objects are located in different Active Directory domains.
- You manage your recipients through EMS by setting `Set-ADServerSettings -ViewEntireForest $true`.

In this scenario, when you run a PowerShell cmdlet or parameter combination, the cmdlet is unsuccessful, and you receive the following error message:

```console
Error on proxy command 'Set-Mailbox -Identity:'user@contoso.com' -LitigationHoldEnabled:$False' to server
Ex01.corp.contoso.com:
Server version 15.0x.xxxx.xx, Proxy method RPS:
The operation couldn't be performed because object 'Ex02.corp @contoso.com' couldn't be found on
'Ex02.corp.munich.contoso.com'..  
+ CategoryInfo : NotSpecified: (:) [Set-Mailbox], CmdletProxyException
+ FullyQualifiedErrorId : Microsoft.Exchange.Configuration.CmdletProxyException,Microsoft.Exchange.
```

Here are some cmdlet or parameter combinations that might be affected:

- Get-CASMailbox -ActiveSyncDebugLogging
- Set-CASMailbox -ActiveSyncDebugLogging
- Set-CASMailbox -ResetAutoBlockedDevices
- Set-Mailbox -RetentionHoldEnabled
- Set-Mailbox -RetentionComment
- Set-Mailbox -RetentionUrl
- Set-SiteMailbox
- Set-UserPhoto
- Get-UserPhoto
- Set-Mailbox -LitigationHoldEnabled $false

## Cause

This behavior is by design if the specified mailbox is located on a different server from the server to which EMS is connected.

## Workaround

To work around this behavior, specify the `-DomainController` parameter together with the cmdlet. You can specify a Domain Controller from the Active Directory domain where the associated user object is located, as shown in the following example:

```powershell
Set-Mailbox -Identity:'user@contoso.com' -LitigationHoldEnabled:$False -DomainController dc1.sub.corp.contoso.com
```
