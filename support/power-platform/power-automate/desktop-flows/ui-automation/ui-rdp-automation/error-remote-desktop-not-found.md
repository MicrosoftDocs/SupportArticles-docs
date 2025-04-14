---
title: Error "The remote desktop wasn't found"
description: Solves an issue that occurs when on runtime the flow fails with 'The remote desktop wasn't found'
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---
# Error "The remote desktop wasn't found"

This article helps you resolve an issue you might encounter when a flow fails with error 'The remote desktop wasn't found'.

## Symptoms

A flow using RDP/Citrix automation used to run successfully but it started failing with error 'The remote desktop wasn't found'. It might even never run successfully. This issue is more common in Citrix Virtual Apps.

## Cause 1

The RDP Window/Citrix Desktop/Virtual App might changed name since when the elements were captured and tracking them with the old name fails.

### Resolution

You can repair the selectors used to retract the RDP Window/Citrix Desktop/Virtual App like normal window selectors:

1. Make sure the affected RDP Window/Citrix Desktop/Virtual App is up.
2. Find the desktop element that has the problem in the "UI Elements" pane on Designer and double click it to open the selector editor.

   :::image type="content" source="media/error-remote-desktop-not-found/control-repo-desktop.png" alt-text="Screenshot of the Power Automate elements section with a Citrix desktop element highlighted.":::

3. Select on "Repair" button and capture the new Desktop/App. Check the suggested changes and accept them.

   :::image type="content" source="media/error-remote-desktop-not-found/rdp-selector-builder-repair.png" alt-text="Screenshot of the Power Automate selector builder window with the repair button highlighted":::

4. After Accepting the changes, select "Test" to test the new selector.
5. [Optionally if needed] You can use the "New" Button to add more fallback selectors for the desktop.

## Cause 2

The usage of Citrix Virtual App with certain applications causes the creation of incorrect target desktop selector using ordinal, especially when interacting with combo box lists.

### Resolution

1. Make sure the affected RDP Window/Citrix Desktop/Virtual App is up.
2. Find the desktop element that has the problem in the "UI Elements" pane on Designer and double click it to open the selector editor.

   :::image type="content" source="media/error-remote-desktop-not-found/control-repo-desktop.png" alt-text="Screenshot of the Power Automate elements section with a Citrix app element highlighted.":::

3. Check if the selector is using ordinal (eq is checked). If it uses, **uncheck** it and save it.

   :::image type="content" source="media/error-remote-desktop-not-found/rdp-selector-builder-ordinal.png" alt-text="Screenshot of the Power Automate selector builder window with ordinal attribute checkbox unchecked":::

4. Click on the "Test" to test the new selector.
