---
title: Report not found or Cannot Open Report
description: Provides a solution to errors that occur when you try to print a report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Report not found" or "Cannot Open Report" Error message when you try to print a report in Microsoft Dynamics GP

This article provides a solution to errors that occur when you try to print a report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849402

## Symptoms

When you try to print a report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive one of the following error messages.

Error message 1  
> Report not found

Error message 2  
> Cannot Open Report

## Cause

This problem may occur if the Reports.dic file has been renamed, deleted, or damaged. So the modified report or the custom report that you're trying to print can't be found.

## Resolution

To resolve this problem, make sure that the Reports.dic file is located where it should be. To do it, follow these steps:

1. Locate the Reports.dic file. To do it, follow these steps:

    1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    1. If you're prompted for the password, type the system password.
    1. Use the appropriate step:
        - In Microsoft Dynamics GP, select **Microsoft Dynamics GP** in the Edit Launch File window.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Great Plains** in the Edit Launch File window.
    1. > [!NOTE]
       > The path that appears in the **Reports** box.
    1. Select **OK** to close the Edit Launch File window.

2.Make sure that the Reports.dic file is located where it should be.
3.If the Reports.dic is missing, restore the file from a backup copy.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
