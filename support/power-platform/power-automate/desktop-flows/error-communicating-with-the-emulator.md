---
title: Error communicating with the emulator
description: Provides a resolution when “Error communicating with the emulator” occurs, while calling the "Open terminal session" action in Power Automate for desktop.
ms.author: iomavrid
author: YiannisMavridis
ms.reviewer: tapanm
ms.date: 10/11/2022
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Error communicating with the emulator using Micro Focus Reflection Desktop

This article provides a resolution when “Error communicating with the emulator” occurs, while calling the "Open terminal session" action using Micro Focus Reflection Desktop in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

The message “Error communicating with the emulator” occurs when running the "Open terminal session" action with Reflection Desktop in Power Automate for desktop.

Here are the parameters are configured in the "Open terminal session" action:

:::image type="content" source="media/error-communicating-with-the-emulator/open-terminal-session-action.png" alt-text="Screenshot shows the configured terminal session action.":::

## Resolution

The Reflection Desktop “Application Programmer Interface” in the Feature Selection must be installed for Power Automate for desktop to function properly.

:::image type="content" source="media/error-communicating-with-the-emulator/micro-focus-reflection-desktop-configuration.png" alt-text="Screenshot shows the Reflection Desktop installation":::

> [!NOTE]
> Power Automate for desktop will only communicate through the .NET interface of Reflection Desktop when using a 3270, 5250, or a UNIX and OpenVMS session.
