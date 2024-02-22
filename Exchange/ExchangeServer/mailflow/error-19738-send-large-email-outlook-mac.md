---
title: Error when you use Outlook for Mac to send a large email through Exchange Server
description: Describes an issue that triggers an error or an NDR when you try to send an email with a large attachment in Outlook for Mac. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: tasitae, v-six
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Error code 19738 when you use Outlook for Mac to send a large email message through Exchange Server

_Original KB number:_ &nbsp;3146087

## Symptoms

You use Microsoft Outlook 2016 for Mac or Outlook for Mac 2011 to connect to a mailbox on a Microsoft Exchange server. When you send an email message that contains a large attachment, you receive the following error messages in Outlook for Mac.

```console
Error: Outlook cannot send the message <subject> because the message size exceeds the maximum limit set on the server.
Details: The message has been moved to the Drafts folder under On My Computer. Try reducing the message size by removing or resizing any large attachments, and then resend. If the problem persists, contact your administrator.

Error Code: -19738
```

Or, you receive a non-delivery report (NDR) in your Inbox like this one:

```console
Subject: Undeliverable: <subject>

Body:
Your message wasn't delivered to anyone because it's too large. The limit is 35 MB. Your message is <size of your message>.
User Name (User@domain.com)
Your message couldn't be sent because it's too large.
```

The message contains diagnostic information for administrators, such as the following:

> Remove Server returned '500 5.2.11 RESOLVER.RST.SendSizeLimit.Sender; message too large for this sender'

## Cause

This issue occurs when you send an email message that's larger than the Exchange Web Services (EWS) message size limit that's configured on the Exchange server.

## Resolution

You can increase the message size limit on the Exchange server to allow for larger email messages to be sent from Outlook for Mac clients and other EWS clients. For more information, see the following TechNet articles as appropriate for your version of Exchange Server.

Exchange Server 2016 and 2013: [Configure client-specific message size limits](/exchange/configure-client-specific-message-size-limits-exchange-2013-help)

Exchange Server 2010: [Set message size limits for Exchange Web Services](/previous-versions/office/exchange-server-2010/hh529949(v=exchg.141))

## More information

For more information about this issue, see the following article in the Microsoft Knowledge Base:

[3107326](https://support.microsoft.com/help/3107326) You can't send large attachments by using the EWS client