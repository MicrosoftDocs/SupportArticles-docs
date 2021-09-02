---
title:  Cannot find a recipient that has mailbox GUID when creating public folder endpoint
description: Works around an error that occurs when running the New-MigrationEndpoint cmdlet for the public folder migration.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 156331
- Exchange Online
- CSSTroubleshoot
ms.reviewer: meerak; batre
appliesto: 
- Exchange Online via Office 365 E Plans
- Exchange Online via Office 365 P Plans
search.appverid: MET150
---

# "Cannot find a recipient that has mailbox GUID" error when creating migration endpoint

## Symptoms

You're migrating public folders from a Microsoft Exchange 2019, Exchange 2016, Exchange 2013, or Exchange 2010 on-premises server to Exchange Online. When you run the following cmdlet to create a migration endpoint:

```powershell
New-MigrationEndpoint -Name <PublicFolderEndpoint> -PublicFolder -RemoteServer <mail.contoso.com> -Credentials $c
```

You receive the following error message:

> cmdlet New-MigrationEndpoint at command pipeline position 1  
> Supply values for the following parameters:  
> Name: PublicFolderEndpoint  
> Cannot find a recipient that has mailbox GUID '\<GUID\>'.

## Cause

The issue might occur if you run the `New-MigrationEndpoint` cmdlet immediately after creating target public folder mailboxes in Exchange Online.

## Workaround

It's a transient issue and will be fixed once the Active Directory (AD) replication is completed successfully. Wait for an hour and try to create the migration endpoint again.
