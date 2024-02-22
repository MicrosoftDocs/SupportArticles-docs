---
title: New move request remains in queued status
description: Resolves an issue in which a new move request is created but remains in a queued state. This issue occurs in an Exchange Server 2013 or Server 2016 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: batre, robwhal, bradhugh, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
---
# Newly created move request remains in queued status forever in Exchange Server 2013 or Exchange Server 2016

_Original KB number:_ &nbsp; 3016284

## Summary

When this issue occurs, you can run the [Get-MoveRequestStatistics](/powershell/module/exchange/get-moverequeststatistics) cmdlet to check that the mailbox is in the queued status. Because of resource constraints, the move request isn't picked up and queued. Follow the steps in the [Workaround](#workaround) section to determine which resource may be causing this issue.

## Workaround

For servers that have Exchange Server 2013 Cumulative Update 5 or a later-version update installed, run the following command to determine which resource may be causing this issue:

```powershell
Get-MoveRequestStatistics -Identity <mailbox name> | fl Message
```

For servers that have an update that is earlier than Exchange Server 2013 Cumulative Update 5, run the following command to determine which resource may be causing this issue:

```powershell
Get-ExchangeDiagnosticInfo -Server <server name>  -Process MSExchangeMailboxReplication -Component MailboxReplicationService -Argument "queues= database name,pickupresults"
```

After you run these commands in your environment, the CiAgeOfLastNotification component is in a critical state. This state indicates that the content index isn't in a good status. In this case, follow these steps to reseed the content index for the database:

1. Run the following commands to stop the Microsoft Exchange Search and Microsoft Exchange Search Host Controller services:

    ```powershell
    Stop-Service MSExchangeFastSearch
    Stop-Service HostControllerService
    ```

2. After the services are stopped, delete the Exchange content index catalog for the database.

3. Run the following commands to restart the Microsoft Exchange Search and Microsoft Exchange Search Host Controller services:

    ```powershell
    Start-Service MSExchangeFastSearch
    Start-Service HostControllerService
    ```

4. After you restart these services, Exchange Search will rebuild the content index catalog. Finally, you can run the `Get-MailboxDatabaseCopyStatus` cmdlet to confirm the content index state.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the **Applies to**.

## References

[reseed the search catalog](/exchange/reseed-the-search-catalog-exchange-2013-help)
