---
title: "Message rate limits and throttling"
ms.author: chrisda
author: chrisda
manager: serdars
ms.date: 7/6/2018
ms.audience: ITPro
ms.topic: overview
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.assetid: fba87902-2a79-42ac-b394-46a9016f667e
description: "Summary: Learn how message rate limits affect mail flow and connections in Exchange Server 2016 and Exchange Server 2019."
---

# Message rate limits and throttling

*Message throttling* refers to a group of limits that are set on the number of messages and connections that can be processed by an Exchange server. These limits include message processing rates, SMTP connection rates, and SMTP session timeout values. These limits work together to protect an Exchange server from being overwhelmed by accepting and delivering messages. Although a large backlog of messages and connections may be waiting to be processed, the message throttling limits enable the Exchange server to process the messages and connections in an orderly manner.

> [!NOTE]
> *Back pressure* is another feature that helps to avoid overwhelming the system resources of an Exchange server. Key resources, such as available hard disk space and memory utilization are monitored, and when the utilization level exceeds the specified threshold, the server gradually stops accepting new connections and messages. For more information, see [Understanding back pressure](back-pressure.md). There are also static limits that are available on messages, such as the maximum message size, the size of individual attachments, and the number of recipients. For more information about message size limits, see [Message size limits in Exchange Server](message-size-limits.md).

You can set the message rate limits and throttling options in the following locations:

- Mailbox servers and Edge Transport servers. Collectively, we'll refer to these as *transport servers*.

- Send connectors

- Receive connectors

- Users

## Message throttling on transport servers
<a name="Servers"> </a>

The following table shows the message throttling options that are available on Mailbox servers and Edge Transport servers.

|**Rate limit**|**Default value**|**Exchange Management Shell configuration**|**EAC configuration**|
|:-----|:-----|:-----|:-----|
|**Maximum concurrent mailbox deliveries**: The maximum number of delivery threads that the Transport service and the Mailbox Transport Delivery service can have open at the same time to deliver message to mailboxes.|20 <br/> We recommend that you don't modify this value unless you're directed to do so by Microsoft Customer Service and Support.|Cmdlet: **Set-TransportService** and **Set-MailboxTransportService** <br/> Parameter: _MaxConcurrentMailboxDeliveries_|Not available|
|**Maximum concurrent mailbox submissions**: The maximum number of submission threads that the Transport service and the Mailbox Transport Submission service can have open at the same time to send messages from mailboxes.|20 <br/> We recommend that you don't modify this value unless you're directed to do so by Microsoft Customer Service and Support.|Cmdlet: **Set-TransportService** and **Set-MailboxTransportService** <br/> Parameter: _MaxConcurrentMailboxSubmissions_|Not available|
|**Maximum connection rate per minute**: The maximum rate that connections are allowed to be opened with the Transport service.|1200|Cmdlet: **Set-TransportService** <br/> Parameter: _MaxConnectionRatePerMinute_|Not available|
|**Maximum concurrent connections**: The maximum number of outbound connections that the Transport service can have open at a time.|1000 <br/> This value must be greater than or equal to the _MaxPerDomainOutboundConnections_ value.|Cmdlet: **Set-TransportService** <br/> Parameter: _MaxOutboundConnections_|**Servers** \> **Servers** \> **Properties** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Transport limits** section \> **Maximum concurrent connections**. <br/> **Note**: In the EAC, you can only set the values 100, 1000, 5000, or unlimited.|
|**Maximum concurrent connections per domain**: The maximum number of outbound connections that the Transport service can have open to a single domain at a time.|20 <br/> This value must be less than or equal to the _MaxOutboundConnections_ value.|Cmdlet: **Set-TransportService** <br/> Parameter: _MaxPerDomainOutboundConnections_|**Servers** \> **Servers** \> **Properties** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Transport limits** section \> **Maximum concurrent connections per domain**. <br/> **Note**: In the EAC, you can only set the values 100, 1000, 5000, or unlimited.|
 
To see the values of these server message throttling settings, run the following command in the Exchange Management Shell:

```
Write-Host "Transport service:" -ForegroundColor yellow; Get-TransportService | Format-List MaxConcurrent*,MaxConnection*,Max*OutboundConnections; Write-Host "Mailbox Transport service:" -ForegroundColor yellow; Get-MailboxTransportService | Format-List MaxConcurrent*
```

> [!NOTE]
> The Pickup directory and the Replay directory that are available on Edge Transport servers and Mailbox servers also have messages rate limits that you can configure. Typically, the Pickup directory and the Replay directory aren't used in everyday mail flow. For more information, see [Configure the Pickup Directory and the Replay Directory](https://technet.microsoft.com/library/c9ca7358-9a08-4f57-89d0-910e4438df8a.aspx). The maximum number of message files per minute that can be processed by the Pickup directory and the Replay directory is 100. Each directory can independently process message files at this rate.

## Message throttling on Send connectors
<a name="SendConn"> </a>

The following table shows the message throttling options that are available on Send connectors. Send connectors exist in the Transport service on Mailbox servers and on Edge Transport servers. For more information, see [Send connectors](connectors/send-connectors.md).

|**Rate limit**|**Default value**|**Exchange Management Shell configuration**|**EAC configuration**|
|:-----|:-----|:-----|:-----|
|**Connection inactivity time out**: The maximum amount of time that an open SMTP connection with a source messaging server can remain idle before the connection is closed.| `00:10:00` (10 minutes)|Cmdlet: **New-SendConnector** and **Set-SendConnector** <br/> Parameter: _ConnectionInactivityTimeOut_|Not available|
|**Maximum messages per connection**: The maximum number of messages that can be sent over a single connection|20|Cmdlet: **New-SendConnector** and **Set-SendConnector** <br/> Parameter: _SmtpMaxMessagesPerConnection_|Not available|
 
To see the values of these Send connector throttling settings, run the following command in the Exchange Management Shell:

```
Get-SendConnector | Format-List Name,ConnectionInactivityTimeout,SmtpMaxMessagesPerConnection
```

## Message throttling on Receive connectors
<a name="ReceiveConn"> </a>

The following table shows the message throttling options that are available on Receive connectors. Receive connectors are available in the Front End Transport service on Mailbox servers, the Transport service on Mailbox servers, and on Edge Transport servers. For more information, see [Receive connectors](connectors/receive-connectors.md).

|**Rate limit**|**Default value**|**Exchange Management Shell configuration**|**EAC configuration**|
|:-----|:-----|:-----|:-----|
|**Connection time out**: The maximum amount of time that an SMTP connection with a source messaging server can remain open, even when the source messaging server is transmitting data.| `00:10:00` (10 minutes) for Receive connectors on Mailbox servers. <br/> `00:05:00` (1 minute) for Receive connectors on Edge Transport servers. <br/> This value must be greater than the _ConnectionInactivityTimeOut_ value.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _ConnectionTimeout_|Not available|
|**Connection inactivity time out**: The maximum amount of time that an open SMTP connection with a source messaging server can remain idle before the connection is closed.| `00:05:00` (5 minutes) for Receive connectors on Mailbox servers. <br/> `00:01:00` (1 minute) for Receive connectors on Edge Transport servers. <br/> This value must be less than the _ConnectionTimeout_ value.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _ConnectionInactivityTimeOut_|Not available|
|**Maximum inbound connections**: The maximum number of inbound SMTP connections that are allowed at the same time.|5000|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _MaxInboundConnection_|Not available|
|**Maximum inbound connections per source**: The maximum number of inbound SMTP connections that are allowed from a source messaging server at the same time.| `unlimited` on the default Receive connector named Default _\<ServerName\>_ in the Transport service on Mailbox servers. <br/> 20 on other Receive connectors on Mailbox servers and Edge Transport servers.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _MaxInboundConnectionPerSource_|Not available|
|**Maximum inbound connection percentage per source**: The maximum percentage of inbound SMTP connections that are allowed from a source messaging server at the same time.|100 percent on the default Receive connector named Default _\<ServerName\>_ in the Transport service on Mailbox servers. <br/> 2 percent on other Receive connectors on Mailbox servers and Edge Transport servers.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _MaxInboundConnectionPercentagePerSource_|Not available|
|**Message rate limit**: The maximum number of messages per minute that can be sent by a single source.| `unlimited` on the following default Receive connectors: <br/>• Default _\<ServerName\>_ in the Transport service on Mailbox servers. <br/>• Default Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers. <br/>• Outbound Proxy Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers. <br/> 5 on the following default Receive connectors: <br/>• Client Proxy _\<ServerName\>_ in the Transport service on Mailbox servers. <br/>• Client Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers. <br/> 600 on the default Receive connector named Default internal Receive connector _\<ServerName\>_ on Edge Transport servers.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _MessageRateLimit_|Not available|
|**Message rate source**: This indicates how the message submission rate is calculated. Valid values are: <br/> `User`: The rate is calculated for sending users (specified with the **MAIL FROM** SMTP command). <br/>• `IPAddress`: The rate is calculated for sending hosts. <br/>• `All`: The rate is calculated for both sending users and sending hosts.| `IPAddress` on the following default Receive connectors: <br/>• Default _\<ServerName\>_ in the Transport service on Mailbox servers. <br/>• Default Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers. <br/>• Outbound Proxy Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers. <br/>• Default internal Receive connector _\<ServerName\>_ on Edge Transport servers. <br/> `User` on the following default Receive connectors: <br/>• Client Proxy _\<ServerName\>_ in the Transport service on Mailbox servers. <br/>• Client Frontend _\<ServerName\>_ in the Front End Transport service on Mailbox servers.|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _MessageRateSource_|Not available|
|**Tarpit interval**: The amount of time to artificially delay SMTP responses to unauthenticated remote servers that appear to be abusing the connection. Authenticated connections are never delayed in this manner.|`00:00:05` (5 seconds)|Cmdlet: **New-ReceiveConnector** and **Set-ReceiveConnector** <br/> Parameter: _TarpitInterval_|Not available|
 
To see the values of these Receive connector message throttling settings, run the following command in the Exchange Management Shell:

```
Get-ReceiveConnector | Format-List Name,Connection*,MaxInbound*,MessageRate*,TarpitInterval
```

## Message throttling on users
<a name="Policies"> </a>

The Microsoft Exchange Throttling service tracks resource settings for specific uses and caches the information in memory. Mail flow throttling settings are also known as a *budget*. Restarting the Microsoft Exchange Throttling service resets the mail flow throttling budgets.

Each mailbox has a _ThrottlingPolicy_ setting. The default value for this setting is blank (`$null`). You can use the _ThrottlingPolicy_ parameter on the **Set-Mailbox** cmdlet to configure a throttling policy for a mailbox.

For more information, see the following topics:

- [User workload management in Exchange Server](../server-health/workload-management.md)

- [Change User Throttling Settings for Specific Users](https://technet.microsoft.com/library/c5f834d6-189d-485e-9800-5e0066815ecf.aspx)

- [Change User Throttling Settings for All Users in Your Organization](https://technet.microsoft.com/library/c45cacfc-768d-4605-9bb0-53e30273fe4d.aspx)


