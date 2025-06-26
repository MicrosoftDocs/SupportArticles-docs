---
title: Developer Support limitations for open standards
description: Explains that Microsoft Customer Service and Support don't support a custom-solution that uses open standards for mail and calendaring, such as vCalendar, iCalendar, IMAP, POP3, SMTP, and MIME.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Need help with IMAP, POP Clients
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: danba, brijs, catagh, gbratton, dvespa, v-six
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2013
  - Outlook 2016
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Developer Support limitations for public protocols

_Original KB number:_ &nbsp;2269506

## Summary

This article describes how Microsoft Customer Service and Support can help developers about their custom solutions that use various open standards and that integrate with Microsoft Outlook or with Microsoft Exchange.

## More information

Microsoft Customer Service and Support don't support custom solutions that use open standards for mail and calendaring, such as vCalendar, Internet iCalendar protocol (iCalendar), Internet Message Access Protocol (IMAP), Post Office Protocol version 3 (POP3), Simple Mail Transfer Protocol (SMTP), and Multipurpose Internet Mail Extensions (MIME).

Exchange and Outlook implement various open standards. But Microsoft provides Developer Support for those standards only when a Microsoft API implements the standard that's being used. For example, Microsoft supports sending SMTP messages by using the System.Net.Mail namespace in Microsoft .NET Framework. But Microsoft doesn't support customers who are trying to interpret an RFC to add an iCalendar body part by using System.Net.Mail.

If you meet problems when you use a third-party API or an open standard, contact the API vendor for support, or refer to the documentation for the open standards. When interoperability problems occur, you should inform the API vendor that to operate successfully with Microsoft products, the API vendor's products must follow the applicable interoperability specifications. If you believe that a Microsoft product isn't following an open specification correctly, Microsoft Customer Service and Support provide support for those scenarios.

For Microsoft documentation for the algorithms that are used to convert iCalendar and vCard to MAPI objects, go to the following websites:

[vCard [MS-OXVCARD]](/openspecs/exchange_server_protocols/ms-oxvcard/bf4ebd4e-d240-44f3-bf8c-eedf4f0b09e3)

[iCalendar [MS-OXCICAL]](/openspecs/exchange_server_protocols/ms-oxcical/a685a040-5b69-4c84-b084-795113fb4012)

For information about support for Microsoft Open Protocol specifications, go to the following websites:

[Microsoft Exchange Server and Outlook Standards](/openspecs/exchange_standards/ms-oxstandlp/3c8dd289-b401-430c-a3a0-dec8028b5918)

[User forums and blogs](/openspecs/main/ms-openspeclp/3589baea-5b22-48f2-9d43-f5bea4960ddb)
