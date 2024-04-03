---
title: Explorer-style common file dialog box doesn't display folder names
description: Describes an issue that the Explorer-style common file dialog box doesn't display folder names longer than 67 characters.
ms.date: 04/03/2024
ms.custom: sap:Desktop app UI development\Windows controls and common dialogs
ms.reviewer: karywa, davean, v-sidong
ms.topic: article
---
# Explorer-style common file dialog box doesn't display folder names longer than 67 characters

## Symptoms

Consider the following scenarios:

- You use the Explorer-style common file dialog box in an application to open or save a document in a folder.
- You navigate to a folder whose name is longer than 67 characters.

In this scenario, you see that the **Look in** combo box is blank.

:::image type="content" source="media/common-dialog-box-not-display-folder-names/look-in-combo-box.png" alt-text="Screenshot of the blank "Look in" combo box when using common file dialog box to navigate to a folder whose name is longer than 67 characters.":::

## Cause

This problem occurs in applications showing Explorer-style common file dialog boxes using the `GetOpenFileName` and `GetSaveFileName` functions. The `GetOpenFileName` and `GetSaveFileName` functions return the correct path when a file is selected even though the folder name isn't displayed.

## Status

Microsoft has confirmed this is a problem in Windows 7, Windows Server 2008, and later versions.

## More information

Applications showing common file dialog boxes using [IFileDialog](/windows/win32/api/shobjidl_core/nn-shobjidl_core-ifiledialog) aren't affected.
