---
title: Error message when you access Microsoft Dynamics GP Utilities
description: This article provides a resolution for a problem that occurs when you access Microsoft Dynamics GP 10.0 Utilities.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/16/2024
---
# Error message when you access Microsoft Dynamics GP Utilities (There was a problem ascertaining product version information. Microsoft Dynamics GP Utilities will now exit. Check DUinstall.log for more information)

This article helps you resolve the problem that occurs when you access Microsoft Dynamics GP Utilities.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952054

## Symptoms

When you access Microsoft Dynamics GP Utilities, you receive the following error message:

> There was a problem ascertaining product version information. Microsoft Dynamics GP Utilities will now exit. Check DUinstall.log for more information.

## Cause

This problem occurs because a sub-feature version cannot update to Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. On the computer on which the error message occurs, open the Data subfolder in the Microsoft Dynamics GP folder. By default, the folder is located in the following path:

   `C:\Program Files\Microsoft Dynamics\GP`

2. In Notepad or in another text editor, open the Duinstall.log file.
3. Locate the bottom of the file where you the most recent information exists.
4. Verify the date and the time when you receive the error message in Microsoft Dynamics GP, and then compare the date and the time to the information that is in the Duinstall.log file.

    > [!NOTE]
    > The Duninstall.log file contains details for each install or upgrade attempt for the installation.

    In the Duinstall.log file, you may find a message that resembles the following:

    > Failure encountered ON 12/10/2024. Error: Product 949 does not support upgrading from version 9.XX.X.

    In this example, product 949 is at a version that cannot be updated. Product 949 is the field service.

5. You must verify the version information for the failing sub-feature that is listed in the Duninstall.log file. To do this, run the following script in Query Analyzer or in SQL Server Management Studio:

    ```sql
    select * from DYNAMICS..DB_Upgrade where PRODID = '<XXXX>'
    ```

    > [!NOTE]
    > In this script, replace **\<XXXX>** with the sub-feature product ID that is listed in the Duinstall.log file.

   The version for this sub-feature must be the correct version to update to Microsoft Dynamics GP.
