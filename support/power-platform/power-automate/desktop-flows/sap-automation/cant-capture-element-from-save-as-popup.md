---
title: Can't capture elements from SAP Save As dialog
description: Resolves an issue where the element picker can't capture elements from the Save As dialog in SAP automation with Power Automate for desktop.
ms.reviewer: iomimtso, ststavri, nimoutzo, v-shaywood
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11-19-2025
---
# Can't capture elements from SAP Save As dialog

This article helps you resolve an issue that might occur where the element picker can't capture elements from the _Save As_ dialog in SAP automation with Power Automate for desktop.

## Symptoms

When you use the element picker in Power Automate for desktop, you can't capture or select any elements from the _Save As_ dialog in SAP.

## Cause

SAP displays different _Save As_ dialogs depending on whether SAP GUI Scripting is enabled:

- _SAP GUI Scripting disabled_: SAP uses the standard Windows _Save As_ dialog, which doesn't support SAP-specific automation.
- _SAP GUI Scripting enabled_: SAP displays a custom dialog that supports automation through SAP-specific actions.

The element picker may not maintain the SAP context when the dialog opens, preventing it from capturing elements from the custom SAP dialog.

## Solution 1: SAP GUI Scripting enabled

To ensure the element picker can capture elements from the SAP _Save As_ dialog:

1. Open the element picker.
1. Before the _Save As_ dialog appears, hover over an SAP GUI element in the main SAP window.
   1. This keeps the element picker in SAP context and lets it capture elements from the custom SAP dialog.
1. If available, turn off the **Show native Microsoft Windows dialogs** option in the SAP GUI:
   1. Go to **Options** > **Accessibility & Scripting** > **Scripting**.
   1. Uncheck the **Show native Microsoft Windows dialogs** box.
   1. Restart SAP after you change this setting.

 :::image type="content" source="media/cant-capture-element-from-save-as-popup/sap_disable_windows_dialogs.png" alt-text="Show native Microsoft Windows dialogs in SAP Settings.":::

## Solution 2: SAP GUI Scripting disabled

If SAP displays the standard Windows _Save As_ dialog instead of the custom SAP dialog, you can automate the dialog using mouse and keyboard actions. For more information, see [Use mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard).

## Related content

- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
