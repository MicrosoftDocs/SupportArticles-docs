---
title: HCW8043 Edge Transport servers cannot be specified
description: Fixes an issue that returns an HCW8043 error when you run the Hybrid Configuration wizard in Exchange Online or Exchange Server 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8043 Edge Transport servers cannot be specified error when you run Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3087173

## Problem

When you run the Hybrid Configuration wizard, you receive the following error message:

> HCW8043 Edge Transport servers cannot be specified with receiving Client Access or sending Mailbox servers.

## Cause

This issue occurs if you selected an edge server on the page of the Hybrid Configuration wizard where you specify sending and receiving servers.

## Solution

Run the Hybrid Configuration wizard again, and remove the edge server that you specified on the pages of the wizard where you specify sending and receiving servers.

The sending server must be an Exchange 2013 mailbox server, and the receiving server must be an Exchange 2013 Client access server.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
