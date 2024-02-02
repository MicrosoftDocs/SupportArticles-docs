---
title: You cannot toggle the results pane
description: This article provides a workaround for the problem in which you cannot toggle the results pane in SQL Server Management Studio in SQL Server.
ms.date: 09/25/2020
ms.custom: sap:Management Studio
ms.reviewer: ramakoni
---
# You cannot toggle the results pane in SQL Server Management Studio

This article helps you resolve the problem in which you cannot toggle the results pane in SQL Server Management Studio in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2860024

## Symptoms

When you use SQL Server Management Studio (SSMS) in SQL Server 2012 or later versions, the ability to toggle the results pane may be missing. Therefore, you will not see the **Hide Results Pane**  shortcut or the **Show Results Pane**  shortcut on the **Window**  menu. Additionally, when you press Ctrl+R, the visibility of the results pane does not toggle.

:::image type="content" source="media/cannot-toggle-results-pane/window-menu.png" alt-text="Screenshot of the Window menu in SQL Server Management Studio." border="false":::

> [!NOTE]
> When you press Ctrl+R, you receive the following message in the status bar:

(Ctrl+R) was pressed. Waiting for second key of chord...

## Cause

This issue occurs because the `.vssettings` file for SSMS is corrupted.

> [!NOTE]
> By default, this file is named *NewSettings.vssettings* and is located in the following folder:
>
>`%USERPROFILE%\Documents\SQL Server Management Studio\Settings\SQL Server Management Studio`

Note: For SSMS 18.x versions, the `.vssetting` file is located in the following folder:

`%LOCALAPPDATA%\Microsoft\SQL Server Management Studio\18.0_IsoShell\Settings\SQL Server Management Studio`

## Workaround

To work around this issue, reset the default keyboard-mapping scheme. To do this, follow these steps:

1. Open SQL Server Management Studio.
2. On the menu bar, click **Tools**, and then click **Options**.
3. In the tree-view pane on the left side of the dialog box, click **Keyboard**.
4. Click **Reset**  to reset the default keyboard-mapping scheme.
5. In the dialog box that appears, click **Yes**.
6. Click **OK**.

:::image type="content" source="media/cannot-toggle-results-pane/keyboard-options.png" alt-text="Screenshot of the Keyboard settings in Options of SQL Server Management Studio.":::
