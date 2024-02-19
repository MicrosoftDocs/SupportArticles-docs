---
title: Continue dialog box for folder access in Windows Explorer when user only has access with elevated token
description: Describes an issue in which your user ID is added to the ACL list for a directory that you don't have permissions, and you receive an access denied message when accessing a folder which you don't have read permissions with Windows Explorer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davemid, kbsec
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# When you select Continue for folder access in Windows Explorer, your user account is added to the ACL for the folder

This article provides a solution to an issue when you select **Continue** to gain access to a file system folder for which you don't have Read permissions.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 950934

## Introduction

This article describes a scenario in which Windows Explorer prompts you to select **Continue** to gain access to a file system folder for which you don't have Read permissions. It also describes workarounds to avoid particular aspects of this behavior. This issue occurs in Windows Vista and later versions of Windows and in Windows Server 2008 and later versions of Windows Server. Windows Explorer is called File Explorer in Windows 8 and later versions.

## More information

Assume that User Account Control (UAC) is enabled, and you use Windows Explorer to access a folder for which you don't have Read permissions. Additionally, the folder is not marked by both the Hidden and System attributes. In this situation, Windows Explorer displays a dialog box that prompts you with the following message:

> You don't currently have permission to access this folder. Click Continue to permanently get access to this folder.

> [!NOTE]
> In Windows Vista and Windows Server 2008, the second sentence doesn't include the word permanently; it just says **Click Continue to get access to this folder.**

You then can select **Continue** or **Cancel**. (Continue is selected by default.) If you select **Continue**, UAC tries to obtain administrative rights on your behalf. Depending on the UAC security settings that control the behavior of the UAC elevation prompt, and on whether you're a member of the Administrators group, you may be prompted for consent or for credentials. Or, you may not be prompted at all. If UAC can obtain administrative rights, a background process will change the permissions on the folder, and on all its subfolders and files, to grant your user account access to them. In Windows Vista and Windows Server 2008, the background process grants your user account Read and Execute permissions. In later versions of Windows, this process grants your user account Full Control.

This behavior is by design. But because the typical pattern with UAC elevation is to run an instance of the elevated program with administrative rights, users may expect that by selecting **Continue**, which will generate an elevated instance of Windows Explorer, and not make permanent changes to file system permissions. However, this expectation isn't possible, as Windows Explorer's design doesn't support the running of multiple process instances in different security contexts in an interactive user session.

If UAC is disabled, UAC elevation isn't possible. All programs that are run by members of the Administrators group, including Windows Explorer, always have administrative rights. So administrators don't need to use elevation to access resources that require administrative rights. For example, if a folder grants access only to the Administrators group and the System account, an administrator can browse it directly without being prompted to alter the folder's permissions. If the user doesn't have Read permissions, Windows Explorer displays the dialog box that was described earlier. However, if UAC is disabled, Windows can't request administrative credentials for the user through a UAC elevation prompt. So Windows won't start a background process with administrative permissions to change file system permissions.

However, if the user selects **Continue** and the folder's current security descriptor grants the user permission to both read and change the object's permissions, Windows will start the background process in the user's current security context and modify the folder's permissions to grant the user greater access, as described earlier. The user may have permission to read and change the object's permissions from object ownership or from the object's access control list (ACL).

## Known issues

This feature may cause unexpected behavior. For example, assume that you belong to the Administrators group and that you use Windows Explorer to access a folder that requires administrative access. After the permissions have been changed, any program that's running through your user account can have full control of the folder, even if the program isn't elevated and even after your account has been removed from the Administrators group. Such altered permissions may violate an organization's security policies and may be flagged in a security audit. Additionally, if a program verifies file system permissions, it may refuse to run if the permissions have been changed.

UAC should remain enabled in all cases except under the constrained circumstances that are described in [How to disable User Account Control (UAC) on Windows Server](disable-user-account-control.md).

## Workaround 1

To avoid changing permissions in a folder that's accessible only to administrators, consider using another program that can run elevated instead of using Windows Explorer. Examples include Command Prompt, PowerShell, and the Computer Management MMC snap-in for share management.

## Workaround 2

If you have an application-specific folder that's locked down to prevent ordinary users from accessing it, you can also add permissions for a custom group and then add authorized users to that group. For example, consider a scenario in which an application-specific folder grants access only to the Administrators group and to the System account. In this situation, create a domain or a local AppManagers group, and then add authorized users to it. Then, use a utility such as icacls.exe, the security tab of the folder's Properties dialog box, or the PowerShell Set-Acl cmdlet to grant the AppManagers group Full Control of the folder, in addition to the existing permissions.

Users who are members of AppManagers can use Windows Explorer to browse the folder without UAC having to change the folder's permissions. This alternative applies only to application-specific folders. You should never make any permission changes to folders that are part of the Windows operating system, such as `C:\Windows\ServiceProfiles`.
