---
title: PublicFolderSizeExceedsTargetQuotaException in the migration of public folders
description: Fixes an error when you move public folders from an on-premises Exchange server to Exchange Online.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 156853
- Exchange Online
- CSSTroubleshoot
ms.reviewer: meerak; batre
editor: v-jesits
appliesto: 
- Exchange Online via Office 365 E Plans
- Exchange Online via Office 365 P Plans
search.appverid: MET150
---

# "PublicFolderSizeExceedsTargetQuotaException" error when moving public folders to Exchange Online

When you move public folders from an on-premises Exchange server to Exchange Online, you receive the following error message:

> FailureType : PublicFolderSizeExceedsTargetQuotaException  
> FailureHash : c045  
> FailureCode: -2146233088  
> MapiLowLevelError : 0  
> FailureSide :  
> FailureSideInt : 0  
> ExceptionTypes : {MRS, MRSPermanent, Exchange}  
> ExceptionTypesInt: {10, 12, 1}  
> WorkItem: InitializeCopyMessageStatistics  
> Message: Source public folder size <394035557704> exceeds target Mailbox quota. Permissible target Mailbox quota is 128849018880. Original target Mailbox quota is 107374182400.

Additionally, all public folders are migrated to the target primary public folder mailbox, regardless of the structure provided in the .csv mapping file.

This issue occurs for one of the following reasons. You can fix this issue depending on the cause respectively:

- A public folder with a size larger than 100 gigabytes (GB) is mapped to a single public folder mailbox. In this scenario, split the public folder, and then resume the migration.
- The name of a source public folder contains the *@* character. In this scenario, rename the public folder.
