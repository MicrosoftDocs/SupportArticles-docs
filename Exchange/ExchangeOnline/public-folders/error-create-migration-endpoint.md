---
title: Cannot find a recipient that has mailbox GUID when creating public folder endpoint
description: Works around an error that occurs when you run the New-MigrationEndpoint cmdlet for the public folder migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 156331
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: meerak, batre, v-chazhang
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 01/24/2024
---

# "Cannot find a recipient that has mailbox GUID" error when creating migration endpoint

## Symptoms

Assume that you're migrating public folders from an on-premises server that's running Microsoft Exchange Server 2019, Exchange Server 2016, Exchange Server 2013, or Exchange Server 2010 to Exchange Online. You try to run the following cmdlet to create a migration endpoint:

```powershell
New-MigrationEndpoint -Name <PublicFolderEndpoint> -PublicFolder -RemoteServer <mail.contoso.com> -Credentials $c
```

However, you receive the following error message:

> cmdlet New-MigrationEndpoint at command pipeline position 1  
> Supply values for the following parameters:  
> Name: PublicFolderEndpoint  
> Cannot find a recipient that has mailbox GUID '\<GUID\>'.

## Cause

This issue might occur if you run the `New-MigrationEndpoint` cmdlet immediately after you create target public folder mailboxes in Exchange Online.

## Workaround

This is a transient issue that should discontinue after the Active Directory replication is completed successfully. Wait for an hour, and then try again to create the migration endpoint.
