---
title: "Understanding back pressure"
ms.author: chrisda
author: chrisda
manager: serdars
ms.date: 7/6/2018
ms.audience: ITPro
ms.topic: overview
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.assetid: 03003544-e802-4988-9427-5fc4da64dcb8
description: "Summary: Learn how back pressure monitors system resources on Exchange 2016 and 2019 servers to prevent servers from being overwhelmed by the volume of incoming messages."
---

# Understanding back pressure

Back pressure is a system resource monitoring feature of the Microsoft Exchange Transport service that exists on Mailbox servers and Edge Transport servers. Back pressure detects when vital system resources, such as hard drive space and memory, are overused, and takes action to prevent the server from becoming completely overwhelmed and unavailable. For example, when a system resource utilization level on the Exchange server is determined to be too high, the server delays accepting new messages. If the resource utilization gets worse, the server stops accepting new messages to work exclusively on processing all existing messages, and might even stop processing outgoing messages. When the system resource utilization returns to an acceptable level, the Exchange server resumes normal operation by accepting new messages and processing outgoing messages.

## Monitored resources
<a name="Monitored"> </a>

The following system resources are monitored by back pressure:

- **DatabaseUsedSpace[%ExchangeInstallPath%TransportRoles\data\Queue]**: Hard drive utilization for the drive that holds the message queue database.

- **PrivateBytes**: The memory that's used by the EdgeTransport.exe process.

- **QueueLength[SubmissionQueue]**: The number of messages in the Submission queue.

- **SystemMemory**: The memory that's used by all other processes.

- **UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue]**: Hard drive utilization for the drive that holds the message queue database transaction logs.

- **UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data]**: Hard drive utilization for the drive that's used for content conversion.

- **UsedVersionBuckets[%ExchangeInstallPath%TransportRoles\data\Queue\mail.que]**: The number of uncommitted message queue database transactions that exist in memory.

For each monitored system resource on a Mailbox server or Edge Transport server, the following levels of resource utilization or *pressure* are defined: 

- **Low or Normal**: The resource isn't overused. The server accepts new connections and messages.

- **Medium**: The resource is slightly overused. Back pressure is applied to the server in a limited manner. Mail from senders in the organization's authoritative domains can flow. However, depending on the specific resource under pressure, the server uses tarpitting to delay server response or rejects incoming **MAIL FROM** commands from other sources.

- **High**: The resource is severely overused. Full back pressure is applied. All message flow stops, and the server rejects all new incoming **MAIL FROM** commands.

Transition levels define the low, medium and high resource utilization values depending on whether the resource pressure is increasing or decreasing. Typically, a resource utilization level that's lower than the original level is required as the resource utilization decreases. In other words, there really isn't a static value for low, medium and high resource pressure. You need to know if the utilization is increasing or decreasing before you can determine the next change in resource utilization level.

The following sections explain how Exchange handles the situation when a specific resource is under pressure.

### Hard drive utilization for the drive that holds the message queue database

 **Resource**: **DatabaseUsedSpace[%ExchangeInstallPath%TransportRoles\data\Queue]**

 **Description**: Monitors the percentage of total drive space that's consumed by all files on the drive that holds the message queue database. Note that the message queue database file contains unused space, so an accurate description of the total drive space that's consumed by all files is drive size - free disk space - free space in the database.

To change the default location of the message queue database, see [Change the location of the queue database](queues/relocate-queue-database.md).

 **Pressure transitions (%)**:

- **LowToMedium**: 96 

- **MediumToHigh**: 99 

- **HighToMedium**: 97 

- **MediumToLow**: 94 

 **Comments:**:

The default high level of hard drive utilization is calculated by using the following formula:

100 \* (_\<hard drive size in MB\>_ - 500 MB) / _\<hard drive size in MB\>_

This formula accounts for the fact that there's unused space in the message queue database

1 GB = 1024 MB. The result is rounded down to the nearest integer.

For example, if your message queue database is located on a 1 terabyte (TB) drive (1048576 MB), the high level of utilization is 100\*(1048576-500)/1048576) or 99%.

As you can see from the formula and the rounding down behavior, the hard drive needs to be very small before the formula calculates a high utilization value that's less than 99%. For example, a 98% value for high utilization requires a hard drive of approximately 25 GB or less.

### Memory used by the EdgeTransport.exe process

 **Resource**: **PrivateBytes**

 **Description**: Monitors the percentage of memory that's used by the EdgeTransport.exe process that's part of the Microsoft Exchange Transport service. This doesn't include virtual memory in the paging file, or memory that's used by other processes.

 **Pressure transitions (%)**:

- **LowToMedium**: 72 

- **MediumToHigh**: 75 

- **HighToMedium**: 73 

- **MediumToLow**: 71 

 **Comments**:

By default, the high level of memory utilization by the EdgeTransport.exe process is 75 percent of the total physical memory or 1 terabyte, whichever is less. The results are always rounded down to the nearest integer.

Exchange keeps a history of the memory utilization of the EdgeTransport.exe process. If the utilization doesn't go down to low level for a specific number of polling intervals, known as the *history depth*, Exchange rejects incoming messages until the resource utilization goes back to the low level. By default, the history depth for EdgeTransport.exe memory utilization s 30 polling intervals.

### Number of messages in the Submission queue

 **Resource**: **QueueLength[SubmissionQueue]**

 **Description**: Monitors the number of messages in the Submission queue. Typically, message enter the Submission queue from Receive connectors. For more information, see [Mail flow and the transport pipeline](mail-flow.md). A large number of messages in the Submission queue indicates the categorizer is having difficulty processing messages.

 **Pressure transitions**:

- **LowToMedium**: 9999 

- **MediumToHigh**: 15000 

- **HighToMedium**: 10000 

- **MediumToLow**: 2000 

 **Comments**:

When the Submission queue is under pressure, the Exchange throttles incoming connections by delaying acknowledgement of incoming messages. Exchange reduces the rate of incoming message flow by *tarpitting*, which delays the acknowledgment of the SMTP **MAIL FROM** command to the sending server. If the pressure condition continues, Exchange gradually increases the tarpitting delay. After the Submission queue utilization returns to the low level, Exchange reduces the acknowledgment delay and eases back into normal operation. By default, Exchange delays message acknowledgments for 10 seconds when under Submission queue pressure. If the resource pressure continues, the delay is increased in 5-second increments up to 55 seconds.

Exchange keeps a history of Submission queue utilization. If the Submission queue utilization doesn't go down to the low level for a specific number of polling intervals, known as the *history depth*, Exchange stops the tarpitting delay and rejects incoming messages until the Submission utilization goes back to the low level. By default, the history depth for the Submission queue is in 300 polling intervals.

### Memory used by all processes

 **Resource**: **SystemMemory**

 **Description**: Monitors the percentage of memory that's used by all processes on the Exchange server. This doesn't include virtual memory in the paging file.

 **Pressure transitions (%)**:

- **LowToMedium**: 88 

- **MediumToHigh**: 94 

- **HighToMedium**: 89 

- **MediumToLow**: 84 

 **Comments**:

When the server reaches the high level of memory utilization, *message dehydration* occurs. Message dehydration removes unnecessary elements of queued messages that are cached in memory. Typically, complete messages are cached in memory for increased performance. Removal of the MIME content from these cached messages reduces the amount of memory that's used at the expense of higher latency, because the messages are now read directly from the message queue database. By default, message dehydration is enabled.

### Hard drive utilization for the drive that holds the message queue database transaction logs

 **Resource**: **UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue]**

 **Description**: Monitors the percentage of total drive space that's consumed by all files on the drive that holds the message queue database transaction logs. To change the default location, see [Change the location of the queue database](queues/relocate-queue-database.md).

 **Pressure transitions (%)**:

- **LowToMedium**: 89 

- **MediumToHigh**: 99 

- **HighToMedium**: 90 

- **MediumToLow**: 80 

 **Comments:**:

The default high level of hard drive utilization is calculated by using the following formula:

100 \* (_\<hard drive size in MB\>_ - 1152 MB) / _\<hard drive size in MB\>_

1 GB = 1024 MB. The result is rounded down to the nearest integer.

For example, if your queue database is located on a 1 terabyte (TB) drive (1048576 MB), the high level of utilization is 100\*(1048576-1152)/1048576) or 99%.

As you can see from the formula and the rounding down behavior, the hard drive needs to be fairly small before the formula calculates a high utilization value that's less than 99%. For example, a 98% value for high utilization requires a hard drive of approximately 56 GB or less.

The `%ExchangeInstallPath%Bin\EdgeTransport.exe.config` application configuration file contains the _DatabaseCheckPointDepthMax_ key that has the default value `384MB`. This key controls the total allowed size of all uncommitted transaction logs that exist on the hard drive. The value of this key is used in the formula that calculates high utilization. If you customize this value, the formula becomes:

100 \* (_\<hard drive size in MB\>_ - Min(5120 MB, 3\* _DatabaseCheckPointDepthMax_)) / _\<hard drive size in MB\>_

> [!NOTE]
> The value of the _DatabaseCheckPointDepthMax_ key applies to all transport-related Extensible Storage Engine (ESE) databases that exist on the Exchange server. On Mailbox servers, this includes the message queue database, and the sender reputation database. On Edge Transport servers, this includes the message queue database, the sender reputation database, and the IP filter database that's used by the Connection Filtering agent.

### Hard drive utilization for the drive that's used for content conversion

 **Resource**: **UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data]**

 **Description**: Monitors the percentage of total drive space that's consumed by all files on the drive that's used for content conversion. The default location of the folder is `%ExchangeInstallPath%TransportRoles\data\Temp` and is controlled by the _TemporaryStoragePath_ key in the `%ExchangeInstallPath%Bin\EdgeTransport.exe.config` application configuration file.

 **Pressure transitions (%)**:

- **LowToMedium**: 89 

- **MediumToHigh**: 99 

- **HighToMedium**: 90 

- **MediumToLow**: 80 

 **Comments**:

The default high level of hard drive utilization is calculated by using the following formula:

100 \* (_\<hard drive size in MB\>_ - 500 MB) / _\<hard drive size in MB\>_

1 GB = 1024 MB. The result is rounded down to the nearest integer.

For example, if your message queue database is located on a 1 terabyte (TB) drive (1048576 MB), the high level of utilization is 100\*(1048576-500)/1048576) or 99%.

As you can see from the formula and the rounding down behavior, the hard drive needs to be very small before the formula calculates a high utilization value that's less than 99%. For example, a 98% value for high utilization requires a hard drive of approximately 25 GB or less.

### Number of uncommitted message queue database transactions in memory

 **Resource**: **UsedVersionBuckets[%ExchangeInstallPath%TransportRoles\data\Queue\mail.queue]**

 **Description**: Monitors the number of uncommitted transactions for the message queue database that exist in memory.

 **Pressure transitions**:

- **LowToMedium**: 999 

- **MediumToHigh**: 1500 

- **HighToMedium**: 1000 

- **MediumToLow**: 800 

 **Comments:**:

A list of changes that are made to the message queue database is kept in memory until those changes can be committed to a transaction log. Then the list is committed to the message queue database itself. These outstanding message queue database transactions that are kept in memory are known as *version buckets*. The number of version buckets may increase to unacceptably high levels because of an unexpectedly high volume of incoming messages, spam attacks, problems with the message queue database integrity, or hard drive performance.

When version buckets are under pressure, the Exchange server throttles incoming connections by delaying acknowledgment of incoming messages. Exchange reduces the rate of incoming message flow by *tarpitting*, which delays the acknowledgment of the SMTP **MAIL FROM** command to the sending server. If the resource pressure condition continues, Exchange gradually increases the tarpitting delay. After the resource utilization returns to normal, Exchange gradually reduces the acknowledgement delay and eases back into normal operation. By default, Exchange delays message acknowledgments for 10 seconds when under resource pressure. If the pressure continues, the delay is increased in 5-second increments up to 55 seconds.

When the version buckets are under high pressure, the Exchange server also stops processing outgoing messages.

Exchange keeps a history of version bucket resource utilization. If the resource utilization doesn't go down to the low level for a specific number of polling intervals, known as the *history depth*, Exchange stops the tarpitting delay and rejects incoming messages until the resource utilization goes back to the low level. By default, the history depth for version buckets is in 10 polling intervals.

## Actions taken by back pressure when resources are under pressure
<a name="Pressure"> </a>

The following table summarizes the actions taken by back pressure when a monitored resource is under pressure.

|**Resource under pressure**|**Utilization level**|**Actions taken**|
|:-----|:-----|:-----|
|**DatabaseUsedSpace** <br/> |Medium  <br/> |Reject incoming messages from non-Exchange servers.  <br/> Reject message submissions from the Pickup directory and the Replay directory.  <br/> Message resubmission is paused.  <br/> Shadow Redundancy rejects messages. For more information about Shadow Redundancy, see [Shadow redundancy in Exchange Server](transport-high-availability/shadow-redundancy.md).  <br/> |
|**DatabaseUsedSpace** <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> |
|**PrivateBytes** <br/> |Medium  <br/> |Reject incoming messages from non-Exchange servers.  <br/> Reject message submissions from the Pickup directory and the Replay directory.  <br/> Message resubmission is paused.  <br/> Shadow Redundancy rejects messages.  <br/> Processing messages after a server or Transport service restart (also known as *boot scanning*) is paused.  <br/> Start message dehydration.  <br/> |
|**PrivateBytes** <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> |
|**QueueLength[SubmissionQueue]** <br/> |Medium  <br/> |Introduce or increment the tarpitting delay to incoming messages. If normal level isn't reached for the entire Submission queue history depth, take the following actions:  <br/> • Reject incoming messages from non-Exchange servers.  <br/> • Reject message submissions from the Pickup directory and the Replay directory.  <br/> • Message resubmission is paused.  <br/> • Shadow Redundancy rejects messages.  <br/> • Boot scanning is paused.  <br/> |
|**QueueLength[SubmissionQueue]** <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> Flush enhanced DNS cache from memory.  <br/> Start message dehydration.  <br/> |
|**SystemMemory** <br/> |Medium  <br/> |Start message dehydration.  <br/> Flush caches.  <br/> |
|**SystemMemory** <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> |
|**UsedDiskSpace** (message queue database transaction logs)  <br/> |Medium  <br/> |Reject incoming messages from non-Exchange servers.  <br/> Reject message submissions from the Pickup directory and the Replay directory.  <br/> Message resubmission is paused.  <br/> Shadow Redundancy rejects messages.  <br/> |
|**UsedDiskSpace** (message queue database transaction logs)  <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> |
|**UsedDiskSpace** (content conversion)  <br/> |Medium  <br/> |Reject incoming messages from non-Exchange servers.  <br/> Reject message submissions from the Pickup directory and the Replay directory.  <br/> |
|**UsedDiskSpace** (content conversion)  <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> |
|**UsedVersionBuckets** <br/> |Medium  <br/> |Introduce or increment the tarpitting delay to incoming messages. If normal level isn't reached for the entire version bucket history depth, take the following actions:  <br/> • Reject incoming messages from non-Exchange servers.  <br/> • Reject message submissions from the Pickup directory and the Replay directory.  <br/> |
|**UsedVersionBuckets** <br/> |High  <br/> |All actions taken at the medium utilization level.  <br/> Reject incoming messages from other Exchange servers.  <br/> Reject message submissions from mailbox databases by the Microsoft Exchange Mailbox Transport Submission service on Mailbox servers.  <br/> Stop processing outgoing messages.  <br/> Remote delivery is paused.  <br/> |
 
## View back pressure resource thresholds and utilization levels
<a name="Pressure"> </a>

You can use the **Get-ExchangeDiagnosticInfo** cmdlet in the Exchange Management Shell to view the resources that are being monitored, and the current utilization levels. To learn how to open the Exchange Management Shell in your on-premises Exchange organization, see [Open the Exchange Management Shell](https://docs.microsoft.com/powershell/exchange/exchange-server/open-the-exchange-management-shell).

To view the back pressure settings on an Exchange server, run the following command:

```
[xml]$bp=Get-ExchangeDiagnosticInfo [-Server <ServerIdentity> ] -Process EdgeTransport -Component ResourceThrottling; $bp.Diagnostics.Components.ResourceThrottling.ResourceTracker.ResourceMeter
```

To see the values on the local server, you can omit the _Server_ parameter.

## Back pressure configuration settings in the EdgeTransport.exe.config file
<a name="File"> </a>

All configuration options for back pressure are done in the `%ExchangeInstallPath%Bin\EdgeTransport.exe.config` XML application configuration file. However, few of the settings exist in the file by default.

> [!CAUTION]
> These settings are listed only as a reference for the default values. We strongly discourage any modifications to the back pressure settings in the EdgeTransport.exe.config file. Modifications to these settings might result in poor performance or data loss. We recommend that you investigate and correct the root cause of any back pressure events that you may encounter.

**General back pressure settings**

|**Key name**|**Default value**|
|:-----|:-----|
| _ResourceMeteringInterval_ <br/> | `00:00:02` (2 seconds)  <br/> |
| _DehydrateMessagesUnderMemoryPressure_ <br/> |true  <br/> |
 
**DatabaseUsedSpace settings**

|**Key name**|**Default value (%)**|
|:-----|:-----|
| _DatabaseUsedSpace.LowToMedium_ <br/> |96  <br/> |
| _DatabaseUsedSpace.MediumToHigh_ <br/> |99  <br/> |
| _DatabaseUsedSpace.HighToMedium_ <br/> |97  <br/> |
| _DatabaseUsedSpace.MediumToLow_ <br/> |94  <br/> |
 
**PrivateBytes settings**

|**Key name**|**Default value (%)**|
|:-----|:-----|
| _PrivateBytes.LowToMedium_ <br/> |72  <br/> |
| _PrivateBytes.MediumToHigh_ <br/> |75  <br/> |
| _PrivateBytes.HighToMedium_ <br/> |73  <br/> |
| _PrivateBytes.MediumToLow_ <br/> |71  <br/> |
| _PrivateBytesHistoryDepth_ <br/> |30  <br/> |
 
**QueueLength[SubmissionQueue] settings**

|**Key name**|**Default value**|
|:-----|:-----|
| _QueueLength[SubmissionQueue].LowToMedium_ <br/> |9999  <br/> |
| _QueueLength[SubmissionQueue].MediumToHigh_ <br/> |15000  <br/> |
| _QueueLength[SubmissionQueue].HighToMedium_ <br/> |10000  <br/> |
| _QueueLength[SubmissionQueue].MediumToLow_ <br/> |2000  <br/> |
| _SubmissionQueueHistoryDepth_ <br/> |300 (after 10 minutes)  <br/> |
 
**SystemMemory settings**

|**Key name**|**Default value (%)**|
|:-----|:-----|
| _SystemMemory.LowToMedium_ <br/> |88  <br/> |
| _SystemMemory.MediumToHigh_ <br/> |94  <br/> |
| _SystemMemory.HighToMedium_ <br/> |89  <br/> |
| _SystemMemory.MediumToLow_ <br/> |84  <br/> |
 
**UsedDiskSpace settings (message queue database transaction logs)**

|**Key name**|**Default value (%)**|
|:-----|:-----|
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue].LowToMedium_ <br/> |89  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue].MediumToHigh_ <br/> |99  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue].HighToMedium_ <br/> |90  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data\Queue].MediumToLow_ <br/> |80  <br/> |
 
> [!NOTE]
> Values that contain only `UsedDiskSpace` (for example, `UsedDiskSpace.MediumToHigh`) apply to the message queue database transaction logs and to content conversion.

**UsedDiskSpace settings (content conversion)**

|**Key name**|**Default value (%)**|
|:-----|:-----|
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data].LowToMedium_ <br/> |89  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data].MediumToHigh_ <br/> |99  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data].HighToMedium_ <br/> |90  <br/> |
| _UsedDiskSpace[%ExchangeInstallPath%TransportRoles\data].MediumToLow_ <br/> |80  <br/> |
|TemporaryStoragePath  <br/> | `%ExchangeInstallPath%TransportRoles\data\Temp` <br/> |
 
**UsedVersionBuckets settings**

|**Key name**|**Default value**|
|:-----|:-----|
| _UsedVersionBuckets.LowToMedium_ <br/> |999  <br/> |
| _UsedVersionBuckets.MediumToHigh_ <br/> |1500  <br/> |
| _UsedVersionBuckets.HighToMedium_ <br/> |1000  <br/> |
| _UsedVersionBuckets.MediumToLow_ <br/> |800  <br/> |
| _VersionBucketsHistoryDepth_ <br/> |10  <br/> |
 
## Back pressure logging information
<a name="Information"> </a>

The following list describes the event log entries that are generated by specific back pressure events in Exchange:

- **Event log entry for an increase in any resource utilization level**

    Event Type: Error

    Event Source: MSExchangeTransport

    Event Category: Resource Manager

    Event ID: 15004

    Description: Resource pressure increased from _\<Previous Utilization Level\>_ to _\<Current Utilization Level\>_.

- **Event log entry for a decrease in any resource utilization level**

    Event Type: Information

    Event Source: MSExchangeTransport

    Event Category: Resource Manager

    Event ID: 15005

    Description: Resource pressure decreased from _\<Previous Utilization Level\>_ to _\<Current Utilization Level\>_.

- **Event log entry for critically low available disk space**

    Event Type: Error

    Event Source: MSExchangeTransport

    Event Category: Resource Manager

    Event ID: 15006

    Description: The Microsoft Exchange Transport service is rejecting messages because available disk space is below the configured threshold. Administrative action may be required to free disk space for the service to continue operations.

- **Event log entry for critically low available memory**

    Event Type: Error

    Event Source: MSExchangeTransport

    Event Category: Resource Manager

    Event ID: 15007

    Description: The Microsoft Exchange Transport service is rejecting message submissions because the service continues to consume more memory than the configured threshold. This may require that this service be restarted to continue normal operation.


