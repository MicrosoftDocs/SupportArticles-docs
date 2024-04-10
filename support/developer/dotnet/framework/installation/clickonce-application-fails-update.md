---
title: ClickOnce application fails to update
description: ClickOnce depends on a file and registry cache to keep track of the present installed applications.
ms.date: 05/06/2020
ms.custom: sap:Installation
ms.reviewer: nikolam
---
# ClickOnce applications fail to update

This article helps you resolve a problem where ClickOnce application fails to update.

_Original product version:_ &nbsp; .NET Framework 3.5 Service Pack 1, 3.5.1  
_Original KB number:_ &nbsp; 2713442

## Symptoms

Consider this scenario. You have a ClickOnce application that always succeeds when first installed. However, during subsequent launches the ClickOnce application fails while checking for updates. It appears to be random, but more prevalent when there's an update available.

Another way to determine if this article applies is if the problem is corrected even temporarily by deleting the ClickOnce File Cache.

## Cause

Anything that interrupts the synchronization between the file system and the registry data can cause a ClickOnce application update to fail.

- An incomplete System Restore that restores only the files but not the user profile. The registry key `HKEY_CURRENT_USER\Software\Classes\Software\Microsoft\Windows\CurrentVersion\Deployment\SideBySide\2.0` should be in the same state as the files in the following folders:

  - Windows XP: `%userprofile%\Local Settings\Apps\2.0\*.*`

  - Windows Vista and later: `%userprofile%\AppData\Local\Apps\2.0\*.*`

- Roaming Profiles aren't supported for the same reason; the potential of the files not matching the registry data. See [Microsoft ClickOnce deployment is not supported with Roaming Profiles](https://support.microsoft.com/help/2571899).
- Ungraceful operating system shutdowns such as a power failure.
- Ungraceful sign out such as powering off machine rather than sign out or shut down.

## Resolution

Besides avoiding the scenarios listed in the [Cause](#cause) section, some reduction on corruption can be seen by using the .NET Framework 4.0, or later on the target machines. The .NET Framework 4.0 has improvements that make it more robust resulting in fewer update failures compared to the earlier framework versions. The application doesn't have to be developed using the .NET Framework 4.0. It just needs to be installed on the target machines.

The mitigation for these issues continues to be:

- Attempt to uninstall the application from **Add and Remove Programs** (ARP, Windows XP) or **Programs and Features** (Windows Vista and later operating systems).
- If the program doesn't uninstall successfully, to delete the ClickOnce file cache.

## Delete the ClickOnce file cache

To delete the ClickOnce file cache, delete the contents of this folder based on the operating system.

- Windows XP and Server 2003 - `%userprofile%\Local Settings\Apps\2.0\*.*`
- Windows Vista and Server 2008  and later - `%userprofile%\AppData\Local\Apps\2.0\*.*`

Deleting these files will clear the information for all installed ClickOnce applications. They'll reinstall the next time their shortcut or Uniform Resource Identifiers (URIs) are used.

It isn't necessary to delete the registry data. For reference, the ClickOnce registry data is located in `HKEY_CURRENT_USER\Software\Classes\Software\Microsoft\Windows\CurrentVersion\Deployment\SideBySide\2.0`.
