---
title: Explorer-style common file dialog box doesn't display folder names
description: Describes an issue that the Explorer-style common file dialog box doesn't display folder names longer than 67 characters.
ms.date: 06/11/2025
ms.custom: sap:Desktop app UI development\Windows controls and common dialogs
ms.reviewer: karywa, davean, v-sidong
---
# Explorer-style common file dialog box doesn't display folder names longer than 67 characters

## Symptoms

Consider the following scenario:

- You use the Explorer-style common file dialog box in an application to open or save a document in a folder.
- You navigate to a folder whose name is longer than 67 characters.

In this scenario, you see that the **Look in** combo box is blank.

:::image type="content" source="media/common-dialog-box-not-display-folder-names/look-in-combo-box.png" alt-text="Screenshot of the blank 'Look in' combo box when using common file dialog box to navigate to a folder whose name is longer than 67 characters.":::

## Cause

This problem occurs in applications that use the `GetOpenFileName` and `GetSaveFileName` functions to show Explorer-style common file dialog boxes. The `GetOpenFileName` and `GetSaveFileName` functions return the correct path when a file is selected, even though the folder name isn't displayed.

## Status

Microsoft has confirmed this is a problem in Windows 7, Windows Server 2008, and later versions.

## More information

Applications that use [IFileDialog](/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifiledialog) to show common file dialog boxes aren't affected.
