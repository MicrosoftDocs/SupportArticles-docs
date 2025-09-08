---
title: IME Can't Trigger PreviewKeyDown Event of TextBox in WPF Apps
description: Discusses an issue that prevents some Microsoft IMEs from triggering PreviewKeyDown events of TextBox controls in WPF apps.
ms.date: 07/08/2025
Author: aartig13
ms.author: aartigoyle
ms.reviewer: hirotoh
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer, I want to fix an issue that prevents IMEs from triggering PreviewKeyDown events so that TextBoxes in my WPF app function correctly.
---
# PreviewKeyDown events of TextBox controls aren't triggered by Microsoft IME in WPF apps

> [!NOTE]
> The issue that's discussed in this article is a bug in Windows 10, versions 2004, 20H2, 21H1, and 21H2. This bug isn't fixed in Windows 10, but it is fixed in Windows 11. To avoid the issue, you can upgrade your system to Windows 11.

This article discusses an issue that prevents [PreviewKeyDown](/dotnet/api/system.windows.forms.control.previewkeydown) events of TextBox controls from being triggered by some Microsoft input method editors (IMEs) in Windows Presentation Foundation (WPF) applications.

_Applies to:_ Windows Presentation Foundation, Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1, Windows 10, version 21H2

## Symptoms

Consider the following scenario:

1. You run a WPF application in Windows 10, version 2004, 20H2, 21H1, or 21H2.
1. You enter text into a TextBox control by using a Microsoft IME of East Asia.

In this scenario, the `PreviewKeyDown` event of the control isn't triggered. Therefore, some functions of the application that depend on the `PreviewKeyDown` event handlers don't work as expected.

## Cause

Microsoft IMEs are updated in some versions of Windows 10. This issue occurs when you use some of the latest Microsoft IMEs.

## Solution

Turn on the **Compatibility** option to revert to the previous version of Microsoft IME. To do this, follow these steps:

1. Select Start, enter *language settings*, and then select **Language settings** in the list of results.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-settings.png" alt-text="Search language settings in the search box." border="true":::

1. Select the **Language options** icon (ellipses) for your language.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-options.png" alt-text="Select language options." border="true":::

1. On the **Options** page, select **Options** for the IME that you're using.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-options.png" alt-text="Select IME options." border="true":::

1. Select **General**.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-general.png" alt-text="Select general." border="true":::

1. Turn on the **Use previous version of \<YourIME\>** option, and then select **OK** in the window that opens.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/turn-on-compatibility.png" alt-text="Screenshot that shows how to turn on compatibility mode and verify the IME version change." border="true":::
