---
title: Contents of cloud-based archive are the same as on-premises
description: Describes an issue in which there's no difference between the contents of cloud-based archive mailboxes and the contents of the associated on-premises primary mailboxes. This issue occurs in an Exchange hybrid deployment.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Online
  - Exchange Online Archiving
search.appverid: MET150
ms.date: 06/24/2024
---
# Contents of cloud-based archive are the same as contents of on-premises primary mailbox

_Original KB number:_ &nbsp; 2987546

## Problem

Assume that you have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Microsoft 365. When you view the cloud-based archive mailbox of a user, archived items are not displayed. Instead, the contents of the cloud-based archive mailbox are the same as the contents of the user's on-premises primary mailbox.

## Cause

This issue may occur if the user principal name (UPN) of the user's on-premises Exchange mailbox has a suffix that makes it differ from the UPN of the archive mailbox. For example, this issue may occur if the UPN of the user's on-premises mailbox is *joe@contoso.com* and the UPN of the user's archive mailbox is *joe@contoso1.com*.

This issue may also occur if your on-premises Exchange organization isn't federated with Exchange Online correctly.

## Solution

Make sure that your on-premises Exchange organization is correctly federated with Exchange Online. For more info, see [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
