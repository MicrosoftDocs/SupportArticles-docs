---
title: Terminal Server user's Home Directory is not set correctly
description: Provides a resolution to an issue where Terminal Server user's Home Directory is not set correctly
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Terminal Server user's Home Directory is not set correctly

This article provides a resolution to an issue where Terminal Server user's Home Directory is not set correctly.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 230165

## Symptoms

Home directories are not mapped correctly for users with existing profiles. Their home directory and root drive point to the default path of %SystemRoot%\Profiles\%Username%. The drive letter set in the home directory connect box does appear in My Computer in the Terminal Server session. No error messages are displayed to the user.

## Cause

This problem occurs because the user's profile already contains a drive mapped to the same drive letter that was specified for the user's home directory. After the system finds that the drive letter is already in use, it does not map the drive and does not correctly set the homepath or homedrive variables. The user retains the default settings pointing to:

- Home Directory Path: %SystemRoot%\Profiles\%Username%
- HOMEDRIVE=C:
- HOMEPATH=\Wtsrv\Profiles\%Username%

It also affects the root drive because it is set through the Usrlogon.cmd script when the user logs on. Listed below is the portion of Usrlogon.cmd that connects rootdrive:  

```console
Rem Map the User's Home Directory to a Drive Letter
Rem

Net Use %RootDrive% /D >NUL: 2>&1
Subst %RootDrive% /d >NUL: 2>&1
Subst %RootDrive% %HomeDrive%%HomePath%
```

## Resolution

To resolve this issue, delete the mapped drive from the user's profile or set the home directory to another drive letter.
