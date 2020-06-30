---
title: Error 80070005 when you run the Azure Active Directory Sync Services config wizard
description: Describes an issue that generates a failed due to the 80070005 error when you run the Azure Active Directory Sync (AAD Sync) Services config wizard. Provides a solution.
ms.date: 05/11/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: willfid
---
# Error: 80070005 when you run the Azure Active Directory Sync Services config wizard

This article describes an issue that generates a failed due to the 80070005 error when you run the Azure Active Directory Sync (AAD Sync) Services config wizard.

_Original product version:_ &nbsp; Azure Active Directory,Microsoft Intune,Azure Backup,Office 365 Identity Management  
_Original KB number:_ &nbsp; 2988408

## Symptoms

When you run the Azure Active Directory Sync (AAD Sync) Services config wizard, you receive the following message:

> Retrieving the COM class factory for remote component with CSLID {...} from machine ... failed due to the following error: 80070005

## Cause

This issue may occur if you're not a member of the AADSyncAdmins group on the local computer or if you have just installed AAD Sync Services.

## Resolution

To resolve this issue, log off and then log on to the computer. If the issue persists, follow these steps:

1. Select **Start**, type `compmgmt.msc` in the search box, and then press Enter to open Computer Management.
2. Under **Computer Management**, expand **Local Users and Groups**, and then expand **Groups**.
3. Make sure that the AADSyncAdmins group exists. If this group is missing, create a new group, and name it AADSyncAdmins.
4. Add yourself to the AADSyncAdmins group.
5. Log off, and then log on to the computer again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
