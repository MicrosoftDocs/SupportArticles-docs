---
title: Mailbox quotas not increased automatically for licenses
description: Describes the problem and a solution when mailbox quotas for qualifying license types do not automatically reflect new quotas.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: bradhugh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Mailbox quotas not increased automatically for qualifying licenses in Exchange Online

_Original KB number:_ &nbsp; 4025170

## Symptom

Mailbox quotas for qualifying license types are not automatically increased to a new default value.

## Cause

By design, mailboxes for which an explicit quota was set previously retain that quota instead of having a new default quota applied. This behavior ensures that tenant administrators can set custom quotas for their mailboxes and have them honored by the system.

This behavior can also occur if a different type of license (qualifying for a smaller quota) was originally assigned, and then a new license enabling larger quotas is assigned. Because the original license stamped quota values onto the mailbox, quotas will not be automatically updated when new license values are assigned.

Additionally, several issues that could have caused this behavior have been reported for non-custom quotas for a subset of customers. The resolution for these issues is the same.

## Workaround

To work around this issue, use Exchange Online PowerShell to increase mailbox quotas for any mailboxes that do not automatically obtain the updated quotas. For example, you could use the following syntax to assign a 100-GB quota.

```powershell
Set-Mailbox -Identity<user>-ProhibitSendReceiveQuota 100GB -ProhibitSendQuota 99GB -IssueWarningQuota 98GB
```

If you have multiple mailboxes that need quota updates, you can make these updates by using the scripting capabilities that are available in PowerShell.

If the previous steps don't update the quotas, make sure that the `UseDatabaseQuotaDefaults` for the mailbox is set to **false**:

```powershell
Set-Mailbox -Identity<user>-UseDatabaseQuotaDefaults:$false
```

## More information

For more information about the quotas for different mailbox and license types, see [Mailbox storage limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

For more information about how to set mailbox quotas in Exchange Online, see [How to set Exchange Online mailbox sizes and limits in the Microsoft 365 environment](https://support.microsoft.com/help/2490230/how-to-set-exchange-online-mailbox-sizes-and-limits-in-the-office-365).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
