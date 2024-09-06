---
title: File Explorer's navigation bar doesn't update when navigating shell namespace extension folders
description: Describes a problem where File Explorer's navigation bar doesn't update when navigating folders in a shell namespace extension.
ms.reviewer: davean, v-sidong
ms.custom: sap:Desktop app UI development\Windows Shell API
ms.date: 09/02/2024
---

# File Explorer's navigation bar doesn't update when navigating shell namespace extension folders

This article describes a problem where File Explorer's navigation bar doesn't update when navigating folders in a shell namespace extension.

## Symptoms

After you install [KB 5031455](https://support.microsoft.com/topic/october-31-2023-kb5031455-os-builds-22621-2506-and-22631-2506-preview-6513c5ec-c5a2-4aaf-97f5-44c13d29e0d4) on Windows 11, version 22H2 or Windows 11, version 23H2, File Explorer's navigation bar doesn't update to show the current folder when navigating folders in some shell namespace extensions. Additionally, File Explorer's navigation bar can't be used to navigate folders in the same shell namespace extension.

## Status

This issue is fixed in [KB5041587](https://support.microsoft.com/topic/august-27-2024-kb5041587-os-builds-22621-4112-and-22631-4112-preview-9706ea0e-6f72-430e-b08a-878963dafe08).

## More information

With a namespace extension, application developers can take any body of data and have Windows Explorer present it to the user as a virtual folder. When a user browses this folder, the application data is presented as a tree-structured hierarchy of folders and files. Users and applications can interact with the contents of this virtual folder in much the same way as with any other namespace object.

For more information, see the following articles:

- [Introduction to the Shell Namespace](/windows/win32/shell/namespace-intro)

- [Understanding Shell Namespace Extensions](/windows/win32/shell/nse-works)
