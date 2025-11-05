---
title: Can't select reply all to messages from Microsoft 365 groups
description: Discusses an error message returned by Exchange Online when you select Reply All to an email message that was sent to a Microsoft 365 group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Management Groups
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre, v-kccross
appliesto: 
  - Exchange Online
ms.date: 11/05/2025
---

# Can't select Reply All in email messages with Microsoft 365 groups

Consider the following example. You're a member of a Microsoft 365 group and you receive an email message addressed to the group. Using Outlook on the web or new Outlook, you select **Reply All** and then send the message. You receive an error that states that Exchange Online "Couldn't send this message."

If you select **More details**, you receive this information.

"This message can't be sent because it no longer exists. It can only be discarded. Make sure you copy the contents of the message before you discard if you want to use them later."

## Cause

**Reply All** isn't supported by design because a group uses a single email address.

## Workaround

To respond to an email sent by a member of a Microsoft 365 group and have the email sent to the entire group, select **Reply** instead of **Reply All**.
