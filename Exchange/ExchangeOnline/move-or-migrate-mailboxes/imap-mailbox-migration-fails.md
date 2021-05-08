---
title: Unable to migrate mailboxes using IMAP
description: Fixes an issue in which you can't create an IMAP migration endpoint when you migrate mailboxes to Exchange Online by using the IMAP4 protocol.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
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
---
# Can't migrate IMAP mailboxes from Exchange Server 2010 to Exchange Online

IMAP for Exchange Server 2010 is hardcoded to use the TLS 1.0 protocol whereas Exchange Online has deprecated both TLS 1.0 and TLS 1.1 which are legacy protocols. Exchange Online only uses the newer version TLS 1.2 now.  

Therefore, you won't be able to migrate mailboxes that are hosted on Exchange Server 2010 to Exchange Online using the IMAP4 protocol, and will encounter the following issues:

- Unable to create an IMAP migration endpoint in Exchange Online.
- TLS protocol related incompatibility between Exchange Online and Exchange 2010 IMAP if you run the SSL test on Remote Connectivity Analyzer for port 993 and the Exchange Server 2010 FQDN.
- Target server unavailable for IMAP migration:

  When you run the following cmdlet in Exchange Online PowerShell to check the target server's availability, you see a TLS negotiation error message because of cipher suits mismatch.

  ```powershell
  Test-MigrationServerAvailability -IMAP -Port 993 -RemoteServer <mail.contoso.com>
  ```

  **Error message:**

  > Microsoft.Exchange.Migration.MigrationServerConnectionFailedException: The connection to the server 'mail.contoso.com' could not be completed. Microsoft.Exchange.Connections.Common.RemoteNetworkErrorTransientException: We were unable to reach your email provider. Please check your server settings, or try again later.  
  > Microsoft.Exchange.Connections.Common.SslStreamFailureException: TLS negotiation failed.  
  > System.ComponentModel.Win32Exception: The client and server cannot communicate, because they do not possess a common algorithm.  

To migrate mailboxes from Exchange Server 2010 to Exchange Online, you have the following options:

- Cutover migration - which uses the RPC/HTTP protocol
- Hybrid migration – which uses the MRS protocol  
- PST import service to migrate PST files

For details about these methods, see [Migrate multiple email accounts](/exchange/mailbox-migration/mailbox-migration).
