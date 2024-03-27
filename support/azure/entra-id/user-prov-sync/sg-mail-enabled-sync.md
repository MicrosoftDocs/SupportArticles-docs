---
title: Security group is still mail-enabled after it is disabled through a sync in on-premises AD
description: Fixes an issue in which a security group is still mail-enabled after it is disabled through a sync in on-premises AD.
ms.date: 05/28/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: users
---
# Security group is still mail-enabled after it is disabled through a sync in on-premises AD

This article provides information about resolving an issue in which a security group remains mail-enabled after it is disabled through a sync in on-premises AD.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4096314

## Symptoms

Consider the following scenario:

- You have a security group that has an email address that is specified in on-premises Active Directory (on-premises AD).
- The security group is synchronized to Microsoft Entra ID.
- You remove the email address from the security group in on-premises AD.
- You run  a synchronization.
In this scenario, the security group remains mail-enabled, and it still has the original email address that was assigned to it in Microsoft Entra ID.

## Cause

When a mail-enabled security group is synchronized to Microsoft Entra ID, the email address that uses the original domain (`onmicrosoft.com`) is appended to the group as the secondary email address. If you delete the primary email address, the email address that has the original domain becomes the primary email address.

The following is the impact of this issue:

- The affected group does not exist in Global Address List (GAL) for on-premises users, so the user cannot choose the group in the **From** filed when they send emails.
- For Exchange Online users, the affected group can be found in GAL to choose from. However, email does not reach the recipient since the group's mail address was changed to `alias@contoso.onmicrosoft.com`.
- On-premises users cannot use the affected group to set permission such as access to a shared calendar.
- For Exchange Online users, the affected group can be used to set access to a calendar.

## Workaround

To work around this issue, use one of the following methods:

- Delete the security group from the Admin Portal, and then run the synchronization again.

- Move the security group to another organizational unit (OU) that has not been synchronized (filtered out). When you do this, the group is removed from the cloud. Then, move the group back to the original OU.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
