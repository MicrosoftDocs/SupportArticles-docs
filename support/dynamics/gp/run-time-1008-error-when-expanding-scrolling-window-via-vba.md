---
title: Run-time error 1008 Unsafe Operation when expanding scrolling window via VBA
description: Describes a problem in which you receive a Run-time error 1008 Unsafe Operation error when trying to expand a scrolling window by using VBA in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, kvogel
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Run-time error '1008': Unsafe Operation" error when you expand a scrolling window by using VBA

This article provides a resolution for the run-time error 1008 that occurs when you expand a scrolling window by using VBA in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951231

## Symptoms

When you use Visual Basic for Applications (VBA) in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0 to automatically expand a scrolling window (also known as a grid in VBA), you receive the following error message:

> Run-time error '1008': Unsafe Operation. An attempt was made to set a value into an application field which is disabled. This operation could compromise the integrity of the application.

## Cause

This error occurs if the visible icon for expanding the scrolling window is a non-editable visual switch field that only contains an image. VBA does not allow for the value of a non-editable field to be changed.

## Resolution

To resolve this problem, use a hidden push button field that is overlaid with the same size and position as the visual switch icon field.

For more information about how to add a hidden field, see [How to add a hidden field by using Modifier with Visual Basic for Applications in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-add-a-hidden-field-by-using-modifier-with-visual-basic-for-applications-in-microsoft-dynamics-gp-e1e94ef9-afe6-519e-b455-43b61bb0e95d).
