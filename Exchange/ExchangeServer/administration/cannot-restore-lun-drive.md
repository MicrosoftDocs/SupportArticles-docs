---
title: Cannot restore a LUN drive
description: Resolves an issue in which you can't use an Exchange-aware backup program (such as EMC AppSync) to restore a logical unit number drive in Exchange Server 2013.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: davidoc, nasira, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# You can't restore a LUN drive in Exchange Server 2013

_Original KB number:_ &nbsp; 2872889

## Symptoms

You try to use an Exchange-aware backup program such as EMC AppSync to restore a whole volume or a LUN drive in Exchange Server 2013. However, the operation fails. This issue does not occur in Exchange Server 2010 or Exchange Server 2007.

## Cause

This behavior is by design. It occurs because the Microsoft Exchange Search Host Controller service locks the database files even if the database is dismounted.

## Resolution

To resolve this issue, disable the Microsoft Exchange Search Host Controller service, and then restore the volume or LUN.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
