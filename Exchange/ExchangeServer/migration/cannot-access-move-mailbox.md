---
title: Can't access or move a mailbox after mailbox server is added to a DAG
description: Describes mailbox access or move errors on a newly created database in a database availability group (DAG).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CI 156012
  - CI 10026
  - CI 9823
  - CSSTroubleshoot
ms.reviewer: dpaul, batre, meerak, v-chazhang, v-kccross
appliesto: 
  - Exchange Server 2019
search.appverid: MET150
ms.date: 04/01/2026
---

# "NoSupportException" error when you access a mailbox on a newly created database in a DAG

## Summary

This article describes issues that might occur when you access or move mailboxes in Exchange Server and provides a solution. The issues occur because the schema version value of the mailbox database is incorrect. Administrators can resolve the issues by downloading and installing Cumulative Update 13 for Exchange Server 2019.

## Symptoms

After you add a Microsoft Exchange Server 2019 mailbox server as a node to a database availability group (DAG), and you create more mailbox databases, you experience the following issues:

- When you try to access a mailbox on the mailbox server by using Outlook on the web, you receive the following error message:

    > A problem occurred while you were trying to use your mailbox.  
    > X-OWA-Error Microsoft.Exchange.Data.Storage.NoSupportException

- When you try to move a mailbox to a database on the mailbox server, you receive the following error message:

    > Failed to communicate with the mailbox database. There is no support for this operation.

## Cause

These issues occur because the schema version value of the mailbox database is incorrect.

## Resolution

To resolve the issues, download and install [Cumulative Update 13 for Exchange Server 2019 (KB5026155)](https://www.microsoft.com/download/details.aspx?id=105180&msockid=2586c67be258611c3178d39ee3f36040).
