---
title: PublicFolderSizeExceedsTargetQuotaException in the migration of public folders
description: Fixes an error when you migrate public folders from an on-premises Exchange server to Exchange Online.
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

# "PublicFolderSizeExceedsTargetQuotaException" error when migrating public folders to Exchange Online

## Symptoms

When you migrate public folders from an on-premises Exchange server to Exchange Online, you receive the following error message:

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

Additionally, all public folders are migrated to the target primary public folder mailbox, regardless of the structure provided in the `.csv` mapping file.

## Cause

This issue occurs for one of the following reasons:

Cause 1: The source may have public folder that contains the at sign (`@`) character in the name.

Cause 2: A public folder at the source may be larger than 25 gigabytes (GB).

## Resolution

To fix this issue, use the [Source Side Validation script](https://aka.ms/ssv2) to perform check on source before starting the public folder migration. The script will scan any public folders that have the `@` character in the name and public folders that are larger than 25 GB, and report issues along with action to fix the issues.
