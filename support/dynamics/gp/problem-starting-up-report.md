---
title: Problem starting up report
description: Provides a solution to errors that occur when you try to start Microsoft Dynamics GP, or you try to print a report.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Unable to open dictionary C:\DYNAMICS\REPORTS.DIC" and "Problem starting up report" error messages when you try to print a report

This article provides a solution to errors that occur when you try to start Microsoft Dynamics GP, or you try to print a report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872062

## Symptoms

You try to start Microsoft Dynamics GP, or you try to print a report. When you do it, you receive the following error messages:
> Unable to open dictionary C:\DYNAMICS\REPORTS.DIC

> Problem starting up report

## Cause

This issue occurs because permissions were granted to modified reports. However, the reports dictionary in which the reports are stored was renamed, deleted, or removed.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Verify where the REPORTS.DIC file should be located. To do it, view the DYNAMICS.SET file. Then, verify that the REPORTS.DIC file exists in that location.

If the REPORTS.DIC file doesn't exist in that location, use one of the following procedures:

- Locate the REPORTS.DIC file, and then move it to the specified path.
- Change the path in the DYNAMICS.SET file to reflect where the REPORTS.DIC is currently located.

    To do it, use one of the following procedures:
  - Change the path by editing the launch file (DYNAMICS.SET), and then enter the correct location of the reports dictionary.
  - Edit the launch file within the application. For Microsoft Business Solutions - Great Plains 8.0, follow these steps:

    1. Select **Tools**, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    2. Under **Product ID**, select the ID of **0**.
    3. Under **Dictionary Locations**, select the lookup folder for Reports, and then browse to the Reports.dic file.
    4. Select the Reports.dic file, and then select **OK**.

    For Microsoft Dynamics GP 9.0, follow these steps:

    1. Select **Tools**, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    2. Under **Product ID**, select the ID of **0**.
    3. Under **Dictionary Locations**, select the lookup folder for Reports, and then browse to the Reports.dic file.
    4. Select the Reports.dic file, and then select **OK**.

    For Microsoft Dynamics GP 2010 or for Microsoft Dynamics GP 10.0, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, select **Tools**, point to **Setup**, point to **System**, and then select **Edit Launch File**.
    2. Under **Product ID**, select the ID of **0**.
    3. Under **Dictionary Locations**, select the lookup folder for Reports, and then browse to the Reports.dic file.
    4. Select the Reports.dic file, and then select **OK**.This procedure should populate the Dictionary paths at the bottom of the window. You can change the path of the REPORTS.DIC file by reentering the path in the **Reports.dic** field.

### Method 2

Re-create the REPORTS.DIC file.

For more information about how to do it, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).
