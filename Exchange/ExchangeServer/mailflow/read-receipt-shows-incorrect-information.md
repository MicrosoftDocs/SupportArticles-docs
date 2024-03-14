---
title: Outlook read receipt shows incorrect information
description: Resolves an issue in which an email read receipt shows incorrect information.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 174527
  - Exchange Server
  - Outlook for Windows
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: sofiamenezes, arindamt, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Outlook on the web
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365 for Mac
  - Outlook 2021 for Mac
  - Outlook 2019 for Mac
  - Outlook for iOS
  - Outlook for Android
search.appverid: MET150
ms.date: 01/24/2024
---

# Outlook read receipt shows incorrect information

## Symptoms

In Outlook, you request a read receipt for an email message that you send to an external recipient, but the received receipt incorrectly describes your message:

- The **To** field that specifies the recipients of your message is empty.

- The **Sent** field shows a timestamp that's later than when you actually sent the message. Also, the "sent" timestamp might be later than the "read" timestamp.

For example, the read receipt might contain the following text:

> Your message
>
> &nbsp;&nbsp;To:
>
> &nbsp;&nbsp;Subject: Read receipt test
>
> &nbsp;&nbsp;Sent: Monday, February 13, 2023 3:53:45 PM (UTC+00:00) Monrovia, Reykjavik
>
> was read on Monday, February 13, 2023 3:53:42 PM (UTC+00:00) Monrovia, Reykjavik.

## Cause

The issue occurs if the [DSNConversionMode](/powershell/module/exchange/set-transportconfig#-dsnconversionmode) parameter value is set to `UseExchangeDSNs` in the transport configuration settings for your Microsoft Exchange organization.

> [!NOTE]
> The default value of the DSNConversionMode parameter in Exchange Server 2013 is `UseExchangeDSNs`. In later Exchange Server versions, the default value is `PreserveDSNBody`. However, if you upgraded from a previous Exchange Server version that had DSNConversionMode set to `UseExchangeDSNs`, the previous value might be retained.

## Resolution

To determine the [DSNConversionMode](/powershell/module/exchange/set-transportconfig#-dsnconversionmode) parameter value, run the following command:

```powershell
Get-TransportConfig | FL DSNConversionMode
```

To resolve this issue, follow these steps:

1. Change the DSNConversionMode parameter value to `PreserveDSNBody` by running the following command:

   ```powershell
   Set-TransportConfig -DSNConversionMode PreserveDSNBody
   ```

   The DSNConversionMode parameter value `DoNotConvert` also fixes the issue.

2. Wait for the change to replicate, or restart the transport service by running the following command:

   ```powershell
   Restart-Service MSExchangeTransport
   ```
