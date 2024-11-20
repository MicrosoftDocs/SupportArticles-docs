---
title: The specified module could not be found error
description: Solves the error that occus when you use the Open terminal session action with a HLLAPI provider in Power Automate for desktop.
ms.reviewer: nimoutzo
ms.date: 11/20/2024
ms.custom: sap:Desktop flows
---
# "The specified module could not be found" error when using the Open terminal session action

This article provides a resolution for an error that occurs when you use the **Open terminal session** action with a HLLAPI provider in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

When you use the [Open terminal session](/power-automate/desktop-flows/actions-reference/terminalemulation) action to open a new connection with a HLLAPI provider, you receive the following error message:

> The specified module could not be found.

## Cause

The terminal emulator requires access to some extra DLL files that aren't present in the Power Automate for desktop installation directory.

## Resolution

1. Find out what DLL files might be needed:

    1. In the terminal emulator installation directory, locate the HLLAPI DLL file referenced in the **Open terminal session** action.

    1. Use [Process Hacker](https://processhacker.sourceforge.io/) (or a similar tool) to identify its dependencies.
    1. In Process Hacker, select **Tools** > **Inspect executable file**.

       :::image type="content" source="media/terminal-not-found/inspect-executable-file.png" alt-text="The Inspect executable file option in Process Hacker.":::

    1. Select the HLLAPI DLL file and go to the **Imports** tab. The tab shows all the DLL files that the HLLAPI DLL file depends on.

       :::image type="content" source="media/terminal-not-found/imports-tab-dll-files.png" alt-text="Screnshot of the Imports tab that contains the HLLAPI DLL files.":::

1. Copy the DLL files from the terminal emulator installation directory to the Power Automate for desktop installation directory. The default installation path for Power Automate for desktop is usually _C:\Program Files (x86)\Power Automate Desktop_.
