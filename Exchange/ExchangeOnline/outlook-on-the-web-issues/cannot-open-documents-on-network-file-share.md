---
title: Cannot open documents on a network file share
description: Describes a scenario in on-premises Exchange Server and in Exchange Online in Microsoft 365 where users can't use Outlook on the web to open a shared document that resides on a network drive. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can't open documents on a network file share by using Outlook on the web in Exchange Server or Exchange Online

_Original KB number:_ &nbsp; 2918627

## Symptoms

Users in an on-premises Microsoft Exchange Server or Exchange Online environment can't use Outlook on the web (formerly known as Outlook Web App (OWA)) to open a shared document that resides on a network drive. When a user opens an email message in Outlook on the web and then selects the link to the shared document, the document doesn't open.

## Cause

This behavior is by design. In Exchange Server and in Exchange Online in Microsoft 365, you can't use Outlook on the web to access shared files through a Universal Naming Convention (UNC) path.

## Resolution

Do one of the following:

- In Outlook on the web, right-click the link in the email message, and then select the option to download the file to your local computer.
- Use Outlook to view the email message, and then open the file directly through the link.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
