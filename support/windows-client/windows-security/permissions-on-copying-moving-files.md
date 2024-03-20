---
title: Permissions when you copy and move files
description: Describes how Windows Explorer handles file and folder permissions in different situations.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Security Technologies\AD Object Permissions, access control, delegation, AdminSDHolder and auditing, csstroubleshoot
---
# How permissions are handled when you copy and move files and folders

This article describes how Windows Explorer handles file and folder permissions in different situations.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 310316

## Summary

In Microsoft Windows 2000, in Windows Server 2003, and in Windows XP, you have the option of using either the FAT32 file system or the NTFS file system. When you use NTFS, you can grant permissions to your folders and files to control access to those objects. When you copy or move a file or folder on an NTFS volume, how Windows Explorer handles the permissions on the object varies, depending on whether the object is copied or moved within the same NTFS volume or to a different volume.

## More information

By default, an object inherits permissions from its parent object, either at the time of creation or when it is copied or moved to its parent folder. The only exception to this rule occurs when you move an object to a different folder on the same volume. In this case, the original permissions are retained.

Additionally, note the following rules:

- The Everyone group is granted **Allow Full Control** permissions to the root of each NTFS drive.
- Deny permissions always take precedence over **Allow** permissions.
- Explicit permissions take precedence over inherited permissions.
- If NTFS permissions conflict, for example, if group and user permissions are contradictory, the most liberal permissions take precedence.
- Permissions are cumulative.
- To preserve permissions when files and folders are copied or moved, use the Xcopy.exe utility with the `/O` or the `/X`switch.

    The object's original permissions will be added to inheritable permissions in the new location.
- To add an object's original permissions to inheritable permissions when you copy or move an object, use the Xcopy.exe utility with the `-O` and `-X` switches.
- To preserve existing permissions without adding inheritable permissions from the parent folder, use the Robocopy.exe utility, which is available in the Windows 2000 Resource Kit.

You can modify how Windows Explorer handles permissions when objects are copied or moved to another NTFS volume. When you copy or move an object to another volume, the object inherits the permissions of its new folder. However, if you want to modify this behavior to preserve the original permissions, modify the registry as follows.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type *regedit* in the **Open** box, and then press ENTER.
2. Locate and then click the registry key: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer`.
3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    - Value name: ForceCopyAclwithFile
    - Data type: DWORD
    - Value data: 1

4. Exit Registry Editor.

You can modify how Windows Explorer handles permissions when objects are moved in the same NTFS volume. As mentioned, when an object is moved within the same volume, the object preserves its permissions by default. However, if you want to modify this behavior so that the object inherits the permissions from the parent folder, modify the registry as follows:

1. Click **Start**, click **Run**, type *regedit*, and then press ENTER.
2. Locate and then click the registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer`.
3. On the **Edit** menu, click **Add Value**, and then add the following registry value:

    - Value name: MoveSecurityAttributes
    - Data type: DWORD
    - Value data: 0

4. Exit Registry Editor.
5. Make sure that the user account that is used to move the object has the **Change Permissions** permission set. If the permission is not set, grant the **Change Permissions** permission to the user account.

> [!NOTE]
> The **MoveSecurityAttributes** registry value only applies to Windows XP and to Windows Server 2003. The value does not affect Windows 2000.
