---
title: Message body is shown as an attachment when sending an email with attachments in Exchange
description: Fixes an issue in which the body of the message may be shown incorrectly as an attachment when you try to use an application to send a message to an Exchange Server 2007 or 2010 server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need help with loss of email format, content conversion
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: deedi, ppawar, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# The body of a message is shown incorrectly as an attachment when you send the message that has attachments in an Exchange Server environment

_Original KB number:_ &nbsp;969854

## Symptoms

An email message that has an attachment is sent from an application in a Microsoft Exchange Server 2007 or Exchange Server 2010 environment. The email message also has a text body part that's specified after the attachment body part. When a user receives the email message, the body of the message is shown incorrectly as an attachment together with the attachment that's sent by the application. When this issue occurs, the message that's sent from the application is displayed as follows:

```console
MIME-version: 1.0 Content-type: multipart/mixed; boundary="exchange" This is a message with multiple parts in MIME format. --exchange Content-type: application/octet-stream Content-transfer-encoding: base64 PGh0bWw+CiAgPGhlYWQ+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+VGhpcyBpcyB0aGUg Ym9keSBvZiB0aGUgbWVzc2FnZS48L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg== --exchange Content-type: text/plain This is the body of the message. --exchange--
```

## Cause

This issue occurs when an attachment body part in an email message is sent before the message body part of the email message is sent. This issue occurs because the message is sent by the application in an incorrect format. Based on the "Mixed Subtype" definition that's mentioned in section 5.1.3 of RFC 2046, the "mixed" subtype of "multipart" is intended for use when the body parts are independent and have to be bundled in a particular order. Any "multipart" subtypes that an implementation doesn't recognize must be treated as being of "mixed" subtype.

## Resolution

If you change the order of the body parts in the application, the issue will be resolved. In this case, the correct order of the email message should be shown as follows:

```console
MIME-version: 1.0 Content-type: multipart/mixed; boundary="exchange" This is a message with multiple parts in MIME format. --exchange Content-type: text/plain <This is the body of the message.> --exchange Content-type: application/octet-stream Content-transfer-encoding: base64 PGh0bWw+CiAgPGhlYWQ+CiAgPC9oZWFkPgogIDxib2R5PgogICAgPHA+VGhpcyBpcyB0aGUg Ym9keSBvZiB0aGUgbWVzc2FnZS48L3A+CiAgPC9ib2R5Pgo8L2h0bWw+Cg== --exchange--
```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
