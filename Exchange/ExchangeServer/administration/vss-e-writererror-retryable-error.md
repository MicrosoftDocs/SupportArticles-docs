---
title: VSS_E_WRITERERROR_RETRYABLE error when backing up
description: Resolves a situation in which you receive a VSS_E_WRITERERROR_RETRYABLE error message when you back up a passive database copy in an Exchange DAG.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:DAG Communication Issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11516
ms.reviewer: batre, jarrettr, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/12/2026
---

# VSS_E_WRITERERROR_RETRYABLE error when backing up a passive database copy in an Exchange DAG

_Original KB number:_ &nbsp; 4037535

In this article:

- The *passive database server* is the Exchange server that initiates the backup of a passive database copy.
- The *active database server* is the Exchange server that hosts the active database.

## Summary

Use this article when backups of passive mailbox database copies in a Microsoft Exchange Server Database Availability Group (DAG) fail and generate a VSS_E_WRITERERROR_RETRYABLE error. The article explains how to identify the issue by using backup output, BETEST, and Event ID 2153. It also provides configuration and network guidance to restore reliable communication between passive and active database servers during backup.

## Symptoms

You have a DAG in Exchange Server. The DAG has a mailbox database copy that is hosted on a remote site. When you try to back up a passive database copy, the backup fails, and you observe the following issues.

- You receive the following error message:

    > Writer name: 'Microsoft Exchange Writer'  
Writer Id: WriterId  
Writer Instance Id: WriterInstanceId  
State: [1] Stable  
Last error: Retryable error

- If you run the BETEST tool, you receive the following message:

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

## Cause

This issue might occur because of network issues that block or interrupt communication on the remote procedure call (RPC) channel between the passive database server and the active database server. For an explanation of the RPC channel, see the [DAG backup considerations](#dag-backup-considerations) section.

## Resolution

To resolve this problem, use the following guidance:

- Check your network topology and stability between the Exchange servers.
- Security software that has network scanning functionality can cause the issue. Make sure that the software is configured correctly.
- Network settings should give the Exchange servers and the network devices enough time to initiate backups and to communicate with other Exchange servers in the DAG.
- The value of the [KeepAliveTime](/previous-versions/windows/it-pro/windows-2000-server/cc957549(v=technet.10)) registry entry on the Exchange servers should be less than the idle session timeout that's configured on the network devices. The value of the `KeepAliveTime` registry entry should be more than 15 minutes.

For better tolerance on possible networking or performance issues, increase the timeout value for queries on the range of transaction logs. The default value is 30 seconds. To increase the timeout value, follow these steps:

1. In Registry Editor, browse to the following registry subkey:

    `HKEY_LOCAL_MACHINE\ SOFTWARE\Microsoft\ExchangeServer\v15\Replay\Parameters`

1. Create a registry key of **DWORD (32-bit) Value**.
1. Set the name of the registry key to **QueryLogRangeTimeoutInMsec**.
1. Set the value to 120,000 (120 seconds). You can set a different value, depending on your business needs.
1. Restart the Microsoft Exchange Replication Service (msexchangerepl).

## DAG backup considerations

To initiate a backup of a passive database copy, the Exchange replication service on the passive database server creates a query to get the range of transaction logs on the active database server. If the active database server is busy, the query might take longer than expected, especially if there are many log files. Then, the Exchange replication service opens an RPC channel to the active database server to inform the server that a backup is in progress. The RPC channel should be open during the backup.

Consider the following points about DAG backups:

- Use passive database copies for backups. Don't back up active database copies. Active database copies should be dedicated to ongoing business operations.
- If you must back up active database copies for some reason, make sure that the passive database copies aren't configured for backup at the same time. Otherwise, backup fails, and you receive the **RETRYABLE** error.
- During backup, don't move databases to another Exchange server in the DAG.
- Network connections should be active and stable.
