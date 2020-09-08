---
title: Can't manage distribution group from Outlook
description: Describes causes for the issue that Outlook users may be unable to change the membership of groups for which they are listed as the managers after Microsoft Exchange Server 2010 is installed, and provides solutions.
author: AmandaAZ
ms.author: v-weizhu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 119623
- CSSTroubleshoot
ms.reviewer: matbyrd
search.appverid: 
- MET150
appliesto:
- Exchange Server 2010
---
# Can't manage distribution group from Outlook with Exchange Server mailbox

_Original KB number:_ &nbsp; 2586832

## Symptom

After Microsoft Exchange Server 2010 is installed, Microsoft Outlook users may be unable to change the membership of groups for which they are listed as the managers. When they try to do this, they receive the following error message:

> Changes to the distribution list membership cannot be saved. You do not have sufficient permission to perform this operation on this object.

![Error message from outlook](./media/cannot-manage-distribution-group-exchange-mailbox/error-message.jpg)

## Causes and resolutions

There are multiple causes for this behavior.

### Cause 1

This behavior is by design in Exchange Server 2010, Exchange Server 2013, and Exchange Server 2016. Role Based Access Control (RBAC) and the associated self-service roles that accompany it were introduced in Exchange Server 2010. To prevent customers from unexpectedly causing problems with group management, the group management self-service role is now set to Off by default.

To resolve this issue, see [How to manage groups that I already own in Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-to-manage-groups-that-i-already-own-in-exchange-2010/ba-p/597141).

### Cause 2

Distribution groups are configured to be managed by other distribution and security groups. Unfortunately, when Exchange 2010 adopted the RBAC model, you could no longer have a group manage other groups. In Exchange Server 2010, Exchange Server 2013 and Exchange Server 2016, you must list your group managers and individual users instead of a group.

To resolve this issue, see [How to manage groups with groups in Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-to-manage-groups-with-groups-in-exchange-2010/ba-p/585757).

### Cause 3

When an Outlook client connects to an Exchange 2010 or Exchange 2013 mailbox, the Directory connection is now directed through an Exchange server that has the Client Access Server (CAS) role. For Exchange 2016, the Directory connection is made to the Exchange server with the Mailbox server role. The Exchange server intercepts the calls for group management and then processes them through RBAC. If the RBAC engine determines that the user can manage this group, it lets the call be completed. However, if you have the Closest GC registry value configured on the Outlook client, Outlook continues to connect through the global catalog server instead of going through the Exchange server. The use of the closest global catalog and DS Server registry values is not supported with mailboxes in Exchange 2010 and later versions.

To resolve this issue, see [How to configure Outlook to a specific global catalog server or to the closest global catalog server](https://support.microsoft.com/help/319206).

### Cause 4

If the alias of the group that the user is trying to edit contains unauthorized characters, you can't edit it from Outlook, even if the permissions are configured correctly.

To test for this condition, start the Exchange PowerShell, and then run the following command:

```powershell
get-distributiongroup <group_name>
```

> [!NOTE]
> The \<group_name> placeholder represents the group that the user cannot edit.

If the shell returns an error message that states that the group has failed validation, you must resolve the problem with the group and make sure that it passes validation.

To resolve this issue, see [Exchange 2007 Scripting Corner: fix-alias](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-2007-scripting-corner-fix-alias/ba-p/593132).

### Cause 5

The group that you are trying to change must be a universal group. The CAS redirect and RBAC engine cannot change local or global groups.

To resolve this issue, convert global groups to universal groups.

### Cause 6

This error is also triggered if the group that you are trying to edit is not a member of the default global address list.

To resolve this issue, see [Managing address lists](/previous-versions/office/exchange-server-2010/aa997686(v=exchg.141)).
