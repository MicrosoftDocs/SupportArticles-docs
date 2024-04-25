---
title: File Explorer's navigation bar doesn't update when navigating shell namespace extension folders
description: Describes a problem where File Explorer's navigation bar doesn't update when navigating folders in a shell namespace extension.
ms.reviewer: davean, v-sidong
ms.custom: sap:Desktop app UI development\Windows Shell API
ms.date: 04/25/2024
---

# File Explorer's navigation bar doesn't update when navigating shell namespace extension folders

This article describes a problem where Files Explorer's navigation bar doesn't update when navigating folders in a shell namespace extension.

## Symptoms

After you install [KB 5031455](https://support.microsoft.com/topic/october-31-2023-kb5031455-os-builds-22621-2506-and-22631-2506-preview-6513c5ec-c5a2-4aaf-97f5-44c13d29e0d4) on Windows 11 version 22H2 or Windows 11 version 23H3, File Explorer's navigation bar won't update to show the current folder when navigating folders in some shell namespace extensions. Additionally, File Explorer's navigation bar can't be used to navigate folders in the same shell namespace extensions.

## Status

Microsoft has confirmed this is a problem in Windows 11 version 22H2 and 23H3.

## Workaround

Application developers can mitigate this issue by updating their shell namespace extensions to:

1. Implement the [IExplorerPaneVisibility](/windows/win32/api/shobjidl_core/nn-shobjidl_core-iexplorerpanevisibility) interface and return `EPS_DEFAULT_ON` when [IExplorerPaneVisibility::GetPaneState](/windows/win32/api/shobjidl_core/nf-shobjidl_core-iexplorerpanevisibility-getpanestate) is called with `EP_Ribbon`.

1. Implement the [IFolderView2](/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifolderview2) interface and support that [IFolderView::GetFolder](/windows/win32/api/shobjidl_core/nf-shobjidl_core-ifolderview-getfolder) returns an [IShellItem](/windows/win32/api/shobjidl_core/nn-shobjidl_core-ishellitem) interface for the current folder.

## More information

With a namespace extension, application developers can take any body of data and have Windows Explorer present it to the user as a virtual folder. When a user browses into this folder, application data is presented as a tree-structured hierarchy of folders and files. Users and applications can interact with the contents of this virtual folder in much the same way as with any other namespace object.

For more information, see:

- [Introduction to the Shell Namespace](/windows/win32/shell/namespace-intro)

- [Understanding Shell Namespace Extensions](/windows/win32/shell/namespace-intro)
