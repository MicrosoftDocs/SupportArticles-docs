---
title: A newer version of the Human Resources application has been found error when you start
description: Describes a problem that occurs if all workstations do not have the same version of Human Resources installed. A resolution is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "A newer version of the Human Resources application has been found. You have version 0.0.0." error when you start Microsoft Dynamics GP

This article provides a resolution for the issue that **A newer version of the Human Resources application has been found** this error occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872002

## Symptoms

When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, you receive the following error message:

> A newer version of the Human Resources application has been found. You have version 0.0.0. Please contact the Administrator to upgrade.

This problem occurs in Human Resources in Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. Verify that all the workstations have the same version of Human Resources installed. To determine the version, select **About Microsoft Dynamics GP** on the **Help** menu.

2. If a workstation does not have the same version, install the service pack for the correct version.

If all the workstations have the same version of Human Resources installed and you still receive the error message, follow these steps:

1. Make sure that all users are logged off from Microsoft Dynamics GP.

2. In SQL Query Analyzer, run the following script against the DYNAMICS database.

    ```sql
    DELETE SYVM1000 WHERE PRODID=414
    ```

    > [!NOTE]
    > This script removes any occurrences of the `VERSIONSTRING_I` that reference Human Resources.

3. Start Microsoft Dynamics GP.

> [!NOTE]
> After you log on to Microsoft Dynamics GP, the records in the `SYVM1000` table are re-created. Therefore, you should not receive the error message.
