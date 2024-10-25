---
title: Error communicating with the emulator
description: Resolves the communicating with the emulator error that occurs when you run the Open terminal session action in Power Automate for desktop.
ms.author: iomavrid
author: YiannisMavridis
ms.reviewer: tapanm
ms.date: 10/25/2024
ms.custom: sap:Desktop flows
---
# "Error communicating with the emulator" when you run Open terminal session with Micro Focus Reflection Desktop

This article provides a resolution for the "Error communicating with the emulator" error that occurs when you run the [Open terminal session](/power-automate/desktop-flows/actions-reference/terminalemulation) action using Micro Focus Reflection Desktop in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

When you run the **Open terminal session** action using Micro Focus Reflection Desktop in Power Automate for desktop, you receive the following error message:

> Error communicating with the emulator

Here are the parameters configured in the **Open terminal session** action:

:::image type="content" source="media/error-communicating-with-the-emulator/open-terminal-session-action.png" alt-text="Screenshot that shows the configured terminal session action.":::

## Resolution

To solve this issue, ensure that the Reflection Desktop Application Programmer Interface in the **Feature Selection** is installed for Power Automate for desktop. For more information, see [How to install the Reflection Desktop Application Programmer Interface option](https://portal.microfocus.com/s/article/KM000002924).

:::image type="content" source="media/error-communicating-with-the-emulator/micro-focus-reflection-desktop-configuration.png" alt-text="Screenshot that shows the Application Programmer Interface feature in the Micro Focus Reflection Desktop installation.":::

> [!NOTE]
> Power Automate for desktop only communicates through the .NET interface of Reflection Desktop when using a 3270, 5250, or a UNIX and OpenVMS session.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
