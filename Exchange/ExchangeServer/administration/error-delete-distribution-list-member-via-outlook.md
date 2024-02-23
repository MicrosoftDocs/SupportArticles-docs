---
title: Distribution group owners can't remove distribution list members in outlook in Exchange Server 2010
description: Describes an issue in which you receive a (Changes to the distribution list membership cannot be saved) error when you try to remove members from an Exchange Server 2010 distribution list.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: tyronec, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you remove members from an Exchange Server 2010 distribution list: Changes to the distribution list membership cannot be saved

_Original KB number:_ &nbsp;982349

## Symptoms

In the role of a Distribution Group owner on a Microsoft Exchange Server 2010 server, you try to remove members from a distribution list that you own. When you try to remove some of these members in Microsoft Office Outlook by using the Distribution List Membership tool, you receive the following error message:

> Changes to the distribution list membership cannot be saved. You do not have sufficient permission to perform this operation on this object.

## Cause

This issue occurs when you try to delete distribution list members who no longer have mailboxes, but are still present in AD DS as disabled accounts. These members can't be removed from a distribution list by using the Distribution List Membership tool in Outlook. These members are only visible to the owner of a distribution list when the membership list is viewed.

## Resolution

To resolve this issue, follow these steps:

1. Click **Start**, point to **All Programs** > **Exchange Server 2010**, and then click **Exchange Management Shell**.
1. At the command prompt, run the following cmdlet:

    ```powershell
    New-RoleGroup DistributionGroupManagement -Roles "Distribution Groups"
    ```

1. At the command prompt, run the following cmdlet:

    ```powershell
    Add-RoleGroupMember DistributionGroupManagement -Member UserName
    ```

1. Open Outlook and try to remove from your distribution list those members that you couldn't remove before.
