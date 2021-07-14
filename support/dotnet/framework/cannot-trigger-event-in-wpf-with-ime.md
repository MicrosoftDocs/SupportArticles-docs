---
title: IME cannot trigger PreviewKeyDown event of TextBox in WPF apps
description: Describes the issue that some Microsoft IMEs cannot trigger PreviewKeyDown event of TextBox control in WPF apps.
ms.date: 07/06/2021
Author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: hirotoh
---
# PreviewKeyDown event of TextBox control can't be triggered by Microsoft IME in WPF apps                                                                                                                                                                                
This article discusses an issue that prevents [PreviewKeyDown](/dotnet/api/system.windows.forms.control.previewkeydown) events of TextBox controls from being triggered by some Microsoft  input method editors (IMEs) in Windows Presentation Foundation (WPF) applications.

_Applies to:_ &nbsp; Windows Presentation Foundation, Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1

## Symptoms

Consider the following scenario:

1. You run a WPF application on Windows 10, version 2004, version 20H2, or version 21H1.
1. You input in a TextBox control by using a Microsoft IME of East Asia.

In this scenario, the `PreviewKeyDown` event of the control is not triggered. Therefore, some functions of the application that depend on the `PreviewKeyDown` event handlers don't work as expected.

## Cause

Microsoft IMEs are updated in some versions of Windows 10. This issue occurs when you use some of the latest Microsoft IMEs.

## Workaround

Turn on the **Compatibility** option to revert to the previous version of Microsoft IME. To do this, follow these steps:

1. In the search box on the taskbar, enter **language settings**, and then select **Language settings** in the list of results.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-settings.png" alt-text="Language settings" border="true":::

1. Select **Options** for your language.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-options.png" alt-text="Language option" border="true":::

1. On the language option settings page, select **Options** for the IME that you're using.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-options.png" alt-text="IME option" border="true":::

1. Select **General**.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-general.png" alt-text="general" border="true":::

1. Turn on the **Use previous version of <YourIME>** option, and then select **OK** in the window that opens.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/turn-on-compatibility.png" alt-text="turn on the previous version option" border="true":::

> [!Note]
> We recommend that you do not use the compatibility setting as a permanent solution. Instead, use it as a temporary workaround for users who are affected by this issue.
