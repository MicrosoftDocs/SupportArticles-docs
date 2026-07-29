---
title: Cross-forest or hybrid free/busy lookups fail
description: Provides a fix for an issue in which cross-forest or hybrid free/busy information lookups fail in Microsoft Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Issue viewing Free Busy
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 12057
ms.reviewer: brianday, grtaylor, wduff, v-six, v-kccross
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/29/2026
---

# Cross-forest or hybrid free/busy availability lookups fail in Microsoft Exchange Server

_Original KB number:_ &nbsp; 2734791

## Summary

Cross-forest or hybrid free/busy lookups fail when Microsoft Exchange Server can't retrieve availability data from the target organization. This problem typically occurs when the external URL for Exchange Web Services (EWS) isn't configured in the target environment. Without this URL, the Availability service can't locate or access the remote mailbox data. Configuring a valid EWS external URL restores free/busy lookups between organizations.

## Symptoms

Cross-forest or hybrid free/busy information lookups fail in Microsoft Exchange Server. However, standard free/busy information lookups for users in the same forest work as expected.

## Cause

This problem occurs if the external URL for Exchange Web Services isn't configured in the target forest.

## Resolution

Configure the external URL for Exchange Web Services for the target forest. To do this, run the [Set-WebServicesVirtualDirectory](/powershell/module/exchangepowershell/set-webservicesvirtualdirectory) PowerShell cmdlet as shown in the following example:

```powershell
Set-WebServicesVirtualDirectory -identity "server_name\EWS (Default Web Site)" -ExternalURL
https://mail.contoso.com/ews/Exchange.asmx
```

> [!NOTE]
> In this command, *contoso* represents the actual domain name.

## More information

Exchange Server uses the external URL for Exchange Web Services to connect to the target forest. Because the AutoDiscover service can't return the external URL for Exchange Web Services if Outlook Anywhere isn't enabled in the target forest, the cross-forest or hybrid lookup fails.

If either of the following cmdlets returns a value of **$False**, the mailbox isn't set to allow external connections by using Outlook Anywhere.

To verify that the mailbox is set to allow external connections by using Outlook Anywhere, run the `Get-CASMailbox` cmdlet as shown in the following example:

```powershell
Get-CASMailbox <mailbox identity> | fl MAPIBlockOutlookExternalConnectivity
```
