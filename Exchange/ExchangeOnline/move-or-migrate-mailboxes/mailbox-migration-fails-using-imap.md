---
title: Unable to migrate mailboxes using IMAP
description: Fixes an issue in which you can create an IMAP migration endpoint when migrate mailboxes to Exchange Online by using the IMAP4 protocol.
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
# You can't migrate mailboxes from Exchange Server 2010 to Exchange Online by using IMAP

## Symptoms

When you migrate mailboxes that are hosted in Exchange Server 2010 to Exchange Online by using the IMAP4 protocol, you experience the following issues:

- You can't create an IMAP migration endpoint by using one of the following methods:

  - [Connect Microsoft 365 or Office 365 to your email system](/exchange/mailbox-migration/migrating-imap-mailboxes/migrate-other-types-of-imap-mailboxes#step-3-connect-microsoft-365-or-office-365-to-your-email-system)
  - [Create an IMAP migration endpoint](/microsoft-365/enterprise/use-powershell-to-perform-an-imap-migration-to-microsoft-365#step-3-create-an-imap-migration-endpoint)

- When you run the `Test-MigrationServerAvailability` cmdlet to test the connection settings to your IMAP server, you receive the "TLS negotiation failed" error message.

    For example, you run the following cmdlet in Exchange Online PowerShell::

    ```powershell
    Test-MigrationServerAvailability -IMAP -Port 993 -RemoteServer <mail.contoso.com>
    ```

    In this scenario, you receive the following error message:

    > Microsoft.Exchange.Migration.MigrationServerConnectionFailedException: The connection to the server '\<mail.contoso.com>' could not be completed.  
    > Microsoft.Exchange.Connections.Common.RemoteNetworkErrorTransientException: We were unable to reach your email provider. Please check your server settings, or try again later.  
    > Microsoft.Exchange.Connections.Common.SslStreamFailureException: TLS negotiation failed.  
    > System.ComponentModel.Win32Exception: **The client and server cannot communicate, because they do not possess a common algorithm**.

    **Note:** The error message "The client and server cannot communicate, because they do not possess a common algorithm" indicates the cipher suits mismatch.

- When you run the [SSL Server Test](https://testconnectivity.microsoft.com/tests/SslServer/input) for your Exchange 2010 server with the port 993, you see an incompatibility related to Transport Layer Security (TLS) protocol between Office 365 and Exchange Server 2010 IMAP in the result.

## Cause

Exchange Online has deprecated legacy protocols TLS 1.0 and TLS 1.1, and it uses TLS 1.2. IMAP for Exchange Server 2010 is hardcoded to TLS 1.0, and it doesn't support TLS 1.2. Therefore, you can't connect to the IMAP mail server when doing the IMAP migration.

## Workaround

To migrate mailboxes from Exchange Server 2010 to Exchange Online, use either of the following migration methods that are described in [ways to migrate multiple email accounts to Microsoft 365 or Office 365](/exchange/mailbox-migration/mailbox-migration):

- A cutover migration that uses RPC over HTTP protocol. For more information about the steps, see [Migrate email using the Exchange cutover method](/exchange/mailbox-migration/cutover-migration-to-office-365).
- A hybrid Mailbox Replication Service (MRS) migration that uses full, minimal, and express flavors in Classic UI, or uses modern hybrid topologies. For more information about the steps, see either of the following articles:

  - [Use Minimal Hybrid to quickly migrate Exchange mailboxes to Microsoft 365 or Office 365](/exchange/mailbox-migration/use-minimal-hybrid-to-quickly-migrate)
  - [Use the Microsoft 365 and Office 365 mail migration advisor](/exchange/mail-migration-jump)

To migrate PST files to Exchange Online, use the [PST import service](/microsoft-365/compliance/importing-pst-files-to-office-365). For more information, see either of the following articles:

- [Use network upload to import PST files to Office 365](/microsoft-365/compliance/use-network-upload-to-import-pst-files)
- [Use drive shipping to import PST files](/microsoft-365/compliance/use-drive-shipping-to-import-pst-files-to-office-365)

## Related articles

- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365)
- [Exchange Server TLS guidance, part 1: Getting Ready for TLS 1.2](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-1-getting-ready-for-tls-1-2/ba-p/607649)
- [Exchange Server TLS guidance Part 2: Enabling TLS 1.2 and Identifying Clients Not Using It](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761)
- [Exchange Server TLS guidance Part 3: Turning Off TLS 1.0/1.1](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-3-turning-off-tls-1-0-1-1/ba-p/607898)
