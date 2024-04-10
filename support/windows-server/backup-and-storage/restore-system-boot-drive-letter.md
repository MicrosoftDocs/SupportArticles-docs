---
title: Restore system/boot drive letter
description: Describes how to change the system or boot drive letter in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Partition and volume management , csstroubleshoot
---
# Restore the system or boot drive letter in Windows  

This article describes how to change the system or boot drive letter in Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 223188

## Summary

> [!WARNING]
> Don't use the procedure that's described in this article to change a drive on a computer where the drive letter hasn't changed. If you do so, you may not be able to start your operating system. Follow the procedure that's described in this article only to recover from a drive letter change, not to change an existing computer drive to something else. Back up your registry keys before you make this change.

This article describes how to change the system or boot drive letter. Usually it isn't recommended, especially if the drive letter is the same as when Windows was installed. The only time that you may want to do so is when the drive letters get changed without any user intervention. It may happen when you break a mirror volume or there's a drive configuration change. This situation should be a rare occurrence, and you should change the drive letters back to match the initial installation.

To change or swap drive letters on volumes that can't otherwise be changed using the Disk Management snap-in, use the following steps.

> [!NOTE]
> In these steps, drive D refers to the (wrong) drive letter assigned to a volume, and drive C refers to the (new) drive letter you want to change to, or to assign to the volume.

This procedure swaps drive letters for drives C and D. If you don't need to swap drive letters, name the `\DosDevice\letter: value` to any new drive letter not in use.

## Change the system or boot drive letter

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Make a full system backup of the computer and system state.
2. Sign in as an Administrator.
3. Start Regedt32.exe.
4. Locate the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices`

5. Select **MountedDevices**.
6. On the **Security** menu, select **Permissions**.
7. Verify that Administrators have full control. Change it back when you are finished with these steps.
8. Quit Regedt32.exe, and then start Regedit.exe.
9. Locate the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices`

10. Find the drive letter you want to change to (new). Look for `\DosDevices\C:`.
11. Right-click `\DosDevices\C:`, and then select **Rename**.

    > [!NOTE]
    > You must use Regedit instead of Regedt32 to rename this registry key.

12. Rename it to an unused drive letter `\DosDevices\Z:`.

    It frees up drive letter C.

13. Find the drive letter you want changed. Look for `\DosDevices\D:`.
14. Right-click `\DosDevices\D:`, and then select **Rename**.
15. Rename it to the appropriate (new) drive letter `\DosDevices\C:`.
16. Select the value for `\DosDevices\Z:`, select **Rename**, and then name it back to `\DosDevices\D:`.
17. Quit Regedit, and then start Regedt32.
18. Change the permissions back to the previous setting for Administrators. It should probably be Read Only.
19. Restart the computer.
