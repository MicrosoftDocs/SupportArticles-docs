---
title: Run a logon script once a new user logs on
description: Describes how to configure a logon script or program to run one time when a user signs in to a computer for the first time.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, BOBQIN
ms.custom: sap:windows-script-host-cscript-or-wscript, csstroubleshoot
---
# How to run a logon script one time when a new user logs on in Windows Server 2003

This article describes how to configure a logon script or program to run one time when a user signs in to a computer for the first time.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325347

## Summary

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

These steps apply only to new users who have never logged on to the computer. If a user already has a local user profile or a roaming profile, the script or program doesn't run.

## Configure a script to run one time when a new user signs in

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

When a Windows Server 2003-based product is installed, the Default User profile is created. The first time that a user logs on, the Default User profile is copied to the user's profile.

To configure a script or program to run when a new user logs on, follow these steps:

1. Select **Start**, and then select **Run**.
2. In the **Open** box, type regedit.exe, and then select **OK**.
3. Locate the following subkey in the registry:  
    HKEY_USERS
4. On the **File** menu, select **Load Hive**.
5. In the **Load Hive** dialog box, locate the **Profilepath** \Default User\Ntuser.dat file, where **Profilepath** is the file system location of the Default User profile. Select **Open**.
6. In the **Load Hive** dialog box type a name for the hive, and then select **OK**.

    > [!NOTE]
    > The Ntuser.dat file is hidden. If you can't locate or load the Ntuser.dat file, you must change your view settings in Windows Explorer. To do it, follow these steps:

    1. Select **Start**, and then select **Windows Explorer**.
    2. Select **Tools**, and then select **Folder Options**.
    3. Select the View tab.
    4. Click to clear the **Hide extensions for known file types** check box.
    5. Select **Show hidden files and folders**, and then select **OK**.
7. Locate the following subkey in the registry:
    `HKEY_USERS\Test\Software\Microsoft\Windows\CurrentVersion\Runonce`
    > [!NOTE]
    > Where *Test* is the name that you gave to the Ntuser.dat hive in step 6.
8. On the **Edit** menu, point to **New**, and then select **String Value**.
9. In the right pane, double-click the new value.
10. In the **Edit String** dialog box, type the full path and file name for the program or logon script, and then select **OK**.
11. In the left pane, select the **Test hive**.
12. On the **File** menu, select **Unload Hive**.
13. Select **Yes** when prompted to confirm you want to unload the hive.
14. Quit Registry Editor. This program or logon script runs for a user who doesn't have a user profile. To view the user profiles on the local computer, follow these steps:

    1. Select **Start**, point to **Control Panel**, and then select **System**.
    2. Select the **Advanced** tab.
    3. In the User Profiles area, select **Settings**.  
        The user profiles are listed in the User Profiles dialog box.
