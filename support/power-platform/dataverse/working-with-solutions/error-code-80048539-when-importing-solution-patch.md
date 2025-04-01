---
title: Error code 80048539 when importing solution patch
description: Error code 80048539 occurs when you try to import solution patch in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Error code 80048539 occurs when trying to import solution patch in Microsoft Dynamics 365

This article provides a resolution for the error code **80048539** that may occur when you try to import a solution patch in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471087

## Symptoms

When you try to import a solution patch in Microsoft Dynamics 365, you encounter the following error:

> The import of solution: [solution patch name] failed.  
Error code 80048539.

If you download the log file and open it in Excel, you see more details such as the following:

**Symptom 1 Details:**

> Failure 0x80048539  
Solution manifest import: FAILURE: Patch version 1.0.1.0 is invalid for parent version 1.1.0.0

**Symptom 2 Details:**

> Failure 0x80048539  
Solution manifest import: FAILURE: Holding solution MyPatchTesting_Upgrade already exists.

## Cause

> [!NOTE]
> If you're using make.powerapps.com to import your unmanaged solution update and get this error Microsoft is aware of the issue and is working on a fix. To work around the issue open the **Advanced** settings and select the option **Update (not recommended)**.

Error code **80048539** indicates an invalid patch is being imported. There are a few potential causes including the following:

### Cause 1

If you see the error details mentioned in the Symptom 1 Details section mentioned above:

The solution patch version is lower than the version of the solution already installed. For example: A solution named SolutionA is already installed with version 1.1.0.0 and you're trying to import a patch that is version 1.0.1.0.

### Cause 2

If you see the error details mentioned in the Symptom 2 Details section mentioned above:

This can occur if you already have an upgrade imported for that solution but it hasn't yet been applied. After importing a solution that is an upgrade of an existing solution, the end of the solution import provides a button to apply the solution upgrade. If you didn't select that button during a prior import of a solution upgrade for this solution, you need to locate the solution in your solutions list and select the **Apply Solution Upgrade** button.

## Resolution

### Resolution 1

If you see the error details mentioned in the Symptom 1 Details section mentioned above:

Verify the solution patch version you're trying to import is a higher version than the solution already installed.

### Resolution 2

If you see the error details mentioned in the Symptom 2 Details section mentioned above:

Navigate to **Settings**, **Customizations**, and then select **Solutions**. Select the existing installed solution you're trying to upgrade and then select **Apply Solution Upgrade**.
