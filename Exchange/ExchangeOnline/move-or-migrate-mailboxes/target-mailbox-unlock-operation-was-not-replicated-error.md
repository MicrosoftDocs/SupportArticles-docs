---
title: Target mailbox unlock operation was not replicated error
description: Describes an issue in which you receive a warning after you migrate a mailbox from the on-premises Exchange Server environment to Exchange Online in an Exchange hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: vibour, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Target mailbox unlock operation was not replicated message after migrating a mailbox

_Original KB number:_ &nbsp; 3078572

## Symptoms

After you move a mailbox from the on-premises Microsoft Exchange Server environment to Microsoft Exchange Online in Microsoft 365 in a hybrid deployment, you receive the following warning message:

> Warning: Target mailbox unlock operation was not replicated. If a lossy failover occurs after the target mailbox was unlocked, the target mailbox could remain inaccessible.
>
> Error details: Mailbox changes failed to replicate. Database *Database* doesn't satisfy the constraint SecondCopy because the commit time *DateTime* isn't guaranteed by replication time <**Date**> <**Time**>.

## Cause

A replication delay in the service occurred. This may prevent some post-migration cleanup tasks from taking effect immediately.

## Resolution

The user may be unable to access the mailbox immediately after the migration is complete. As soon as replication is complete, the user will be able to access the mailbox. If the user continues to be unable to access the mailbox 60 minutes after the migration is complete, contact Microsoft 365 Support.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
