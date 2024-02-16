---
title: Inherited permissions aren't automatically updated
description: Provides a solution to an issue where inherited permissions aren't automatically updated when you move folders.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, oweindl
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# Inherited permissions are not automatically updated when you move folders

This article provides a solution to an issue where inherited permissions aren't automatically updated when you move folders.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 320246

## Symptoms

An Access Control List (ACL) may show permissions that are marked as having been inherited from the parent, but the parent itself may not have these permissions configured in its ACL. This symptom may occur even though inheritance is still enabled. Any subsequent change to the parent folder's ACL causes the child's ACL to receive the inherited permissions. Also, any attempt to change the ACL of the child causes the inheritance to be applied (unless the change marks the ACL as being protected from inheritance). This behavior may be surprising if the inheritance state had not been noted before you start to edit the ACL.

> [!NOTE]
> This behavior cannot be caused by moving a folder when you are running a Windows Vista based computer. The move operation now works because the folder or the file can inherit ACL of the target folder or file. The folder or file also has permissions that are marked as having been inherited from the parent. This is a change by design from Windows XP to Windows Vista and Windows Server 2008.

## Cause

This behavior may be caused by moving a folder. When you move a folder, the ACL is not changed, and the inherited permissions are not updated. Note that *move* in the context of this article always means to move within the same volume.

When you move a file or folder, the ACL is also moved and is not changed in any way. Even when inheritance is enabled for this folder, the inherited permissions are not automatically updated. The ACL will be updated the next time you change permissions, and this forces the parent to propagate its permissions.

This behavior can also be caused by:

- Setting the permissions of a parent folder by using CACLS does not propagate to the subfolders. The /T option does not mean to propagate the rights by using inheritance, but to overwrite all ACLs.

- Setting the permissions of a parent folder by using an API that does not automatically propagate inheritance (like Adssecurity.dll).

- Restoring from a backup to a different location.

## Resolution

To avoid unexpected permission changes, set the ACL of the file/folder to *protected* before moving when you want to keep the settings. Otherwise, manually update the ACL of the moved file/folder by using the explorer ACL editor. Disable and then enable inheritance again to force the ACL to be updated with the right inherited permissions. You may also use a VBScript to automate this process.

## Status

This behavior is by design. This behavior does not occur due to the design modification in Windows Vista.

## Steps to reproduce the behavior

1. Create a *test1* folder with **everyone:read** and **users:change** permissions.
2. Create a test1\sub subfolder and enable the inheritance from parent (default). This folder should show **everyone:read** and **users:change** as inherited permissions.
3. Create another folder *test2* with only **administrators:full control** permissions.
4. Move the *sub* subfolder to test2.
5. View the permissions on test2\sub to see **everyone:read** and **users:change** as inherited permissions although the parents permission is **administrators:full control**.
6. Add another group/user (such as guest) to the ACL of sub granting, for example, Read access using the explorer ACL editor. After you click **Apply**, **everyone:read** and **users:change** is removed, and only **administrators:full control** is displayed as inherited permissions beside the one you just added.
