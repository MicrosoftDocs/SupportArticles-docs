---
title: Renaming user account doesn't change profile path
description: This article provides a workaround for an issue where renaming a user account doesn't automatically change the profile path.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User profiles
ms.technology: windows-client-user-profiles
---
# Renaming a user account doesn't automatically change the profile path

This article provides a workaround for an issue where renaming a user account doesn't automatically change the profile path.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2454362

## Summary

When you rename a user account on a computer that is running Windows 7 or Windows Server 2008 R2, the user profile path isn't changed automatically. It may cause some confusion when the `%SystemDrive%\users` folder is viewed

## Status

Microsoft has confirmed it to be by design in Windows.

## Workaround

To work around this issue, use the steps below to manually rename the profile path.

1. Log in by using another administrative account.

    > [!NOTE]
    > You may need create a new administrative account at first.

2. Go to the `C:\users\` folder and rename the sub folder with the original user name to the new user name.

3. Go to registry and modify the registry value **ProfileImagePath** to the new path name.

   > [!IMPORTANT]
   > Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\<User SID>\`

   > [!NOTE]
   > Replace \<User SID\> with the SID of your user account.

4. Log out and log in again by using the user whose name is changed, and the user should use the pervious profile with new path name.
