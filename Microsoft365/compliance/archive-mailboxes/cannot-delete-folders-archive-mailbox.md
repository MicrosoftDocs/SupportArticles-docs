---
title: Can't delete folders in the Deleted Items folder of an archive mailbox in Exchange Online
description: Describes behavior in Exchange Online that prevents users from deleting folders in the Deleted Items folder of an archive mailbox that's been automatically expanded.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 3/31/2022
---

# Can't delete folders in the Deleted Items folder of an archive mailbox in Exchange Online

_Original KB number:_ &nbsp; 3210985

[!include[Purview banner](../../../includes/purview-rebrand.md)]

## Symptoms

When an archive mailbox in Exchange Online is automatically expanded through the auto-expand feature, folders that reside in the Deleted Items folder of that archive mailbox can't be deleted. When a user tries to delete a folder in Microsoft Outlook or Outlook on the web, the folder isn't deleted, and no error message is returned.

## More information

This behavior is by design for folders that are hosted on auto-expanding archives.

For more information about auto-expanding archives, see [Announcing auto-expanding, highly scalable archives for Microsoft 365 email](https://www.microsoft.com/en-us/microsoft-365/blog/2015/06/03/announcing-auto-expanding-highly-scalable-archives-for-office-365-email/).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
