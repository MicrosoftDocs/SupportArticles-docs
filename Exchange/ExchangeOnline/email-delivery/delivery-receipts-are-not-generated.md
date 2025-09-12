---
title: Delivery receipts aren't created
description: You receive the error when sending mail to external recipients, which states delivery to these recipients or groups is complete, but no delivery notification was sent by the destination server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Delivery receipts aren't generated when users send mail to external recipients

_Original KB number:_ &nbsp; 3184617

## Symptoms

When users request a delivery receipt for a message that they send to external recipients, they receive the following message:

> Delivery to these recipients or groups is complete, but no delivery notification was sent by the destination server.

## Cause

This behavior occurs if the recipient organization doesn't allow delivery reports.

## More information

The recipient organization can choose not to allow any delivery receipts. This prevents external senders from receiving delivery receipts. To configure this option, run the `Set-RemoteDomain` cmdlet, and then set the `DeliveryReportEnabled` parameter for the remote domain to **False**.

For more information, see [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
