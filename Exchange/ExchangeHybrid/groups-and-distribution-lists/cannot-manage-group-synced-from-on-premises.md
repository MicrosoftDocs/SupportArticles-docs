---
title: Cannot manage group synced to Microsoft 365
description: Describes how to grant several users rights to manage a group that is synced from on-premises in a hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: danielsl; Robwhal, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can't manage group synced from on-premises to Microsoft 365 in a hybrid environment

_Original KB number:_ &nbsp; 4041533

## Symptoms

Consider the following scenario:

- In a hybrid environment, groups are synchronized from the on-premises environment to Microsoft 365.
- In the on-premises environment, you can only set one entry in the **Managed by** field for the local Active Directory Domain Service (AD DS).
- Users who are group owners (that are also synchronized from the local AD DS) and have their mailboxes in Microsoft 365 use the Dsquery.exe tool to manage the groups, as per the recommended method in [Owners of an on-premises distribution group that's synced to Microsoft 365 can't manage the distribution group in Exchange Online](/exchange/troubleshoot/distribution-groups/cannot-manage-dg).

In this scenario, users can't manage the groups.

## Cause

This is default behavior because the local AD DS reads the permissions that are set on the local AD group. Because these users are not listed in the local AD permissions, they are unable to edit group membership.

## Resolution

To resolve this issue, you may have to assign owner permissions to more than one user. Although the purely Microsoft 365 groups can have multiple owners set, the hybrid setup requires additional action:

Add permissions for the users who have to manage the groups from Exchange Management Shell:

```powershell
Add-ADPermission -Identity "All Staff" -User UserName -AccessRights WriteProperty -Properties "Member"
```

For more information about this cmdlet, see [Add-ADPermission](/powershell/module/exchange/add-adpermission).

You can use the following cmdlet to check permissions:

```powershell
Get-ADPermission Contoso.com -User UserName
```

> [!NOTE]
> If you receive an **Access Denied** error message when you run the `Add-ADPermission` cmdlet, see [Access denied when you try to give user "send-as" or "receive as" permission for a Distribution Group in Exchange Server](https://support.microsoft.com/help/2983209).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
