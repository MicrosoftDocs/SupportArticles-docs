---
title: Error when you try to open Miisclient.exe in the Azure Active Directory Sync installation folder
description: Describes an issue in which you get an error when opening Miisclient.exe in the Azure Active Directory Sync installation folder. Provides a solution.
ms.date: 07/06/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# Error when you try to open Miisclient.exe in the Azure Active Directory Sync installation folder: Unable to connect to the Synchronization Service

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Azure Active Directory, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2791422

## Symptoms

When you try to open Miisclient.exe in the Microsoft Azure Active Directory Sync installation folder, you get the following error message:

```
Unable to connect to the Synchronization Service.

Some possible reasons are:

  1) The service is not started

  2) Your account is not a member of a required security group.

See the Synchronization Service documentation details.
```

## Cause

This issue occurs for one of the following reasons:

- The installation of the Directory Sync tool isn't completed.
- The user account that you used to log on to the computer doesn't have sufficient permissions to open or to perform tasks in Microsoft Forefront Identity Manager (FIM).

## Resolution

To resolve this issue, log off from and then log back on to the computer. If this issue persists after you log off and then log back on, follow these steps:

1. Select **Start**, right-click **Computer**, and then select **Manage**.
2. Under **Computer Management**, expand **Local Users and Groups**, and then expand **Groups**.
3. Make sure that the MIISAdmins group exists. If the group is missing, create a group named MIISAdmins.
4. Add yourself to the group.
5. Log off from the computer, and then log on to establish the new group membership in the access token.

If this issue persists after you perform these steps, contact Support. You may have to reinstall the Directory Sync tool.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
