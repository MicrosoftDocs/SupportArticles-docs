---
title: Unable to migrate mailboxes using IMAP
description: Fixes an issue in which you can't create an IMAP migration endpoint when you migrate mailboxes to Exchange Online by using the IMAP4 protocol.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 147284
  - CSSTroubleshoot
ms.reviewer: mireb
appliesto: 
  - Exchange Server 2010
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't migrate IMAP mailboxes from Exchange Server 2010 to Exchange Online

IMAP for Exchange Server 2010 is hardcoded to use the TLS 1.0 protocol, whereas Exchange Online has deprecated both TLS 1.0 and TLS 1.1 as legacy protocols. Exchange Online now uses only the newer version TLS 1.2.

Therefore, you can't migrate mailboxes that are hosted on Exchange Server 2010 to Exchange Online by using the IMAP4 protocol. If you try to do this, you will experience the following issues:

- You can't create an IMAP migration endpoint in Exchange Online.
- You notice a TLS protocol-related incompatibility between Exchange Online and Exchange 2010 IMAP if you run the SSL test on the Remote Connectivity Analyzer for port 993 and the Exchange Server 2010 FQDN.
- The target server is unavailable for IMAP migration.

  When you run the following cmdlet in Exchange Online PowerShell to check the target server availability, you see a TLS negotiation error message because of a cipher suites mismatch.

  ```powershell
  Test-MigrationServerAvailability -IMAP -Port 993 -RemoteServer <mail.contoso.com>
  ```

  **Error message:**

  :::image type="content" source="media/imap-mailbox-migration-fails/error-message.png" alt-text="Screenshot of the error message after running cmdlet.":::  

To migrate mailboxes from Exchange Server 2010 to Exchange Online, you have the following options:

- Cutover migration: Uses the RPC/HTTP protocol
- Hybrid migration: Uses the MRS protocol  
- PST import service to migrate PST files

For more information about these methods, see [Migrate multiple email accounts](/exchange/mailbox-migration/mailbox-migration).
