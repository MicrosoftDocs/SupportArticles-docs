---
title: A parent window gets focused when its child window is shown
description: Provides resolutions for an issue where a parent window gets focused when its child window is shown.
ms.date: 09/15/2022
ms.custom: sap:Desktop app UI development
ms.reviewer: hihayak
ms.technology: windows-dev-apps-desktop-app-ui-dev
auhtor: hihayak
ms.author: v-sidong
---
# A parent window gets focused when its child window is shown

This article provides resolutions for an issue where a parent window gets focused from the taskbar even if its child window shows in front of it.

*Applies to*:  all versions of .NET

## Symptoms

If an application is made by using [Windows Forms .NET](/dotnet/desktop/winforms/overview) or [WPF .NET](/dotnet/desktop/wpf/overview), when you select the parent window from the preview windows on the taskbar,
the parent window can get focused, even if its child window shows in front of it.

## More details about the issue

Suppose a parent and child window are created by using the [System.Windows.Forms.Form.ShowDialog](/dotnet/api/system.windows.forms.form.showdialog) or the [System.Windows.Window.ShowDialog](/dotnet/api/system.windows.window.showdialog) method. Usually, the parent window doesn't get focused even if you select it while the child window is shown in front of it, as shown below:

:::image type="content" source="media/parent-window-focused-child-window-shown/child-window-shown.png" alt-text="Screenshot of the child window that is shown.":::

If you hover the mouse over the application icon shown on the taskbar, you'll see the following preview windows:

:::image type="content" source="media/parent-window-focused-child-window-shown/preview-window.png" alt-text="Screenshot of the preview windows.":::

Then, if you select the parent window from the preview windows, you'll see that the parent window gets focused, as shown below:

:::image type="content" source="media/parent-window-focused-child-window-shown/parent-window-focused.png" alt-text="Screenshot of the parent window that is focused.":::

## Resolution

To avoid any issues caused by the focused parent window, use one of the following methods:

- Method 1

    To make sure that the user can't choose the parent window from the preview windows on the taskbar, set the [System.Windows.Forms.Form.ShowInTaskbar](/dotnet/api/system.windows.forms.form.showintaskbar) property or the [System.Windows.Window.ShowInTaskbar](/dotnet/api/system.windows.window.showintaskbar) property of the parent window to `false` until the child window is closed.

- Method 2

    To make sure that the parent window doesn't respond even if it gets focused, set the [System.Windows.Forms.Control.Enabled](/dotnet/api/system.windows.forms.control.enabled) property or the [System.Windows. UIElement.IsEnabled](/dotnet/api/system.windows.uielement.isenabled) property to `false` until the child window is closed.
