---
title: Personal tags don't apply correctly for Inbox rule
description: Discusses an issue in which Exchange personal tags don't work correctly for an Inbox rule in Exchange.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Retention policies
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: dpaul
appliesto: 
  - Exchange Server 2016
  - Exchange Online
search.appverid: MET150
ms.date: 01/30/2024
---
# Personal policy tag for an Inbox rule doesn't work correctly in Exchange

_Original KB number:_ &nbsp; 4456109

## Symptoms

Consider the following scenario:

- You have a **3 Days Delete** Default Policy Tag (DPT) or Retention Policy Tag (RPT) to stamp messages upon delivery to your mailbox.
- You have an Inbox rule to stamp a **1 Week Delete** personal tag on incoming messages.
- A new message arrives at the Inbox.

In this scenario, the **1 Week Delete** personal tag appears to be stamped on the message correctly in Microsoft Outlook. However, the message is deleted after three days.

## Cause

This issue occurs because the message is stamped against the DPT or RPT instead of the personal tag. This causes the action to occur according to the retention date of the DPT or RPT and not according to the personal tag.

## Workaround

To work around this issue, don't use personal tags for Inbox rules. Instead, manually assign a personal tag to specific items. To do this, follow these steps:

1. Open Outlook.
2. Right-click any email message.
3. Select **Assign Policy**.
4. Select one personal tag that you want to assign.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

Data loss because `PR_RETENTION_DATE` property is not updated when user has rule to add policy tag on incoming messages delivered to inbox folder. We can use the MFCMAPI to check that. For more information about the MFCMAPI tool, refer [this blog](/archive/blogs/dvespa/how-to-use-mfcmapi-to-create-a-mapi-profile-to-connect-to-exchange-2013).
