---
title: Error when you run an integration for the Sales Transaction destination by using the Great Plains destination adapter in Integration Manager
description: Describes a problem that occurs when you import an invoice and then map a field in the Markdown folder. A service pack is available that resolves this problem in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: kvogel
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Error when you run an integration for the Sales Transaction destination by using the Great Plains destination adapter in Integration Manager: "Could not determine the window for scrolling window"

This article solves an issue that occurs when you import an invoice and then map a field in the Markdown folder.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 938564

## Symptoms

When you run an integration for the Sales Transaction destination by using the Great Plains destination adapter, you receive the following error message:

> #*** Could not determine the window for scrolling window 'SOP_Entry' of form 'SOP_Entry' (6,619,0,1,0). You may need to create an association. (0x80040009) in IMDyeE80.CallbackHandler.DoMacro

This problem occurs if you map a field in the Markdown folder in the Destination Mapping window. This problem occurs in Integration Manager for Microsoft Dynamics GP and for Microsoft Business Solutions - Great Plains.

## Resolution

### Microsoft Business Solutions - Great Plains 8.0

To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Business Solutions - Great Plains 8.0.
