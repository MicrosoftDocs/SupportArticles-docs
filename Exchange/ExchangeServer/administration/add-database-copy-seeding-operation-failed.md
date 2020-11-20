---
title: Error (The seeding operation failed) when running Add-MailboxDatabaseCopy command
description: Provide a workaround to an issue in which you receive an error message stating "The seeding operation failed" when running Add-MailboxDatabaseCopy command.
author: TobyTu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: dpaul
ms.custom: 
- CSSTroubleshoot
- CI 124887
appliesto:
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
---

# Error when running Add-MailboxDatabaseCopy command: The seeding operation failed

## Symptoms

In Microsoft Exchange Server 2013, 2016 or 2019, you are trying to add a mailbox database copy by using `Add-MailboxDatabaseCopy` cmdlet. When the source and target Exchange Server is pointed to a different Domain Controller, you can receive an error message in Exchange Management Shell that resembles the following:

> The seeding operation failed. Error: An error occurred while running prerequisite checks. Error: The specified database isn't configured for replication and therefore cannot be used to perform seed operations. [Database: DB01, Server:  Contoso-E16B.Contoso.local]  
    + CategoryInfo          : InvalidOperation: (DB01:String) [Add-MailboxDatabaseCopy],   InvalidDbForSeedSpecifiedException  
    + FullyQualifiedErrorId : [Server=Contoso-E16A,  RequestId=5acbfa9e-76ac-497a-82c2-26cbaa31xxxx,TimeStamp=mm/dd/yy 2:22:36 PM]   [FailureCategory=Cmdlet-InvalidDbForSeedSpecifiedException] FFCD68C3,Microsoft.Exchange.  Management.SystemConfigurationTasks.AddMailboxDatabaseCopy  
    + PSComputerName        : Contoso-e16a.Contoso.local

## Cause

The MSExchangeRepl.exe uses a caching feature of the current replica copies. The cache has not been flushed in two minutes (default timeout) for running this cmdlet.

## Workaround

The error can be safely ignored because the replica of the database is created successfully by using `Add-MailboxDatabaseCopy` cmdlet. If you want to avoid running into this error, run the following cmdlets:

```powershell
Add-MailboxDatabaseCopy DB01 -MailboxServer Contoso-E16B -ConfigurationOnly
```

This example adds a copy of mailbox database DB01 to the Mailbox server Contoso-E16B and allows database copies to be added without invoking automatic seeding.

```powershell
Update-MailboxDatabaseCopy -Identity DB01\Contoso-E16B
```

This example seeds a copy of the database DB01 on the Mailbox server Contoso-E16B.

## More information

To determine which Domain Controller being used by the Exchange Server, run the following cmdlet separately on the local machine:

```powershell
Get-ExchangeServer -Status -Identity $env:ServerName | Format-Table CurrentDomainController
```

For more information about `Add-MailboxDatabaseCopy` cmdlet, see [this article](https://docs.microsoft.com/powershell/module/exchange/add-mailboxdatabasecopy?view=exchange-ps&preserve-view=true).
