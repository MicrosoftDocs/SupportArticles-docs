---
title: Field List button is missing
description: Provides a solution to an issue where the Field List button is missing on the Developer tab in Word Templates in Microsoft Dynamics GP 2010.
ms.reviewer: theley, beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Field List button is missing on the Developer tab in Word Templates in Microsoft Dynamics GP 2010

This article provides a solution to an issue where the **Field List** button is missing on the **Developer** tab in Word Templates in Microsoft Dynamics GP 2010.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2606901

## Symptoms

When you select the **Developers** tab in Microsoft Dynamics GP Word Templates using either Microsoft Word 2010 or Microsoft Office Word 2007, the **Field List** button is missing.

## Cause

The Microsoft Dynamics GP Add-in for Microsoft Word is disabled.

## Resolution

To re-enable Microsoft Dynamics GP Add-in for Microsoft Word, follow these steps:

1. In the Microsoft Office application, select the **File** tab (for Microsoft Office 2010) or the Microsoft Office button (for Microsoft Office 2007).
2. Select **Options**.
3. Select **Add-ins**.
4. In the View and manage Microsoft Office Add-in pane, verify that the Microsoft Dynamics GP Add-in for Microsoft Word Add-in appears under the Disable Applications Add-ins section.
5. In the Manage field at the bottom of the screen, select **Disable Items** from the dropdown list, and then select **Go**.  
6. The Disabled Items window will appear, select the Microsoft Dynamics GP Add-in for Microsoft Word Add-in, and then select **Enable**.
7. Select **Close**.

Now the **Field List** button should be available on the Developers tab.
