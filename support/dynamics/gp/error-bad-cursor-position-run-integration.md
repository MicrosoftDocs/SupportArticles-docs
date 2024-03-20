---
title: Bad Cursor Position error when an integration is run in Integration Manager for Microsoft Dynamics GP 10.0
description: This article gives the steps to resolve an error message in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error message when an integration is run in Integration Manager for Microsoft Dynamics GP 10.0: "Bad Cursor Position"

This article gives the steps to resolve an error message in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 967741

## Symptoms

You receive the following error message in Integration Manager for Microsoft Dynamics GP 10.0:
> Bad Cursor Position

## Cause

This issue occurs because the source file had data that wasn't valid at the end of the file. In the integration, this data was filtered out. But, you still receive the error message.

## Resolution

To resolve this issue, follow these steps:

1. Browse to the Integration Manager installation directory, and then open the Microsoft.Dynamics.GP.IntegrationManager.ini file.
2. In this file, locate the following switch.

    `[IMBaseProvider]`

3. Directly under this switch, locate the following line.

    `UseOptimizedFiltering=True`

4. Change value of the **UseOptimizedFiltering** switch to **False**.

## More information

You must exit Integration Manager and then restart Integration Manager for the new setting to take effect.

If you set the value of the **UseOptimizedFiltering** switch to **False** in Integration Manager 10.0, the filter on the Integration Source doesn't work. To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP 10.0.
