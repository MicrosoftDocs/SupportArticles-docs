---
title: Troubleshoot Capturing Elements from SAP Save As Dialog
description: Resolves an issue in which the element picker can't capture elements from the SAP _Save As_ dialog box in Power Automate for desktop automation.
ms.reviewer: iomimtso, ststavri, nimoutzo, v-shaywood
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/19/2025
---
# Can't capture elements from SAP Save As dialog

This article helps you resolve an issue in which the element picker can't capture elements from the _Save As_ dialog box in SAP automation with Power Automate for desktop.

## Symptoms

When you use the element picker in Power Automate for desktop, you can't capture or select any elements from the _Save As_ dialog box in SAP.

## Cause

SAP displays different _Save As_ dialog boxes depending on whether SAP GUI Scripting is enabled:

- _SAP GUI Scripting disabled_: SAP uses the standard Windows _Save As_ dialog box. The standard box doesn't support SAP-specific automation.
- _SAP GUI Scripting enabled_: SAP displays a custom dialog box. The custom box supports automation through SAP-specific actions.

If you enable _SAP GUI Scripting_, the element picker might not maintain the SAP context when the _Save As_ dialog box opens. This issue prevents the element picker from capturing elements from the custom SAP dialog box.

## Solution 1: SAP GUI Scripting is enabled

To make sure that the element picker can capture elements from the SAP _Save As_ dialog box, follow these steps:

1. Open the element picker.

1. Before the _Save As_ dialog appears, hover over an SAP GUI element in the main SAP window. This action keeps the element picker in SAP context and lets it capture elements from the custom SAP dialog box.

1. If the **Show native Microsoft Windows dialogs** option is available, turn it off in the SAP GUI:

   1. Go to **Options** > **Accessibility & Scripting** > **Scripting**.

   1. Clear the **Show native Microsoft Windows dialogs** checkbox.

       :::image type="content" source="media/cant-capture-element-from-save-as-popup/sap-disable-windows-dialogs.png" alt-text="Show native Microsoft Windows dialogs in SAP Settings.":::

   1. Restart SAP.

## Solution 2: SAP GUI Scripting is disabled

If SAP displays the standard Windows _Save As_ dialog box instead of the custom SAP dialog box, you can automate the dialog box by using mouse and keyboard actions. For more information, see [Use mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard).

## Related content

- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
