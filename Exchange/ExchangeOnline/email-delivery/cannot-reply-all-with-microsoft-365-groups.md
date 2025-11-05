---
title: Cannot use reply all with Microsoft 365 groups 
description: Discusses an error message returned by Exchange Online when a member of a Microsoft 365 group uses reply all to respond to an email message sent to the group.
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

# Can't use reply all in email messages with Microsoft 365 groups

A member of a Microsoft 365 group receives an email message addressed to the group. Using Outlook on the web or new Outlook, the group member attempts to reply all to the message. The user receives an error message similar to the following from Exchange Online.

:::image type="content" source="media/cannot-reply-all-with-microsoft-365-groups/cannot-reply-all-with-microsoft-365-groups.png" alt-text="Image of the error message returned by Exchange Online when you attempt to reply all to a message sent to a Microsoft 365 group.":::

Where "Re: test at 7:43" is the subject of the message.

If you select **More details**, you'll receive more information that might be confusing.

“This message can't be sent because it no longer exists. It can only be discarded. Make sure you copy the contents of the message before you discard if you want to use them later.”

## Cause

Reply all is not supported by design because a group uses a single email address.

## Workaround: Use reply instead of reply all

To respond to an email sent by a member of a Microsoft 365 group and have the email sent to the entire group, use reply instead of reply all.
