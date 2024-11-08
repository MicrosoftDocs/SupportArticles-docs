---
title: IRM encryption does not support dynamic distribution group
description: This article describes that the Microsoft 365 encrypted message isn't support for a dynamic distribution group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: aldoug, v-six
ms.custom: 
  - sap:Messaging Policy and Compliance\Information Rights Management
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Business
  - Outlook
ms.date: 01/24/2024
---
# Can't view Microsoft 365 IRM-encrypted message for dynamic distribution group

_Original KB number:_ &nbsp; 4459264

## Symptoms

Assume that you send an email to a Microsoft Exchange Online dynamic distribution group that has an Azure Information Protection IRM-protected template applied, such as **Do Not Forward**. When the recipient tries to open the email, they are redirected to Outlook on the web. Outlook on the web displays a button to read the message, but selecting the button does not work, and the recipient gets caught in an infinite loop without being able to view the message. Emails sent to recipients and a distribution group work fine.

## Cause

This behavior is by design. IRM encryption doesn't support dynamic distribution groups.

## Resolution

Use a distribution group as the recipient for IRM-protected messages instead of using a dynamic distribution group.
