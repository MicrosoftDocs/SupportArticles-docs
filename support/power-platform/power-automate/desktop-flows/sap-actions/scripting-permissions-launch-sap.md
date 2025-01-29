---
title: Error when launching SAP
description: Solves errors in lauch sap action
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
---

# Error when launching SAP

## Case

Launch SAP Fails with the following error:

`The server threw an exception. (Exception from HRESULT: 0x80010105 (RPC_E_SERVERFAULT)): Microsoft.PowerPlatform.PowerAutomate.Desktop.Actions.SDK.ActionException: Action failed. ---> System.Runtime.InteropServices.COMException: The server threw an exception. (Exception from HRESULT: 0x80010105 (RPC_E_SERVERFAULT))`

## Solution

 The user might not have the scripting permision on SAP. Check and enable the scripting for the users that need to use the SAP actions.
