---
title: Error 80070005 when you run the Azure Active Directory Sync Services config wizard
description: Describes an issue that generates a failed due to the 80070005 error when you run the Azure Active Directory Sync (Azure AD Sync) Services config wizard. Provides a solution.
ms.date: 11/09/2021
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Error: 80070005 when you run the Azure Active Directory Sync Services config wizard

_Original product version:_ &nbsp; Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2988408

## Symptoms

When you run the Azure Active Directory Sync (Azure AD Sync) Services config wizard, you receive the following message:

> Retrieving the COM class factory for remote component with CSLID {...} from machine ... failed due to the following error: 80070005

## Cause

This issue may occur if you're not a member of the **ADSyncAdmins** group on the local computer or if you have just installed Azure AD Sync Services.

## Resolution

To resolve this issue, sign out and then sign in to the computer. If the issue persists, follow these steps:

1. Select **Start**, type `compmgmt.msc` in the search box, and then press Enter to open Computer Management.
2. Under **Computer Management**, expand **Local Users and Groups**, and then expand **Groups**.
3. Make sure that the **ADSyncAdmins** group exists. If this group is missing, create a new group, and name it **ADSyncAdmins**.
4. Add yourself to the **ADSyncAdmins** group.
5. Sign out, and then sign in to the computer again.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
