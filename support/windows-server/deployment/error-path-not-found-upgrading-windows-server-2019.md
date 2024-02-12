---
title: ERROR_PATH_NOT_FOUND when upgrading to Windows Server 2019
description: Helps resolve the ERROR_PATH_NOT_FOUND error when performing an in-place upgrade to Windows Server 2019.
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.date: 11/23/2023
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, hamansoor, v-lianna
ms.custom: sap:setup, csstroubleshoot, ikb2lmc
---
# ERROR_PATH_NOT_FOUND error when performing an in-place upgrade to Windows Server 2019

This article helps resolve an issue in which you receive the "ERROR_PATH_NOT_FOUND" error during an in-place upgrade to Windows Server 2019.

When you try to perform an in-place upgrade to Windows Server 2019, the process stops and the "ERROR_PATH_NOT_FOUND" error occurs.

This issue occurs because some user profile references are missing or corrupted.

## Delete the corrupted user profile

To resolve this issue, follow these steps:

1. Determine the affected user profile, and then check the [setupact.log](/windows/deployment/upgrade/log-files) file. For example:

	```output
	<DateTime>, Info MIG Processing profile: C:\Users\<UserProfileName>
	<DateTime>, Info MIG Detected profile with linked profile root: C:\Users\<UserProfileName> => \??\Volume{<Volume ID>}\
	<DateTime>, Info MIG Adding extra mapping: C:\Users\<UserProfileName> => \??\Volume{<Volume ID>}\
	<DateTime>, Info MIG Offline platform: adding mappings:
	<DateTime>, Info MIG AdjustPrivilege: Privilege SeTakeOwnershipPrivilege will be Disabled
	<DateTime>, Info MIG Privilege has been disabled
	<DateTime>, Info MIG AdjustPrivilege: Privilege SeSecurityPrivilege will be Disabled
	<DateTime>, Info MIG Privilege has been disabled
	<DateTime>, Error MigPlatformStartupOffline caught exception: Win32Exception: ??\Volume{<Volume ID>}: The system cannot find the path specified. [0x00000003] class UnBCL::String *__cdecl UnBCL::Path::GetLongName(const class UnBCL::String *)
	```
2. Navigate to the *C:\\Users* folder.
3. Delete the folder of the affected user profile.
4. In Registry Editor, navigate to the following registry key:

	`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`

5. Delete the affected user profile from the registry key.
