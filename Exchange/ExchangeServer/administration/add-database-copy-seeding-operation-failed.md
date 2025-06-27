---
title: Error (The seeding operation failed) when running Add-MailboxDatabaseCopy command
description: Provide a workaround to an issue in which you receive an error message stating The seeding operation failed when running Add-MailboxDatabaseCopy command.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: dpaul, v-six
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help Configuring DAG
  - CSSTroubleshoot
  - CI 124887
  - Exchange Server
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---

# Error when running Add-MailboxDatabaseCopy command: The seeding operation failed

## Symptoms

In Microsoft Exchange Server 2019, 2016, or 2013, you run the `Add-MailboxDatabaseCopy` cmdlet to copy a mailbox database from one mailbox server and seed another server. After you run the cmdlet, you receive the following error message in Exchange Management Shell:

> The seeding operation failed. Error: An error occurred while running prerequisite checks. Error: The specified database isn't configured for replication and therefore cannot be used to perform seed operations. [Database: DB01, Server:  Contoso-E16B.Contoso.com]  
>    \+ CategoryInfo          : InvalidOperation: (DB01:String) [Add-MailboxDatabaseCopy], InvalidDbForSeedSpecifiedException  
>    \+ FullyQualifiedErrorId : [Server=Contoso-E16A,  RequestId=5acbfa9e-76ac-497a-82c2-26cbaa31xxxx,TimeStamp=mm/dd/yy 2:22:36 PM][FailureCategory=Cmdlet-InvalidDbForSeedSpecifiedException] FFCD68C3,Microsoft.Exchange. Management.SystemConfigurationTasks.AddMailboxDatabaseCopy  
>    \+ PSComputerName        : Contoso-e16a.Contoso.com

## Cause

This error occurs if the source and target servers point to different domain controllers.

When the source server creates a copy of the mailbox database, the target server flushes its cache and updates its content. The cache has to be flushed during the default time-out that occurs between running the `Add-MailboxDatabaseCopy` cmdlet and starting the seeding process. If the cache is not flushed within this timeframe, the target server doesn't see the updated information. This situation generates the error message.

Eventually, the cache is flushed within the appropriate timeframe, and the copy of the mailbox server is seeded on the target server.

## Status

The copy operation itself is not affected by this error. Therefore, the error message can be safely ignored.

## Workaround

You can avoid this error by running the `Add-MailboxDatabaseCopy` cmdlet with the `ConfigurationOnly` switch.

```powershell
Add-MailboxDatabaseCopy DB01 -MailboxServer Contoso-E16B -ConfigurationOnly
```

This cmdlet adds a copy of the mailbox database without invoking automatic seeding. In this example, a copy of mailbox database DB01 is added to mailbox server Contoso-E16B.

Next, run the following cmdlet to suspend the copy of the database on the target server to be able to allow the seeding of the copy:

```powershell
Suspend-MailboxDatabaseCopy -Identity DB01\Contoso-E16B
```

Next, run the following cmdlet to seed a copy of the database on the target mailbox server:

```powershell
Update-MailboxDatabaseCopy -Identity DB01\Contoso-E16B
```

In this example, a copy of database DB01 seeds mailbox server Contoso-E16B.

## More information

To determine which domain controller is being used by a server that's running Exchange, run the following cmdlet on a local computer:

```powershell
Get-ExchangeServer -Status -Identity $env:COMPUTERNAME | Format-Table CurrentDomainController
```

For more information, see [Add-MailboxDatabaseCopy](/powershell/module/exchange/add-mailboxdatabasecopy?view=exchange-ps&preserve-view=true).
