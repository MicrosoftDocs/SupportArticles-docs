---
title: Outlook prompts for credentials when using WAN
description: This article resolves an issue in which Outlook users are prompted for credentials when they switch network from local area network to Wide Area Network (WAN).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Outlook 2007
  - Outlook 2010
  - Outlook 2013
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook users are prompted for credentials when they switch from a LAN to a WAN

_Original KB number:_ &nbsp; 2784787

## Symptoms

Assume that domain users connect to Microsoft Exchange Server by using Outlook. The Outlook Anywhere feature is enabled in their Outlook profiles. When the domain users switch from using the LAN to using a WAN, they are prompted for credentials by Outlook.

## Cause

This issue occurs when the client authentication method of Outlook Anywhere is set to Basic Authentication on the Exchange server.

When the user switches to another network, Outlook may change the connection type from TCP to HTTPS. If the client authentication method of Outlook Anywhere is set to Basic Authentication, the user is prompted for credentials.

## Resolution

To resolve this issue, set the client authentication method of Outlook Anywhere to NTLM Authentication on the Exchange server.

## More information

For more information about how to configure Outlook Anywhere on an Exchange server, see:

- [How to configure authentication for Outlook Anywhere in Microsoft Exchange Server 2007](/previous-versions/office/exchange-server-2007/bb124149(v=exchg.80))
- [How to configure authentication for Outlook Anywhere in Microsoft Exchange Server 2010](/previous-versions/office/exchange-server-2010/bb124149(v=exchg.141))
