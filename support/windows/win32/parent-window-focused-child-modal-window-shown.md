---
title: A parent window is focused when its child modal window is shown
description: Provides resolution for an issue where a parent window gets focused even its child modal window is shown.
ms.date: 09/15/2022
ms.custom: sap:Desktop app UI development
ms.reviewer: hihayak
ms.technology: windows-dev-apps-desktop-app-ui-dev
auhtor: hihayak
ms.author: v-sidong
---
# A parent window is focused when its child modal window is shown

This article provides resolution for an issue where a parent window is focused when its child modal window is shown.

## Symptoms

If an application is made by using [Windows Forms .NET](/dotnet/desktop/winforms/overview) or [WPF .NET](/dotnet/desktop/wpf/overview), when a user selects the parent window from the preview windows on the taskbar,
the parent window can get focused, even if it's showing a child modal window on the top level of the screen.

Suppose there are a parent window and child window that are created by using [System.Windows.Forms.Form.ShowDialog](/dotnet/api/system.windows.forms.form.showdialog) or [System.Windows.Window.ShowDialog](/dotnet/api/system.windows.window.showdialog) method as below. Usually, the parent window doesn’t get focused even if the user selects it during the child modal window is shown.

:::image type="content" source="media/parent-window-focused-child-modal-window-shown/child-window-shown.png" alt-text="Screenshot of the child window that is shown.":::

If you hover the mouse cursor on the icon of the application shown on the taskbar, you’ll see the preview windows as below.

:::image type="content" source="media/parent-window-focused-child-modal-window-shown/preview-window.png" alt-text="Screenshot of the preview windows.":::

Then, if you select the parent window from the preview windows, you’ll see the parent window gets focused as below.

:::image type="content" source="media/parent-window-focused-child-modal-window-shown/parent-window-focused.png" alt-text="Screenshot of the parent window that is focused.":::

## Resolution

To avoid any issues caused by the focused parent window, use one of the following methods:

- Method 1

    Set [System.Windows.Forms.Form.ShowInTaskbar](/dotnet/api/system.windows.forms.form.showintaskbar) property or [System.Windows.Window.ShowInTaskbar](/dotnet/api/system.windows.window.showintaskbar) property of the parent window to `false` until the child window is closed, so that the user can't choose the parent window from the preview windows on the taskbar.

- Method 2

    Set [System.Windows.Forms.Control.Enabled](/dotnet/api/system.windows.forms.control.enabled) property or [System.Windows. UIElement.IsEnabled](/dotnet/api/system.windows.uielement.isenabled) property to `false` until the child window is closed, so that the parent window doesn’t respond even if it gets focused.
