---
title: Email message content is missing in OWA
description: Describes an issue that can occur when you send an email message in OWA. Provides a workaround.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
ms.reviewer: mataylor, wduff, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---

# Email message content is missing in OWA

## Symptoms

Consider the following scenario:

- You access a Microsoft Exchange Server mailbox by using Microsoft Outlook Web Access (OWA).
- You send an email message by using OWA.
- The recipient tries to read the email message by using Mozilla Firefox.

In this scenario, some email message content may be missing.

## Cause

This issue can occur if the following conditions are true:

- The email message contains deeply nested elements.
- The Use Conversations view in OWA is turned on.

## Workaround

To work around this issue, turn off the Use Conversations view in OWA. To do this, select **View** and then clear **Use Conversations**.

## More information

For more information about this issue, see [Deeply nested elements are not rendered](https://bugzilla.mozilla.org/show_bug.cgi?id=256180).
