---
title: Can't capture elements from SAP Save As dialog
description: Resolves an issue where the element picker can't capture elements from the Save As dialog in SAP automation with Power Automate for desktop.
ms.reviewer: ststavri, nimoutzo
ms.author: iomimtso
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11-19-2025
---
# Can't capture elements from SAP Save As dialog

This article helps you resolve an issue where the element picker can't capture elements from the **Save As** dialog in SAP automation with Power Automate for desktop.

## Symptoms

When you use the element picker in Power Automate for desktop, you can't capture or select any elements from the **Save As** dialog in SAP.

## Cause

SAP displays different **Save As** dialogs depending on whether SAP GUI Scripting is enabled:

- **SAP GUI Scripting disabled**: SAP uses the standard Windows **Save As** dialog, which doesn't support SAP-specific automation.
- **SAP GUI Scripting enabled**: SAP displays a custom dialog that supports automation through SAP-specific actions.

The element picker may not maintain SAP context when the dialog opens, preventing it from capturing elements from the custom SAP dialog.

## Resolution

To ensure the element picker can capture elements from the SAP **Save As** dialog:

1. Open the element picker.
2. Before the **Save As** dialog appears, hover over an SAP GUI element in the main SAP window. This keeps the element picker in SAP context and lets it capture elements from the custom SAP dialog.
3. If available, turn off the "Show native Microsoft Windows dialogs" option in SAP GUI: go to **Options** > **Accessibility & Scripting** > **Scripting**. Restart SAP after you change this setting.

 :::image type="content" source="media/cant-capture-element-from-save-as-popup/sap_disable_windows_dialogs.png" alt-text="Show native Microsoft Windows dialogs in SAP Settings.":::

### Alternative solution

If SAP displays the standard Windows **Save As** dialog instead of the custom SAP dialog, you can automate the dialog using mouse and keyboard actions. For more information, see [Use mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard).

## More information

[Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
