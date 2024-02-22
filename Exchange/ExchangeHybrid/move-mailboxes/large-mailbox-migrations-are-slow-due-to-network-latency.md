---
title: Large mailbox migrations are slow due to network latency
description: Describes a scenario where hybrid mailbox migration for one or more large mailboxes is slow because of network latency. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: benwinz, jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Service Pack 1
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Large mailbox migrations are slow because of network latency

_Original KB number:_ &nbsp; 3184611

## Symptoms

Hybrid mailbox migration for one or more large mailboxes is slow because of network latency. Analysis of the move request shows that the SourceSideDuration value is greater than the expected range of 60 to 80 percent.

## Resolution

For Microsoft Exchange Server 2013 with Service Pack 1 and later versions, you can increase the export buffer size. To do this, add the `ExportBufferSizeOverrideKB` parameter to the `MRSConfiguration` section of the MSExchangeMailboxReplication.exe.config file. This setting reduces the number of migration calls and reduces the time that's spent in network latency. The recommended maximum value for this setting is 7,500, and the minimum value is 512. However, note that if you change the value of the `ExportBufferSizeOverrideKB` parameter, you should also change the `DataImportTimeout` value.

The following example shows the `ExportBufferSizeOverrideKB` setting after it's been added to the configuration file:

```console
<MRSConfiguration
...
ExportBufferSizeKB="512"
ExportBufferSizeOverrideKB="7500"
OldItemAge = "366.00:00:00"
...
/>
```

You must also set the `DataImportTimeout` value in the MRSProxyConfiguration section of the MSExchangeMailboxReplication.exe.config file to correspond to the minimum upload rate that you can sustain during the migration. For example:

7.5 MB/(60 seconds) = 131,072 bytes/second (for reference, 1,024 KB/s = 1 MB/s)

This means that you can never go lower than this rate. You can increase the `DataImportTimeout` value a bit more than the computed minimum. The following example shows the `DataImportTimeout` setting in the configuration file. In this example, it's set to 5 minutes. You can safely increase the value to 20 minutes.

```console
<MRSProxyConfiguration MaxMRSConnections="100"
DataImportTimeout="00:05:00" />
```

> [!WARNING]
> This solution disables cross-forest downgrade moves between Exchange 2013 SP1 and later versions to Exchange 2010 servers.

To learn more about how to analyze mailbox migration performance, see [Mailbox Migration Performance Analysis](https://techcommunity.microsoft.com/t5/exchange-team-blog/mailbox-migration-performance-analysis/ba-p/587134).
