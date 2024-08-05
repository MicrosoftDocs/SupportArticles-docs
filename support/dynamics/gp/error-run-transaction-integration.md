---
title: Error when you run a transaction integration in Integration Manager
description: This article provides a resolution for the problem that occurs after you upgrade from Integration Manager 8.0 to Integration Manager 9.0.
ms.topic: troubleshooting
ms.reviewer: theley, dlanglie, kvogel
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error message when you run a transaction integration in Integration Manager in Microsoft Dynamics GP 9.0 (Distribution account does not have a default)

This article helps you resolve the problem that occurs after you upgrade from Integration Manager 8.0 to Integration Manager 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 923384

## Symptoms

You upgrade from Integration Manager in Microsoft Business Solutions - Great Plains 8.0 to Integration Manager in Microsoft Dynamics GP 9.0. Then, you run a transaction integration in Integration Manager in Microsoft Dynamics GP 9.0 that had run successfully in Integration Manager in Microsoft Business Solutions - Great Plains 8.0. In this situation, you receive the following error message:

> Distribution account does not have a default.

## Cause

This problem occurs because the IM.ini file in Integration Manager in Microsoft Dynamics GP 9.0 contains a switch that turns optimized filtering on and off. By default, the switch is on. The syntax for the switch is as follows.

```ini
UseOptimizedFiltering=True
```

When this switch is on, Integration Manager more carefully filters the data files that are being integrated. If the data in the files is not identical, Integration Manager will not integrate the record into Microsoft Dynamics GP 9.0.

## Resolution

To resolve this problem, use either of the following methods.

- Method 1

    Turn the switch off. To do this, change the syntax as follows.

    ```ini
    UseOptimizedFiltering=False
    ```

- Method 2

    Rename the IM.ini file as IM.oldini, and then restart Integration Manager.
