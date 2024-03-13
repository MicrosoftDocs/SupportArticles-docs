---
title: Separate passwords required for the computer and work or school account when using password synchronization and the Azure Active Directory Sync tool
description: Describes that users have to use a separate password to sign in to Office 365 and to log on to their computer, even though password synchronization is enabled in Microsoft Entra ID. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Separate passwords required for the computer and work or school account when using password synchronization and the Azure Active Directory Sync tool

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2853316

## Symptoms

Users have to use different passwords to sign in to their work or school account in a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune and to log on to their computers. This problem occurs even though you've take the following actions:

- Enabled password synchronization in Microsoft Entra ID
- Set up Active Directory synchronization to sync user accounts in your on-premises Active Directory Domain Services (AD DS) environment to Microsoft Entra ID

## Cause

This problem occurs if users' cloud service passwords change. Password synchronization doesn't sync the cloud service password. Therefore, users in this scenario have different passwords for their local computer and for the cloud service.

## Resolution

To resolve this problem, do one of the following:

- Have users change their computer password.
- Reset the computer password for the users. When you reset a user's password, make sure that the **User must change password at next logon** check box is cleared.

After directory synchronization occurs, users' computer passwords in the on-premises Active Directory environment are synced to Microsoft Entra ID. Users can then log on to their computers and sign in to the cloud service by using the same password.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
