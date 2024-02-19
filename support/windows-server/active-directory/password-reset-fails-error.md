---
title: Password Reset using Active Directory Users & Computers fails
description: Provides a solution to an error that occurs when you reset the password of a user.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, nedpyle
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Password Reset using Active Directory Users & Computers fails with error "The System cannot find the path specified"

This article provides a solution to an error that occurs when you reset the password of a user.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2001522

## Symptoms

You have the task to manage users in your domain and you need to reset the password of a user. You can right-click the user and select **Reset Password** and enter the new password. After you click **OK**, you receive the error message:

> Windows cannot complete the password change for \<user name> because:  
The System cannot find the path specified

The password for the user isn't changed afterwards. The same task may work with other administrator user accounts, and also for the same administrator accounts on other workstations. Resetting the user password may also work through other tools, for example using the LDIFDE as outlined in [How to set a user's password with Ldifde](set-user-password-with-ldifde.md).

## Cause

The dialog handler function encrypts the new password strings when it pulls them from the edit controls. The encryption fails because it doesn't find the supporting files in the user **AppData** folder in the following location:  
%AppData%\\Microsoft\\Protect\\\<user sid>

This may happen if the **AppData** user shell folder is redirected to a different location without moving or copying the original data. The folder location is specified in the **AppData** registry value in the following registry location:  
`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`

## Resolution

To resolve the problem, either move or copy the original data to the redirected location, or revert the redirection of the AppData folder.

Using the Process Monitor tool, you can see the LSASS.EXE process will fail to open files in the AppData path after the new password dialog is acknowledged. For more information about the Process Monitor tool, visit the following Microsoft Web site:  
[Process Monitor v3.60](/sysinternals/downloads/procmon)

## More information

Microsoft recommends using Folder Redirection Policies to redirect parts of the user profile to different locations. These policies also allow the contents of the folder to be moved automatically.
