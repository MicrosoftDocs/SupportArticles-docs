---
title: MsiApplyMultiplePatches returns 1601 error
description: This article provides a resolution for an error 1601 that occurs when the UI mode is set to Basic or None.
ms.date: 04/27/2020
ms.custom: sap:Installation\Servicing updates and service packs
ms.reviewer: kelho
---
# MsiApplyMultiplePatches returns error 1601

This article helps you resolve the 1601 error that occurs when the UI mode is set to **Basic** or **None**.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 2700568

## Symptoms

`MsiApplyMultiplePatches` may result in the `MainEngineThread` returning and error of 1601 when the UI mode is set to **Basic** or **None**.

Example of log file showing the failure:

> MSI (c) (28:E8) [10:30:06:121]: Client-side and UI is none or basic: Running entire install on the server.  
> MSI (c) (28:E8) [10:30:06:121]: Grabbed execution mutex.  
> MSI (c) (28:E8) [10:30:06:157]: Cloaking enabled.  
> MSI (c) (28:E8) [10:30:06:157]: Attempting to enable all disabled privileges before calling Install on Server.  
> MSI (c) (28:E8) [10:30:06:160]: Incrementing counter to disable shutdown. Counter after increment: 0.  
> MSI (c) (28:E8) [10:30:06:162]: Decrementing counter to disable shutdown. If counter >= 0, shutdown will be denied.  Counter after decrement: -1.  
> MSI (c) (28:E8) [10:30:06:162]: MainEngineThread is returning 1601.

## Cause

If you try and apply greater than 85 patches by using `MsiApplyMultiplePatches`, it will result in the failure.

## Resolution

- Use multiple calls to `MsiApplyMultiplePatches` instead of one call with 85 or greater patches.
- Use minor update (service pack) to base line the product. A service pack will contain all updates up till that point in time. This reduces the number of patches that you would have to apply by using the `MsiApplyMultiplePatches` API.

## More information

For more information about the `MsiApplyMultiplePatches`, see [MsiApplyMultiplePatches function](/windows/win32/api/msi/nf-msi-msiapplymultiplepatchesa).
