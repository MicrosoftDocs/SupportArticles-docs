---
title: Error when you run New-MailboxExportRequest
description: Describes an issue that can occur when you try to run the New-MailboxExportRequest cmdlet in Exchange Server 2010 SP1 or Exchange Server 2010 SP2, and provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when you run the New-MailboxExportRequest cmdlet in Exchange Server 2010 SP1 or SP2: Couldn't find the Enterprise Organization container

_Original KB number:_ &nbsp; 2737545

## Symptoms

Consider the following scenario:

- You install Exchange Server 2010 Service Pack 1 (SP1) or Exchange Server 2010 Service Pack 2 (SP2).
- An Exchange administrator must export the contents of a mailbox to a .pst file.
- The Exchange administrator runs the `New-MailboxExportRequest` cmdlet.

In this scenario, the Exchange administrator may receive an error message that resembles the following message:

> Couldn't find the Enterprise Organization container.  
> CategoryInfo: NotSpecified: (0:Int32) [New-MailboxExportRequest],OrgContainerNotFoundException  
> FullyQualifiedErrorId: D310F4E6,Microsoft.Exchange.Management.RecipientTasks.NewMailboxExportRequest

## Cause

This issue occurs if the Mailbox Import Export role-based access control (RBAC) management role isn't assigned to the Exchange administrator's account.

## Resolution

To resolve this issue, assign the Mailbox Import Export RBAC management role to the account. To do this, run the following cmdlet:

```powershell
New-ManagementRoleAssignment -Name "name" -SecurityGroup "security_group_name" -Role "Mailbox Import Export"  
```

## More information

If the Mailbox Search role is assigned to an account, that account has recipient read and write scopes that are sufficient to access recipient object data. However, the configuration read and write scopes for the role are None. So, the organization configuration data is blocked.

## References

- [Add the Mailbox Import Export Role to a Role Group](/previous-versions/office/exchange-server-2010/ee633452(v=exchg.141))

- [New-ManagementRoleAssignment](/powershell/module/exchange/new-managementroleassignment)
