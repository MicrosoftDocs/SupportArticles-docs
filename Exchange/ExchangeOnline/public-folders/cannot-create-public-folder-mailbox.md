---
title: Can't create public folder mailbox in Exchange Online
description: Resolves an issue in which you can't create public folder mailboxes in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
  - CI 166459
ms.reviewer: haembab, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# Can't create public folder mailbox in Exchange Online

## Symptoms

When you try to create a public folder mailbox in Microsoft Exchange Online, the operation fails and you receive one of the following error messages.

### Error 1

> The following error occurred during Validation in agent "Provisioning Policy Agent": "The number of "Mailbox" objects in the organization "\<organization name\>" has reached or exceeded the resource quota (100) enforced by policy "Recipient Quota Policy: PublicFolderMailboxHierarchyCountQuota"."

### Error 2

> The following error occurred during Validation in agent "Provisioning Policy Agent": "The number of "Mailbox" objects in the organization "\<organization name\>" has reached or exceeded the resource quota (100) enforced by policy "Recipient Quota Policy: PublicFolderMailboxCountQuota"."

### Error 3

> The following error occurred during Validation in agent "Provisioning Policy Agent": "The number of "Mailbox" objects in the organization "\<organization name\>" has reached or exceeded the resource quota (1000) enforced by policy "Recipient Quota Policy: PublicFolderMailboxCountQuota"."

The issue occurs regardless of whether you try to create the public folder mailbox in the Exchange admin center (EAC) or by using the [New-Mailbox](/powershell/module/exchange/new-mailbox) PowerShell cmdlet.

## Cause

### Cause for error 1

When you create a new public folder mailbox, Exchange Online automatically configures it as a hierarchy-serving mailbox. However, for each tenant, Exchange Online sets a limit of 100 for the total number of public folder mailboxes that are [hierarchy-serving](https://techcommunity.microsoft.com/t5/exchange-team-blog/introduction-to-public-folder-hierarchy-sync/ba-p/609344#toc-hId--55837873). Error 1 occurs if you try to create another hierarchy-serving public folder mailbox after your tenant reaches the limit.

### Cause for error 2

For each tenant, Exchange Online sets a limit of 1,000 for the total number of public folder mailboxes. However, your tenant has a lower limit of 100. Error 2 occurs if you try to create another public folder mailbox after your tenant reaches the lower limit.

### Cause for error 3

For each tenant, Exchange Online sets a limit of 1,000 for the total number of public folder mailboxes. Error 3 occurs if you try to create another public folder mailbox after your tenant reaches the limit.

> [!NOTE]
> For more information about public folder mailbox limits in Exchange Online, see [Storage limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#storage-limits).

## Solution

Use the appropriate solution, depending on the error message that you receive.

### Workaround for error 1

If you reach the [hierarchy-serving](https://techcommunity.microsoft.com/t5/exchange-team-blog/introduction-to-public-folder-hierarchy-sync/ba-p/609344#toc-hId--55837873) public folder mailbox limit, you can create new public folder mailboxes as non-hierarchy-serving public folder mailboxes. Use the [New-Mailbox](/powershell/module/exchange/new-mailbox) cmdlet together with the `IsExcludedFromServingHierarchy` switch, as shown in the following example:

```powershell
New-Mailbox -PublicFolder -Name <mailbox name> -IsExcludedFromServingHierarchy $True
```

For each tenant, Exchange Online sets a limit of 1,000 for the total number of public folder mailboxes. This limit includes both hierarchy-serving and non-hierarchy-serving public folder mailboxes.

### Resolution for error 2

To increase your tenant's public folder mailbox limit to 1,000, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021).

### Resolution for error 3

If your tenant reaches the public folder mailbox limit of 1,000, contact [Microsoft Support](https://go.microsoft.com/fwlink/?linkid=2189021).

> [!NOTE]
> If you plan to create public folder mailboxes in Exchange Online to prepare for the migration of on-premises public folders, see [Best practices for public folder preparation before migrations](https://techcommunity.microsoft.com/t5/exchange-team-blog/best-practices-for-public-folder-preparation-before-migrations/ba-p/1909222). The "Target public folder mailboxes" section describes how you can map on-premises public folders to Exchange Online public folder mailboxes.
