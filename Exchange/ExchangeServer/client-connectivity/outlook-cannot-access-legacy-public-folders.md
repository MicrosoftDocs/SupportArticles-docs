---
title: Outlook can't access public folders hosted on legacy Exchange servers
description: Describes an issue that user mailboxes on Exchange 2013 or 2016 servers can't access public folders by using Microsoft Outlook. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: nickul, jmartin, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook can't access public folders hosted on legacy Exchange servers

_Original KB number:_ &nbsp;3177600

## Symptoms

Consider the following scenario:

- In your Microsoft Exchange environment, Exchange Server 2010 coexists with either Exchange Server 2013 or Exchange Server 2016.
- Public folders are hosted on the Exchange 2010 servers.
- Access to the legacy public folders has been configured according to the guidelines in [Configure legacy public folders where user mailboxes are on Exchange 2013 servers](/exchange/configure-legacy-public-folders-where-user-mailboxes-are-on-exchange-2013-servers-exchange-2013-help).
- There are multiple Exchange 2010 public folder databases.

In this scenario, users who have an Exchange 2013-based or Exchange 2016-based mailbox can't access public folders by using Microsoft Outlook.

## Cause

This issue occurs if the mailbox database that hosts the user's mailbox is configured for a public folder database that differs from the public folder discovery mailbox database.

## Resolution

To resolve this issue, configure the user's mailbox database to use the same public folder database as the discovery mailbox:

1. Assign a public folder discovery mailbox to the user's mailbox by using the `Set-Mailbox` cmdlet, as follows:

    ```powershell
    Set-Mailbox <User> -DefaultPublicFolderMailbox <ProxyMailbox>
    ```

1. Assign the public folder database for the user's mailbox database by using the `Set-MailboxDatabase` cmdlet, as follows:

    ```powershell
    Set-MailboxDatabase (Get-Mailbox <User>).Database -PublicFolderDatabase (Get-MailboxDatabase (Get-Mailbox <ProxyMailbox>).Database).PublicFolderDatabase
    ```

1. Run the following cmdlet to restart the Microsoft Exchange Rpc Client Access service on the server that's running Exchange Server that hosts the public folders:

    ```powershell
    Restart-Service MSExchangeRPC
    ```
