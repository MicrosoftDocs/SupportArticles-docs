---
title: Group Policy is not applied to a user account for RunAs.exe or "Run as different user"
description: Provides some information for the issue where group Policy is not applied to a user account for RunAs.exe or "Run as different user"
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Group Policy is not applied to a user account for RunAs.exe or "Run as different user"

This article provides some information for the issue where Group Policy is not applied to a user account for RunAs.exe or "Run as different user".

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4569309

## Summary

A Windows user can run a program or application as a different user. To do this, the user selects the **Run as different user** context menu command (or uses the Runas.exe command-line tool), and then specifies the credentials of an alternate account.  

As a best practice, users should do their usual work on their workstations by using their own credentials. They can specify the credentials of an alternate account (such as an account that has elevated permissions) to run a specific application, as necessary.  

However, when a user signs in by using alternate credentials, Windows does not process Group Policy settings for the alternate account. Windows processes Group Policy settings for a user account only if the user signs in to their own desktop by using the sign-in user interface. By contrast, when a user starts an application by using Runas.exe or **Run as different user**, Windows starts a separate process that runs under the alternate credentials. Such an operation does not trigger Group Policy processing.  

This behavior is by design.

## More information

> [!Important]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.  

Group Policy settings are not intended to apply to the alternate user account that is specified by Runas.exe or **Run as different user**.  

Runas.exe can load the user profile that is associated with the alternate account. If a user previously signed in to Windows on that workstation by using that account, the associated user profile might contain registry keys and values that were set by Group Policy processing events at that time. However, this behavior depends on whether the user includes the `/noprofile` switch in the command. If the user starts a process or application by using `runas /noprofile`, and then specifies the alternate account, Windows does not load the alternate user profile. Therefore, the alternate user profile does not provide a reliable way to apply Group Policy settings.  

If you want to prevent users from using Runas.exe or **Run as different user**, follow these steps.

> [!Important]
> After you apply these settings, any functionality that depends on the "Run as" feature does not work.

1. Disable the **Secondary Logon** service (seclogon.exe).
2. Use Software Restriction Policies or AppLocker to prevent access to the Runas.exe binary file.
3. Use Group Policy to remove the **Run as different user** menu item. The Group Policy Object (GPO) changes to User Configuration\\Administrative Templates\\Start Menu and Taskbar\\Show "Run as different user" command on Start.
4. In the Windows registry, set the following entry:

    - Subkey: `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\`
    - Entry name: HideRunAsVerb
    - Type: DWORD
    - Value: 1
