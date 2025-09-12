---
title: RPC Server is unavailable
description: Provides a solution to an error that occurs when you run an integration in Integration Manager for Microsoft Dynamics GP 10.0.
ms.reviewer: theley, kvogel, dlanglie
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# "RPC Server is unavailable" Error message when you run an integration in Integration Manager for Microsoft Dynamics GP 10.0

This article provides a solution to an error that occurs when you run an integration in Integration Manager for Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943948

## Symptoms

When you run an integration in Integration Manager for Microsoft Dynamics GP 10.0, you receive the following error message:
> RPC Server is unavailable

## Cause

This problem occurs when Integration Manager tries to connect to Microsoft Dynamics GP. However, Integration Manager is already connected to Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. Exit Integration Manager.
2. Start Integration Manager.
3. Run an integration.

## More Information

If you continue to receive the error message that is mentioned in the "Symptoms" section, follow these steps:

1. Exit Integration Manager, and then exit Microsoft Dynamics GP.
2. Press CTRL+ALT+DELETE, and then select **Task Manager**.
3. Select the **Processes** tab.
4. If a **Dynamics.exe** process is listed, select the **Dynamics.exe** process, and then select **End Process**.
5. Start Microsoft Dynamics GP.
6. Start Integration Manager.
7. Run an integration.
