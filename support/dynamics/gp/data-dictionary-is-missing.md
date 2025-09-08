---
title: Data dictionary is missing
description: Provides a solution to an error that occurs when you try to start or when you try to print a report in Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Data dictionary is missing" Error message when you try to start or when you try to print a report in Report Writer in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to start or when you try to print a report in Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872699

## Symptoms

When you try to start Microsoft Dynamics GP or when you try to print a report in Report Writer, you receive the following error message:
> Data dictionary is missing

## Cause

This problem occurs if either of the following conditions is true:

- The Dynamics.set file is pointing to the REPORTS.DIC file incorrectly. See [Resolution 1](#resolution-1).
- The Dynamics.set file is corrupted. See [Resolution 2](#resolution-2).

## Resolution 1

To resolve this problem, follow these steps:

1. On the **Tools** menu, select **Setup**, select **System**, and then select **Edit Launch File**.
2. Select the Microsoft Dynamics GP product, and then make sure that the path of the REPORTS.DIC file is correct.

    > [!NOTE]
    > The path may be pointing to a nonexistent folder. If this is true, change the path, and then restart Microsoft Dynamics GP.

## Resolution 2

If the path of the Reports.dic file is correct, the Dynamics.set file may be corrupted. To resolve this problem, copy the Dynamics.set file from another computer. To do it, follow these steps:

1. Rename the current Dynamics.set file.
2. Copy the Dynamics.set file from another computer that contains the same modules and doesn't receive the error message.
    > [!NOTE]
    > If the location of the Microsoft Dynamics GP installation folder is differerent between each computer, you will have to change the paths to the dictionary files in the new Dynamics.set file.
