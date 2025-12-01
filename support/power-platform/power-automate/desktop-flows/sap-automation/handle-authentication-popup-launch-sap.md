---
title: Handle Authentication Popup When Launching SAP
description: Handle SAP authentication popups in Power Automate for desktop. Follow our step-by-step guide to handle popups and ensure smooth SAP automation.
ms.reviewer: iomimtso, ststavri, nimoutzo, v-shaywood
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/19/2025
---
# Authentication popup appears when launching SAP

This article helps you resolve an issue where an authentication popup appears when you use the **Launch SAP** action in Power Automate for desktop.

## Symptoms

When you use the **Launch SAP** action with login credentials, an authentication popup window appears unexpectedly. This issue causes the action to fail and prevents other SAP actions from running.

## Resolution

To handle the authentication popup, use UI automation actions instead of the **Launch SAP** action. Follow these steps:

1. Use the **Run application** action to start the SAP GUI application.
1. Use UI automation actions to interact with the authentication popup:
   - Use the **Populate text field in window** action to enter credentials.
   - Use the **Click UI element in window** action to submit the credentials.
1. After you handle the popup, use the **Attach to running SAP** action to connect to the active SAP instance.
1. After the SAP instance is attached, you can use any other SAP actions as needed.

 :::image type="content" source="media/handle-authentication-popup-launch-sap/authentication-popup-appears-when-launching-sap.png" alt-text="Screenshot showing Power Automate for desktop workflow with Run application, UI automation actions to handle authentication popup, and Attach to running SAP actions.":::

## More information

- [UI automation actions](/power-automate/desktop-flows/actions-reference/uiautomation)
- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
