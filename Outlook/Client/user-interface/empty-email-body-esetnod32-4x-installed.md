---
title: Email message body is blank when ESET NOD32 4.x is installed on client machines in Exchange Server 2010
description: Discusses an issue where users receive an empty email when ESET NOD32 4.x is installed on Outlook Web App or Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: v-9kach
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 10/30/2023
---
# Emails have empty bodies when ESET NOD32 4.x is installed on client machines on Exchange Server 2010

_Original KB number:_ &nbsp;2253312

## Symptoms

Some users on Microsoft Exchange Server 2010 may experience a problem, where they receive emails with blank content. The From: address, and subject will be present, but there will be nothing contained in the body of the message.  

This issue only applies to users on Exchange 2010, who are using Outlook Web App (OWA) or Outlook as a client, and also have ESET NOD32 4.x antivirus installed and run on their client machines.

## Resolution

Contact ESET Support for help with this issue.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

## More information

If you enable pipeline tracing on the Exchange 2010 server, you'll find that the email has body content until it's delivered to the mailbox.

For more information on Pipeline Tracing, see [Using Pipeline Tracing to Diagnose Transport Agent Problems](https://technet.microsoft.com/library/bb125198%28EXCHG.80%29.aspx).
