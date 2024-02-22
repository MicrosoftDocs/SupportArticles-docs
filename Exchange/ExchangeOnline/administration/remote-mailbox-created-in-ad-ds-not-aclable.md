---
title: A remote mailbox created in AD DS is not ACLable
description: Fixes an issue in which cloud users that are created by using the New-RemoteMailbox cmdlet is not ACLable.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# A remote mailbox created in on-premises AD DS is not ACLable in Exchange Online

_Original KB number:_ &nbsp; 4051497

## Symptoms

Consider the following scenario:

- A remote mailbox is created in on-premises Active Directory Domain Services (AD DS) environment by using the `New-RemoteMailbox` cmdlet.
- A mailbox is provisioned in Exchange Online.

In this scenario, the remote mailbox object in the on-premises AD DS is not considered ACLable. On-premises users cannot add the cloud mailbox user as a delegate or cannot grant folder permissions.

## Workaround

To work around this issue, update the `msExchRecipientDisplayType` property of the remote mailbox to a value of **-1073741818** in the on-premises AD DS.

You can also use the `ACLableSyncedObjectEnabled` parameter in the `New-RemoteMailbox` or `Enable-RemoteMailbox` cmdlet to create the remote mailbox as an ACLable object.

For more information about the cmdlets, see the following articles:

- [New-RemoteMailbox](/powershell/module/exchange/new-remotemailbox?view=exchange-ps&preserve-view=true)
- [Enable-RemoteMailbox](/powershell/module/exchange/enable-remotemailbox?view=exchange-ps&preserve-view=true)

## Status

This behavior is by design.

## More information

Starting in Microsoft Exchange 2013 Cumulative Update 10, you can make migrated users ACLable by setting an organization configuration. To do this, run the following command:

```powershell
Set-OrganizationConfig -ACLableSyncedObjectEnabled $True
```

> [!NOTE]
> This requires that an on-premises mailbox is migrated to Exchange Online instead of being provisioned directly in Exchange Online.
