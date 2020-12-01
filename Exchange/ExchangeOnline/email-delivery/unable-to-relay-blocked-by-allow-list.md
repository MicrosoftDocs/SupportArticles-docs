---
title: 5.7.1. Unable To Relay NDR
description: Fixes an issue that occurs when a sender uses an external email server whose IP address was added to a block list.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: romccart
appliesto:
- Exchange Online
- Exchange Online Protection
search.appverid: MET150
---
# Sender receives an NDR: 5.7.1 Unable to Relay: Blocked by Customer Allow List

_Original KB number:_ &nbsp; 3013740

## Problem

An external email server cannot connect to Microsoft Exchange Online Protection because its IP address was added to a block list. When a sender tries to send mail through that server, the sender receives a nondelivery report (NDR) that contains the following error message. (The message doesn't include the name of the specific block list.)

> 5.7.1. Unable To Relay: Blocked by Customer Allow list

## Cause

This issue occurs if the IP address is added to both the incoming connector and the **IP Allow list** on the Connection Filtering page of the Exchange admin center. In this scenario, the NDR doesn't include the name of the specific block list if the IP address is added to a real-time block list (RBL) that's used in Exchange Online Protection.

## Solution

To determine the name of the specific block list that's preventing the IP address from connecting to Exchange Online Protection, remove the IP address of the external email server from the **IP Allow list**. After you do this, the NDR will include the name of the specific block list.

## More information

Ideally, only on-premises IP addresses should be added to connector settings.

For more information about 5.7.1 NDR errors, see [Fix email delivery issues for error code 550 5.7.1 in Exchange Online](/exchange/mail-flow-best-practices/non-delivery-reports-in-exchange-online/fix-error-code-550-5-7-1-in-exchange-online).
