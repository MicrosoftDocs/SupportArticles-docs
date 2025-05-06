---
title: Enable transport logging in Outlook
description: Describes how to enable logging the communications between Outlook and e-mail servers in plain text format.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Other
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
ms.date: 03/27/2025
---

# Enable transport logging in Outlook

Microsoft Outlook supports logging the communications that occur between Outlook and various types of email servers. These logs can be helpful when you troubleshoot problems that affect the transfer of messages between Outlook and the email server.

Outlook can log its communications with Microsoft Exchange, Post Office Protocol version 3 (POP3), Simple Mail Transport Protocol (SMTP), Internet Messaging Access Protocol (IMAP), and Outlook.com servers.

## Enable logging

Use the following steps:

1. On the **File** tab, click **Options**.
2. In the **Outlook Options** dialog box, click **Advanced**.
3. In the **Other** section, select the **Enable troubleshooting logging (requires restarting Outlook)** check box, and then click **OK**.
4. Exit and then restart Outlook.

## Logging results

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

When you enable logging, the following registry key is configured:

Subkey: **HKEY_CURRENT_USER\Software\Microsoft\Office\1x.0\Outlook\Options\Mail**

DWORD: EnableLogging

Values: 1 = logging enabled, 0 = logging disabled

> [!NOTE]
> In the subkey, <1x.0> represents the program version number. "16.0" denotes Outlook 2021, Outlook 2019, Outlook 2016 or Outlook for Microsoft 365.

After you enable logging, all communications that occur between Outlook and the email server are written to a log file.

> [!IMPORTANT]
> You must disable logging after the logs capture the failed communication to the server. If you don't disable logging, the logs will grow indefinitely.

## Log file locations

The log files are formatted as plain text.

**POP3, SMTP, MAPI logs**

The POP3, SMTP, and MAPI transport types are written to a single log file in the following location:

%temp%\Outlook Logging\Opmlog.log

**IMAP logs**

The IMAP transport type is written to the following location:

%temp%\Outlook Logging\IMAP-usernamedomainname-date-time.log

For example: IMAP-user1wingtiptoyscom-03_23_2014-12_49_31_798.log
