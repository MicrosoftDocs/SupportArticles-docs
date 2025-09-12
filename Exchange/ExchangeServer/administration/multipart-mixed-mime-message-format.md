---
title: Description of multipart/mixed Internet message format
description: This article introduces the multipart/mixed Internet message format.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need help with loss of email format, content conversion
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# A description of the multipart/mixed Internet message format

_Original KB number:_ &nbsp; 323226

## More information

A multipart/mixed MIME message is composed of a mix of different data types. Each body part is delineated by a boundary. The boundary parameter is a text string used to delineate one part of the message body from another. All boundaries start with two hyphens (--). The final boundary also concludes with two hyphens (--). The boundary can be made up of any ASCII character except for a space, a control character, or special characters.

When Exchange Server sends MIME messages, the content-type depends on whether there are attachments to the message, and on the formatting of the message text. If there are attachments, the content-type is multipart/mixed. In this case, the message text and each attachment become a separate part of the message content, each with its own content-type. If there are no attachments, the content-type of the message is Text/Plain, and the message body is made up of only one part.

A multipart/mixed MIME message header of a message sent with a Microsoft Word attachment may appear similar to the following:

```console
Content-type: multipart/mixed;
boundary="Boundary_any ascii character except some of the following special characters:

<BR/> ( )< > @ , ; : \ / [ ] ? = "
"
--Boundary_any ASCII character, except some special characters below:
content-Type: text/plain;----
charset=iso-8859-1
Content-transfer-encoding: 7BIT
--Boundary_ASCII characters  
Content-type: application/msword;
name="message.doc"
Content-Transfer-Encoding: base64
```

Messages that are composed by MIME clients as a multipart/mixed MIME message without a `name` parameter for the content-type or an optional `filename` parameter for the `content-disposition` header may not be rendered correctly when received by Exchange.
