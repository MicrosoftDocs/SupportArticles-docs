---
title: Inline UUEncoded attachments from a UNIX-based application are garbled or unreadable
description: Fixes an issue in which an inline UUEncoded attachment of an email message from a UNIX-based application is garbled or is unreadable.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 126427
ms.reviewer: ddenson
appliesto: 
  - Exchange Server 2019
  - Exchange Online
  - Exchange Server 2010
  - Exchange Server 2013
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---
# Inline UUEncoded attachments of email messages from a UNIX-based application are garbled or are unreadable
  
_Original KB number:_ &nbsp; 2590107

## Symptoms

Consider the following scenario:

- A user receives an email message from a UNIX-based application.
- The email message contains an inline UUEncoded attachment.

In this scenario, the attachment is garbled or is unreadable. Additionally, the attachment is displayed as the following picture in the email message body:

:::image type="content" source="media/inline-uuencoded-attachments-garbled-unreadable/message-body.png" alt-text="Screenshot of the email message body.":::

**Note:** The following content is displayed in an affected message header.

> MIME-Version: 1.0 Content-Transfer-Encoding: 7bit Content-Type: text/plain; charset="us-ascii"

## Cause

This issue occurs because of "begin 664." It indicates that UUEncoding is being used. When an email message contains an inline UUEncoded attachment, multipart MIME instead of MIME should be used. Otherwise, Microsoft Exchange translates the UUEncoded data as a part of the message body that has a MIME designator.

## Resolution

To resolve this issue, encode the message by using multipart MIME.

**Note:** The issue cannot be resolved on an Exchange server because Exchange displays the messages according to the specified MIME encoding type.

## More information

For more information about MIME, visit the following website:

[General information about MIME](https://www.ietf.org/rfc/rfc1341.txt)

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
