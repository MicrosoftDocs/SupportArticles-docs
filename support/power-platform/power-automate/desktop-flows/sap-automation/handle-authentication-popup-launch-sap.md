---
title: Handle Authentication Popup When Starting SAP
description: Learn how to handle SAP authentication popups in Power Automate for desktop for smooth SAP automation.
ms.reviewer: iomimtso, ststavri, nimoutzo, v-shaywood
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/19/2025
---
# Authentication popup appears when starting SAP

This article helps you resolve an issue in which an authentication popup appears when you use the **Launch SAP** action in Power Automate for desktop.

## Symptoms

When you run the **Launch SAP** action by using your logon credentials, an authentication popup window appears unexpectedly. This issue causes the action to fail and prevents other SAP actions from running.

## Solution

To handle the authentication popup, use UI automation actions instead of the **Launch SAP** action. Follow these steps:

1. Use the **Run application** action to start the SAP GUI application.
1. Use UI automation actions to interact with the authentication popup:
   1. Use the **Populate text field in window** action to enter credentials.
   1. Use the **Click UI element in window** action to submit the credentials.
1. After you handle the popup, use the **Attach to running SAP** action to connect to the active SAP instance.
1. After the SAP instance is attached, you can run any other SAP actions.

 :::image type="content" source="media/handle-authentication-popup-launch-sap/authentication-popup-appears-when-launching-sap.png" alt-text="Power Automate for desktop workflow with Run application, UI automation actions to handle authentication popup, and Attach to running SAP actions.":::

## More information

- [UI automation actions](/power-automate/desktop-flows/actions-reference/uiautomation)
- [Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
