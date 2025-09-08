---
title: Unreadable Characters in the Subject Line of Received Email Messages
description: Provides solutions for an issue in which the subject line of received email messages that are sent by SmtpClient contain garbled characters.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin / ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Mail Flow
  - Exchange Server
  - CSSTroubleshoot
  - CI 5055
ms.reviewer: dkhrebin, arindamt, meerak, v-shorestris
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Online
search.appverid: MET150
ms.date: 04/29/2025
---

# Unreadable characters in the subject line of received email messages

## Symptoms

A user reports that recipients of their email messages see unreadable or garbled characters in the subject line.

## Cause

This issue occurs if a mail client application that targets a legacy Microsoft .NET Framework version uses the [System.Net.Mail.SmtpClient](/dotnet/api/system.net.mail.smtpclient.send) class to send email messages that contain non-ASCII characters in the subject line. In earlier .NET Framework versions, the SmtpClient implementation incorrectly handles non-ASCII characters in the subject line when connected to an SMTP server that supports the SMTPUTF8 extension. Instead of using the standard header encoding (RFC 2047), the client application sends raw UTF-8 bytes in the subject header. Consequently, mail clients that receive the affected messages display unreadable or garbled characters in the subject line.

## Solution

To fix this issue, use either of the following methods:

- **Update the target .NET Framework version in the client app (client-side fix)**

   The SmtpClient implementation in [.NET Framework](https://dotnet.microsoft.com/download/dotnet-framework) 4.8 and later versions handles subject encoding correctly when connected to SMTPUTF8-enabled servers.

   Alternatively, upgrade the client application to target the [Microsoft .NET platform](https://dotnet.microsoft.com/download).

- **Configure the Exchange Server receive connector (server-side workaround)**

   > [!NOTE]
   > This solution doesn't apply to mail client applications that connect to Exchange Online to send email messages.

   If the affected application uses a known set of IP addresses when it connects to Microsoft Exchange Server, you can configure a dedicated receive connector on the Exchange server to disable the SMTPUTF8 extension for connections that originate from those IP addresses.

   To [configure a receive connector](/powershell/module/exchange/set-receiveconnector), run the following PowerShell cmdlet in Exchange Management Shell (EMS):

   ```PowerShell
   Set-ReceiveConnector -Identity "<connector name or ID>" -SmtpUtf8Enabled $false -RemoteIPRanges <remote IP ranges>
   ```

   For example, you might use the following command:

   ```PowerShell
   Set-ReceiveConnector -Identity "Client apps connector" -SmtpUtf8Enabled $false -RemoteIPRanges "192.168.21.0/24", "10.10.10.10", "2001:0DB8::CD3/60"
   ```
