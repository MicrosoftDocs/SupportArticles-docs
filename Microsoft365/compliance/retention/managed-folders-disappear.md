---
title: Empty managed folders disappear in Exchange Online
description: Provides information about an issue in which empty folders in Managed Folders keep being deleted.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 121662
ms.reviewer: lindabr
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 03/31/2022
---

# Empty managed folders disappear in Exchange Online

If you use managed folders in Exchange Online, you notice that some of the empty subfolders have disappeared. This behavior is by design. When the **Managed Folder Assistant** runs, it deletes any empty subfolders of a managed folder.  

For example, if the ***Britta** subfolder in the following path is empty, the **Managed Folder Assistant** will delete it:

`\Managed Folders\Work in Progress\*Britta`

If all the subfolders of a top-level managed folder are deleted, the top-level folder is also deleted together with the associated managed folder mailbox policy.

Managed folders is a legacy feature from Messaging Records Management (MRM) 1.0 that was deprecated in Microsoft Exchange Server 2013. We recommend that you no longer use this feature.
