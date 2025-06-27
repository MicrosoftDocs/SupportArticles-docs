---
title: On-premises users can't see MailTips of Exchange Online users
description: Describes a scenario where on-premises users in an Exchange hybrid deployment are unable to view MailTips of Exchange Online users by using Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Microsoft Outlook 2010
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# On-premises users are unable to see MailTips of Exchange Online users in Outlook 2010

_Original KB number:_ &nbsp; 3194772

## Problem

On-premises users in an Exchange hybrid deployment are unable to see MailTips of Exchange Online users by using Microsoft Outlook 2010. However, they can view the free/busy information of Exchange Online users.

## Cause

This problem occurs if the user configured their mailbox to deliver messages directly to a .pst file. MailTips aren't displayed in Outlook 2010 if a .pst file is set as the default delivery location.

## Solution

Configure Outlook 2010 to deliver messages directly to the user's mailbox instead of to a .pst file.

## More information

For more information, see [Find and transfer Outlook data files from one computer to another](https://support.microsoft.com/office/find-and-transfer-outlook-data-files-from-one-computer-to-another-0996ece3-57c6-49bc-977b-0d1892e2aacc).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
