---
title: Email messages are stuck in Exchange Server queues for several minutes
description: Provide a resolution to an issue in which email messages sending to Exchange Online is stuck in on-premises message queues for several minutes when the Exchange Server is configured to send to a single destination such as Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: sesteven, v-six
ms.custom: 
  - CSSTroubleshoot
  - CI 124314
  - Exchange Server
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---

# Email messages are stuck in Exchange Server queues for several minutes

## Symptoms

In Microsoft Exchange Server 2019, 2016, or 2013, email messages may be stuck in on-premises message queues for several minutes if the server is configured to send to a single destination, such as Exchange Online. There are few or no deferrals (400-series SMTP response codes) from Exchange Online to account for the number of messages in the queue. Eventually, the messages are sent. However, there are some delays.

## Cause

Exchange Server is designed to create concurrent or parallel connections to send messages to multiple destinations. To make sure that those connections are not exhausted by sending to a single destination at the expense of others, the Exchange Server default settings restrict sending lots of mail to a single destination (FQDN of SendConnector/NextHopDomain), such as Exchange Online. If a server that is running Exchange Server is configured to send all messages to Exchange Online for relaying or as part of hybrid configuration, these settings limit the number of parallel and total connections that are created. This, in turn, limits the throughput of messages to Exchange Online.

## Resolution

If your Exchange-based servers are primarily used to send to Exchange Online, you can change the following settings to optimize performance and avoid building large queues.

### SmtpConnectorQueueMessageCountThresholdForConcurrentConnections

The *SmtpConnectorQueueMessageCountThresholdForConcurrentConnections* parameter determines how many messages in a queue will trigger the creation of another connection to the destination. The lower the threshold, the sooner that Exchange Server opens a new connection to Exchange Online. For a large volume of email, this translates to fewer messages in the queue because there will be more connections in parallel to transmit messages from the queue. The default value is **20** messages. You can set this value to **2** for the highest throughput. To do this, open the Edgetransport.exe.config file, and add the following parameters anywhere after the \<AppSettings> tag on all servers that handle traffic to Exchange Online:

```xml
<add key="SmtpConnectorQueueMessageCountThresholdForConcurrentConnections" value="2"/>
```

> [!NOTE]
> You must restart the MSExchangeTransport service for changes to take effect.

### MaxPerDomainOutboundConnections

The *MaxPerDomainOutboundConnections* parameter specifies the maximum number of concurrent connections to any single domain. The default value is **20** connections. To increase the maximum number of connections, run the following cmdlet:

```powershell
Set-TransportService Mailbox01 -MaxPerDomainOutboundConnections 40
```

### MessageRetryInterval

The *MessageRetryInterval* parameter specifies the retry interval for individual messages after a connection failure to a remote server occurs. The default value is **15** minutes. To reduce the retry interval value, run the following cmdlet:

```powershell
Set-TransportService Mailbox01 -MessageRetryInterval 00:05:00
```

For more information, see [Set-TransportService](/powershell/module/exchange/set-transportservice?view=exchange-ps&preserve-view=true).
