---
title: Can't delete folders in the Deleted Items folder of an archive mailbox in Exchange Online
description: Describes behavior in Exchange Online that prevents users from deleting folders in the Deleted Items folder of an archive mailbox that was automatically expanded.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---

# Can't delete folders in the Deleted Items folder of an archive mailbox in Exchange Online

_Original KB number:_ &nbsp; 3210985

When an archive mailbox in Exchange Online is automatically expanded through the auto-expand feature, folders that reside in the Deleted Items folder of that archive mailbox can't be deleted. When a user tries to delete a folder in Microsoft Outlook or Outlook on the web, the folder isn't deleted, and no error message is returned.

This behavior is by design for folders that are hosted on auto-expanding archives.

For more information about auto-expanding archives, see [Auto-expanding archiving](/microsoft-365/compliance/autoexpanding-archiving).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
