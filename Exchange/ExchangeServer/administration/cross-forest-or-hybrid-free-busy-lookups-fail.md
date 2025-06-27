---
title: Cross-forest or Hybrid free/busy lookups fail
description: Cross-forest or hybrid free/busy information lookups fail in Microsoft Exchange Server. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Issue viewing Free Busy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: brianday, grtaylor, wduff, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Microsoft Exchange Server 2010 Service Pack 2 (SP2) Update Rollup 1 and later versions
  - Microsoft Exchange Server 2007 Service Pack 3 (SP3) Update Rollup 6 and later versions
  - Microsoft Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Cross-forest or Hybrid free/busy availability lookups fail in Exchange Server

_Original KB number:_ &nbsp; 2734791

## Symptoms

Cross-forest or hybrid free/busy information lookups fail in Microsoft Exchange Server. However, standard free/busy information lookups for users in the same forest work as expected.

This issue occurs in these product versions:

- Microsoft Exchange Server 2016
- Microsoft Exchange Server 2013
- Microsoft Exchange Server 2010 Service Pack 2 (SP2) Update Rollup 1 and later versions
- Microsoft Exchange Server 2007 Service Pack 3 (SP3) Update Rollup 6 and later versions
- Microsoft Exchange Online

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard).

## Cause

This issue occurs if the external URL for Exchange Web Services is not configured in the target forest.

## Resolution

Configure the external URL for Exchange Web Services for the target forest. To do this, run this command in Windows PowerShell for Exchange:

```powershell
Set-WebServicesVirtualDirectory -identity "server_name\EWS (Default Web Site)" -ExternalURL
https://mail.contoso.com/ews/Exchange.asmx
```

> [!NOTE]
> In this command, *contoso* represents the actual domain name.

## More information

The versions of Exchange Server that are listed in the Symptoms section use the external URL for Exchange Web Services to connect to the target forest. Because the AutoDiscover service cannot return the external URL for Exchange Web Services if Outlook Anywhere is not enabled in the target forest, the cross-forest or hybrid lookup fails.

If either of the following cmdlets returns a value of **$False**, the mailbox is not set to allow external connections by using Outlook Anywhere.

- To verify that the mailbox is set to allow connections by using Outlook Anywhere, run this cmdlet:

    ```powershell
    Get-CASMailbox <mailbox identity> | fl MAPIBlockOutlookRpcHttp
    ```

- For Exchange Server 2016 and Exchange Server 2013, to verify that the mailbox is set to allow external connections by using Outlook Anywhere, run this cmdlet:

    ```powershell
    Get-CASMailbox <mailbox identity> | fl MAPIBlockOutlookExternalConnectivity
    ```

## References

For more information about the `Set-WebServicesVirtualDirectory` cmdlet, see [Set-WebServicesVirtualDirectory](/previous-versions/office/exchange-server-2007/aa997233(v=exchg.80)).
