---
title: On-premises security groups not synced to Exchange Online
description: Describes a scenario that prevents on-premises security groups that are not mail-enabled from syncing to Exchange Online in an Exchange hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: ajaysi, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# On-premises security groups are not synced to Exchange Online in a hybrid deployment

_Original KB number:_ &nbsp; 2988761

## Symptoms

In your hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365, you notice that some on-premises security groups are not synced to Exchange Online.

## Cause

This issue occurs if the on-premises security groups are not mail-enabled. In a hybrid deployment, only security groups that are mail-enabled are synced to Exchange Online. This behavior is by design.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
