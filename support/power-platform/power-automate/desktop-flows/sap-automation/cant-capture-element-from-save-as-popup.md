---
title: Troubleshoot Capturing Elements from SAP Save As Dialog
description: Resolves an issue in which the element picker can't capture elements from the SAP _Save As_ dialog box in Power Automate for desktop automation.
ms.reviewer: iomimtso, ststavri, nimoutzo, v-shaywood
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/19/2025
---
# Can't capture elements from SAP Save As dialog

Automating SAP processes in Power Automate Desktop often involves interacting with various system dialogs, including the _Save As_ dialog. However, capturing elements from the _Save As_ dialogs by using the element picker isn't always straightforward. This article provides effective strategies and workarounds to help you automate SAP workflows that interact with the _Save As_ dialog when the standard element picker methods aren't sufficient.

## Symptoms

When you use the element picker in Power Automate for desktop, you can't capture or select any elements from the _Save As_ dialog box in SAP.

## Cause

This issue can occur due to the following causes:

- SAP shows the standard Windows _Save As_ dialog box. The standard dialog box doesn't support SAP-specific automation.
- SAP shows a custom _Save As_ dialog box, but the element picker might not maintain the SAP context when the dialog box opens. This problem prevents the element picker from capturing elements from the custom SAP dialog box.

## Solution

Use one of the following workarounds based on your scenario.

### Disable Show Microsoft Windows dialogs

- If the **Show native Microsoft Windows dialogs** option is available, turn it off in the SAP GUI:

   1. Go to **Options** > **Accessibility & Scripting** > **Scripting**.

   1. Clear the **Show native Microsoft Windows dialogs** checkbox.

       :::image type="content" source="media/cant-capture-element-from-save-as-popup/sap-disable-windows-dialogs.png" alt-text="Show native Microsoft Windows dialogs in SAP Settings.":::

   1. Restart SAP.

- If the **Show native Microsoft Windows dialogs** option isn't available, make sure that the element picker is in the SAP context to display the custom SAP dialog box:

    1. Open the element picker.

    1. Before the _Save As_ dialog appears, hover over an SAP GUI element in the main SAP window. This action keeps the element picker in SAP context and lets it capture elements from the custom SAP dialog box.

### Use mouse and keyboard actions

If SAP displays the standard Windows _Save As_ dialog box instead of the custom SAP dialog box, you can automate the dialog box by using mouse and keyboard actions. For more information, see [Use mouse and keyboard actions](/power-automate/desktop-flows/actions-reference/mouseandkeyboard).

## Related content

- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
