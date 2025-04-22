---
title: The Remote Desktop Wasn't Found Error
description: Solves an error that occurs when you use Remote Desktop Protocol (RDP) or Citrix automation in Microsoft Power Automate.
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 04/22/2025
---
# A desktop flow fails with the "The remote desktop wasn't found" error

This article helps you resolve an issue where a flow fails with the "The remote desktop wasn't found" error when using Microsoft Remote Desktop Protocol (RDP) or Citrix automation in Microsoft Power Automate.

## Symptoms

A flow using [Remote Desktop Protocol (RDP) or Citrix automation](/power-automate/desktop-flows/virtual-desktops) that previously ran successfully might start failing with the following error:

> The remote desktop wasn't found.

This issue is more common in Citrix Virtual Apps.

## Cause 1

The names of the RDP window, Citrix Desktop, or Citrix Virtual Apps might have changed since the original [UI elements](/power-automate/desktop-flows/virtual-desktops#distinguish-ui-elements-captured-on-virtual-desktops) were captured. Tracking these elements with the old name can fail.

### Resolution

To solve this issue:

1. Ensure the affected RDP window, Citrix Desktop, or Citrix Virtual Apps is active.
2. Locate the desktop element causing the issue in the [UI elements](/power-automate/desktop-flows/ui-elements#ui-elements) pane in the flow designer. Double-click it to open the selector editor.

   :::image type="content" source="media/error-remote-desktop-not-found/control-repo-desktop.png" alt-text="Screenshot of the Power Automate elements section with a Citrix desktop element highlighted.":::

3. Select the **Repair** button and capture the new desktop or app. Review the suggested changes and accept them. For more information, see [Repair a selector](/power-automate/desktop-flows/repair-selector).

   :::image type="content" source="media/error-remote-desktop-not-found/rdp-selector-builder-repair.png" alt-text="Screenshot of the Power Automate selector builder window with the Repair button highlighted.":::

4. After accepting the changes, select **Test** to verify the new selector. For more information, see [Test a selector](/power-automate/desktop-flows/test-selectors).

5. (Optional) Use the **New** button to add more fallback selectors for the desktop.

## Cause 2

When you use Citrix Virtual Apps with certain applications, especially when interacting with combo box lists, an incorrect target desktop selector might be created using an ordinal value (for example, **eq**) instead of a more robust selection method.

### Resolution

To solve this issue:

1. Ensure the affected RDP window, Citrix Desktop, or Citrix Virtual Apps is active.
2. Locate the desktop element causing the issue in the [UI elements](/power-automate/desktop-flows/ui-elements#ui-elements) pane in the flow designer. Double-click it to open the selector editor.

   :::image type="content" source="media/error-remote-desktop-not-found/control-repo-desktop.png" alt-text="Screenshot of the Power Automate elements section with a Citrix app element highlighted.":::

3. Check if the selector is using an ordinal value (the **eq** is selected.) If it is, clear the value and save the change.

   :::image type="content" source="media/error-remote-desktop-not-found/rdp-selector-builder-ordinal.png" alt-text="Screenshot of the Power Automate selector builder window with an ordinal attribute checkbox cleared.":::

4. Select **Test** to verify the new selector. For more information, see [Test a selector](/power-automate/desktop-flows/test-selectors).

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
