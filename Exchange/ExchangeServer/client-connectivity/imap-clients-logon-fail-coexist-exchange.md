---
title: IMAP clients fail to logon when Exchange Server 2010 coexists with Exchange Server 2016
description: IMAP clients are repeatedly prompted for authentication credentials. This article provides two solutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 116132
  - CSSTroubleshoot
ms.reviewer: akashb, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2010
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# IMAP clients fail to logon when Exchange Server 2010 coexists with Exchange Server 2016

## Symptoms

Internet Mail Access Protocol (IMAP) clients are repeatedly prompted for authentication credentials under the following conditions:

- A Microsoft Exchange Server 2010 coexists with a Microsoft Exchange Server 2016 environment.
- The affected user's mailbox is hosted on Exchange 2010 servers, and the connectivity endpoint is in Exchange 2016 server.
- A Windows Challenge/Response (NTLM) authentication method is used.

## Cause

Exchange 2016 server doesn't support NTLM or Kerberos authentication methods when authenticating proxy requests on Exchange 2010 servers.

## Resolution

### Method 1

1. Set **EnableGSSAPIAndNTLMAuth** to **False** on the Exchange Server 2016 server by running the following cmdlet:

    ```powershell
    Set-IMAPSettings -EnableGSSAPIAndNTLMAuth $false
    ```

2. Restart the following IMAP services on the Exchange 2016 server:

    - Microsoft Exchange IMAP4 (MSExchangeImap4)
    - Microsoft Exchange IMAP4 Backend (MSExchangeIMAP4BE)

> [!NOTE]
> You might have to set the **LoginType** to **PlainTextAuthentication** if you're using nonsecure (TCP 143) IMAP. This applies mostly to older IMAP clients. If **SecureLogin** is set, the IMAP client must do a **STARTTLS** before authentication. Clients that don't support **STARTTLS** need to set the **LoginType** to **PlainTextAuthentication**.

### Method 2

Move the affected mailboxes to Exchange 2016 servers.
