---
title: Resource ‎CiAgeOfLastNotification‎ is unhealthy
description: Describes a scenario where you get an error message when you try to move mailboxes from Exchange Online to on-premises Exchange Server in a hybrid deployment or from one on-premises Exchange forest to another. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Resource ‎CiAgeOfLastNotification‎(System)‎ is unhealthy and should not be accessed error when moving mailbox

_Original KB number:_ &nbsp; 2931079

## Symptoms

When you try to offboard or move a mailbox, you get the following error message:

> Error:  
Resource ‎'CiAgeOfLastNotification‎(System)‎‎' is unhealthy and shouldn‎'t be accessed

You experience these symptoms in one of the following scenarios:

- You have a hybrid deployment of on-premises Exchange Server and of Exchange Online and you try to move a mailbox from Exchange Online to the on-premises environment.
- You try to perform a cross-forest mailbox move between two on-premises Exchange servers.

## Cause

This issue can occur if an index in the on-premises environment is corrupted.

## Resolution

To resolve this issue, follow these steps:

1. Rebuild the content index catalog on the on-premises Exchange server. For more information about how to do this, see [Reseed the search catalog](/exchange/reseed-the-search-catalog-exchange-2013-help).
2. After the index catalog is rebuilt, wait a few minutes until the fast engine starts indexing again.
3. Determine whether indexing is completed. To do this, run the `Get-MailboxDatabaseCopyStatus` cmdlet.

   If indexing is completed, the value in the output should show as Healthy.

After indexing is completed, perform the mailbox move request.

## More information

For more information, see the following Microsoft resources:

- [Exchange Search](/exchange/exchange-search-exchange-2013-help)
- [Update-MailboxDatabaseCopy](/powershell/module/exchange/update-mailboxdatabasecopy?view=exchange-ps&preserve-view=true)
- [Get-MailboxDatabaseCopyStatus](/powershell/module/exchange/get-mailboxdatabasecopystatus?view=exchange-ps&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
