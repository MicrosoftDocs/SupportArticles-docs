---
title: IME cannot trigger PreviewKeyDown event of TextBox in WPF apps
description: Describes the issue that some Microsoft IMEs cannot trigger PreviewKeyDown event of TextBox control in WPF apps.
ms.date: 07/06/2021
Author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: hirotoh
---
# PreviewKeyDown event of TextBox control can't be triggered by Microsoft IME in WPF apps

This article describes the issue that [PreviewKeyDown](/dotnet/api/system.windows.forms.control.previewkeydown) events of TextBox controls can't be triggered by some Microsoft IMEs in Windows Presentation Foundation (WPF) applications.

_Applies to:_ &nbsp; Windows Presentation Foundation, Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1

## Symptoms

Consider the following scenario:

1. You run a WPF application on Windows 10, version 2004, version 20H2, or version 21H1.
1. You input in a TextBox control with a Microsoft IME of East Asia.

In this scenario, the `PreviewKeyDown` event of the control won't be triggered. Some functions of the application depending on the `PreviewKeyDown` event handlers won't work as expected.

## Cause

Microsoft IMEs are updated in some versions of Windows 10. This issue occurs when you use some of the latest Microsoft IMEs.

## Workaround

Turn on the Compatibility option to revert to the previous version of Microsoft IME. To do this, follow these steps:

1. In the search box on the taskbar, type *language settings*, and then select **Language Settings** in the list of results.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-settings.png" alt-text="Language settings" border="true":::

1. Select **Options** of your language.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/language-options.png" alt-text="Language option" border="true":::

1. From the language option settings page, select **Options** of the IME you're using.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-options.png" alt-text="IME option" border="true":::

1. Select **General**

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/ime-general.png" alt-text="general" border="true":::

1. Turn on the **Use previous version of <YourIME>** option and then select **OK** on the popup window.

    :::image type="content" source="./media/cannot-trigger-event-in-wpf-with-ime/turn-on-compatibility.png" alt-text="turn on the previous version option" border="true":::

> [!Note]
> We do not recommend using the compatibility setting for the long term, but rather as a temporary workaround for users who are impacted by this issue.
