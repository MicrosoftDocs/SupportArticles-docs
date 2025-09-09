---
title: VSS_E_WRITERERROR_RETRYABLE when backing up
description: When you try to back up a passive database copy in an Exchange DAG, you receive the VSS_E_WRITERERROR_RETRYABLE error message. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help with Backup
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, jarrettr, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# VSS_E_WRITERERROR_RETRYABLE error when backing up a passive database copy in an Exchange DAG

_Original KB number:_ &nbsp; 4037535

## Symptoms

You have a DAG in Exchange Server 2013 or Exchange Server 2016. The DAG has a mailbox database copy that resides on a remote site. When you try to back up a passive database copy, the backup fails, and you observe the following issues.

- You receive this error message:

    > Writer name: 'Microsoft Exchange Writer'  
Writer Id: WriterId  
Writer Instance Id: WriterInstanceId  
State: [1] Stable  
Last error: Retryable error

- If you run the BETEST tool, this message is returned:

    > Status for writer Microsoft Exchange Writer: STABLE(0x800423f3 - VSS_E_WRITERERROR_RETRYABLE)

- On the Exchange server that initiates the backup of a passive database copy, event 2153 is logged in the Application log:

    > Log Name: Application  
Source: MSExchangeRepl  
Date: Date  
Event ID: 2153  
Task Category: Service  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: ComputerName  
Description: The log copier was unable to communicate with server \<FQDN of the Active Server>. The copy of database \<Mailbox Database\Local Server> is in a disconnected state. The communication error was: An error occurred while communicating with server \<Active server>. Error: Unable to read data from the transport connection: An established connection was aborted by the software in your host machine. The copier will automatically retry after a short delay.

> [!NOTE]
> This article uses passive database server to refer to the Exchange server that initiates the backup of a passive database copy and active database server to refer to the Exchange server that hosts the active database.

## Cause

This issue may occur because of network issues that block or interrupt communication on the remote procedure call (RPC) channel between the passive database server and the active database server. See the DAG backup considerations section for explanation of the RPC channel.

## Resolution

To resolve this problem, use the following guidance:

- Check your network topology and stability between the Exchange servers.
- Security software that has network scanning functionality can cause the issue. Check if the software is configured correctly.
- Network settings should give the Exchange servers and the network devices enough time to initiate backups and to communicate with other Exchange servers in the DAG.
- The value of the [KeepAliveTime](/previous-versions/windows/it-pro/windows-2000-server/cc957549(v=technet.10)) registry entry on the Exchange servers should be less than the idle session timeout that is configured on the network devices. We recommend that the value of the `KeepAliveTime` registry entry be more than 15 minutes.

For better tolerance on possible networking or performance issues, increase the timeout value for queries on the range of transaction logs. The default value is 30 seconds. To increase the timeout value, follow these steps:

1. In Registry Editor, browse to the following registry subkey:

    `HKEY_LOCAL_MACHINE\ SOFTWARE\Microsoft\ExchangeServer\v15\Replay\Parameters`

2. Create a registry key of **DWORD (32-bit) Value**.
3. Set the name of the registry key to **QueryLogRangeTimeoutInMsec**.
4. Set the value to 120,000, which means 120 seconds. (Or you can set a different value, depending on your business needs.)
5. Restart the Microsoft Exchange Replication Service (msexchangerepl).

## DAG backup considerations

To initiate backup of a passive database copy, the Exchange replication service on the passive database server creates a query to get the range of transaction logs on the active database server. If the active database server is busy, the query may take longer than expected, especially if there are many log files. Then, the Exchange replication service opens an RPC channel to the active database server to inform the server that a backup is in progress. The RPC channel should be open during the backup.

Consider the following points about DAG backups:

- Use passive database copies for backups. We don't recommend that you back up active database copies. Active database copies should be dedicated to ongoing business operations.
- If you must back up active database copies for some reason, make sure that the passive database copies are not configured for backup at the same time. Otherwise, you will experience backup failure and the **RETRYABLE** error.
- During backup, databases shouldn't be moved to another Exchange server in the DAG.
- Network connections should be active and stable.
