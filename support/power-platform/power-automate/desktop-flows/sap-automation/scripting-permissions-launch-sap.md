---
title: The Server Threw an Exception When Opening SAP
description: Solves an error that occurs when a user tries to open the SAP application automated by Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\SAP automation
ms.date: 03/03/2025
---
# The server threw an exception when opening SAP

This article helps you resolve an error that occurs when a user tries to open the SAP application automated by Power Automate for desktop.

## Symptoms

When a user tries to open the SAP application, they receive the following error message:

> The server threw an exception. (Exception from HRESULT: 0x80010105 (RPC_E_SERVERFAULT)): Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Action failed. ---> System.Runtime.InteropServices.COMException: The server threw an exception. (Exception from HRESULT: 0x80010105 (RPC_E_SERVERFAULT))

## Cause

This issue can occur if the user doesn't have scripting permissions to use the SAP actions.

## Resolution

To solve the issue, [check and enable the SAP scripting](/power-automate/guidance/rpa-sap-playbook/prerequisites#sap-gui-scripting-configuration) for the user who needs to use the SAP actions.

## More information

[Introduction to SAP GUI–based RPA in Power Automate Desktop](/power-automate/guidance/rpa-sap-playbook/introduction)

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
