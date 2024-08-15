---
title: PublicFolderSizeExceedsTargetQuotaException in the migration of public folders
description: Fixes an error that occurs when you migrate public folders from on-premises Exchange Server to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 156853
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: meerak, batre, v-chazhang
editor: v-jesits
appliesto: 
  - Exchange Online via Office 365 E Plans
  - Exchange Online via Office 365 P Plans
search.appverid: MET150
ms.date: 01/24/2024
---

# "PublicFolderSizeExceedsTargetQuotaException" error when migrating public folders to Exchange Online

## Symptoms

When you migrate public folders from on-premises Microsoft Exchange Server to Exchange Online, you receive the following error message:

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

Additionally, all public folders are migrated to the target primary public folder mailbox, regardless of the structure that's provided in the `.csv` mapping file.

## Cause

This issue occurs for one of the following reasons:

**Cause 1:** The source may have a public folder that contains the at sign (`@`) character in the name.

**Cause 2:** A public folder at the source may be larger than 25 gigabytes (GB).

## Resolution

To fix this issue, run the [Source Side Validation script](https://aka.ms/ssv2) to check the source before you start the public folder migration. The script will scan any public folders that have the `@` character in the name and public folders that are larger than 25 GB. The script will then report any discovered issues together with suggested actions to fix those issues.
