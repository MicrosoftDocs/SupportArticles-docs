---
title: Troubleshoot and resolve calendar and delegate permission issues
description: Exchange administrators can use this article to find a matching symptom or error message and follow the linked resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Troubleshoot and resolve calendar and delegate permission issues

## Summary

Find the symptom or error message that matches your issue, and follow the linked article to resolve it. 

## Calendar permission issues

| If you see this | Use this fix |
|---|---|
| An unknown or deleted user remains on the calendar permission list | [Remove stale calendar permissions](delete-stale-calendar-permission.md) |
| Permission changes return `CorruptDataException` or say that the security principal is already present | [Fix corrupt calendar permission entries](fix-corrupt-calendar-permissions.md) |
| A security group was assigned as an Outlook delegate | [Replace security groups used as calendar delegates](replace-security-group-delegates.md) |
| `SharingPermissionFlags` is ignored or remains `None` | [Set Editor rights for calendar delegates](assign-editor-delegate-rights.md) |

## Delegate permission issues

| If you see this | Use this fix |
|---|---|
| Add, change, or remove delegate operations return `DelegateCollectionUpdateFailedException` | [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md) |
| Outlook says that delegate settings weren't saved correctly | [Fix a delegate settings save error](fix-delegate-settings-save-error.md) |
| A current delegate doesn't receive meeting invitations, or a former delegate still receives them | [Restore missing delegate meeting invitations](fix-delegate-invites.md) |
| A delegate can't open private calendar items | [Restore delegate access to private calendar items](fix-private-calendar-access.md) |
| Outlook reports that a meeting item changed after a delegate saved it as a draft | [Resolve a delegate meeting save error](fix-delegate-draft-save-error.md) |
| Full Access and delegate permissions conflict on a legacy shared calendar | [Resolve Full Access and delegate conflicts on legacy calendars](fix-full-access-delegate-conflicts.md) |
| Delegate access fails across the Exchange hybrid boundary | [Resolve Outlook delegate failures in Exchange hybrid](fix-hybrid-delegate-failures.md) |

## Learn more about calendar permissions

For more information about calendar and delegate permissions, see:

- [Understand calendar and delegate permissions in Exchange Online](/exchange/collaboration-exo/shared-calendars/understand-calendar-delegate-permissions)
- [Manage calendar permissions in Exchange Online](/exchange/collaboration-exo/shared-calendars/manage-calendar-permissions)
- [Validate calendar permissions in Exchange Online](/exchange/collaboration-exo/shared-calendars/validate-calendar-permissions)
