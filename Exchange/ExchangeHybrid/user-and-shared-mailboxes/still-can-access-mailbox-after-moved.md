---
title: Still can access a moved mailbox
description: Describes an issue in which a user can access both their on-premises and Exchange Online mailbox in a hybrid deployment after the user's mailbox is moved to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# User can still access their on-premises mailbox after it is moved to Exchange Online in a hybrid deployment

_Original KB number:_ &nbsp; 2973898

## Symptoms

Assume that you have a hybrid on-premises deployment of Exchange Server and Exchange Online in which you moved the on-premises mailboxes to the Exchange Online organization. After this move, one or more users are still able to access their on-premises mailbox. Additionally, the on-premises mailboxes of the users continue to receive mail.

## Cause

As part of the remote move process, several changes are made to the on-premises user mailbox. After these changes are made, mail is delivered only to the Exchange Online mailbox and can be accessed only from this mailbox. If these changes do not occur, or if they occur incorrectly, mail is not routed to the Exchange Online mailbox as expected.

This problem occurs because the on-premises mailbox type is not correctly changed from UserMailbox to RemoteMailbox. Therefore, the mailbox cannot correctly route mail to Exchange Online.

## Resolution

To resolve this problem, follow these steps:

1. Restore the Exchange Online mailbox to your on-premises Exchange organization. To do this, see the following Microsoft website, and then follow the steps in the **Move Exchange Online mailboxes to the on-premises organization** section in major step 3 (Use the EAC to move mailboxes):

   [Move mailboxes between on-premises and Exchange Online organizations in hybrid deployments](/exchange/hybrid-deployment/move-mailboxes)

2. Force a full directory synchronization.

3. Restore the affected user mailbox to Exchange Online. To do this, see website from step 1, and then follow the steps in the **Move on-premises mailboxes to Exchange Online** section of major step 3.

## More information

For more information about Exchange 2013 hybrid deployments, see [Exchange Server hybrid deployments](/exchange/exchange-hybrid).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
